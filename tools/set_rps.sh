#!/bin/bash -x


PROCESSORS=`cat /proc/cpuinfo |grep processor |wc -l`

function log()
{
	local msg=$1
	[ -z "$msg" ] && return 1

	dir='./'
	log_dir=$dir/'log'
	[ -d $log_idr ] || mkdir -p $log_dir

	local now=`date +"%F %H:%M:%S"`
	echo "$now: $msg" >> $log_dir/set_rps.log
}

get_rps_mask() {

	local procs=${1:-24}
	local mask=
	local base=
	local bit=
	local amd=$(cat /proc/cpuinfo  |grep -i AuthenticAMD |wc -l)
	if [ $procs -gt 64 ] && [ $amd -gt 0 ];then
		echo $(python $PWD/amd_rps_setting.py)
		return
	fi

	while [ $procs -gt 0 ]
	do
		if [ $procs -gt 32 ]; then
			base=32
			let procs-=32
		else
			base=$procs
			let procs-=$procs
		fi

		bit=`printf "%x" $(( (1 << $base) - 1))`
	if [ -z $mask ]; then
	    mask=$bit
    else
	    mask=$bit",$mask"
	fi
done

    echo $mask
}


set_rps() {

    local nic_queues=`ls -l /sys/class/net/eth0/queues/ |grep -i rx |wc -l`
    if [ $nic_queues -eq 0 ]; then
	log "set_rps: the nic_queues is 0, ignored."
	return 0
    fi

    local mask=`get_rps_mask $PROCESSORS`
    local flow_entries=$(echo "$nic_queues * 4096" |bc)
    local i=0
    local old_mask=$(cat /sys/class/net/eth1/queues/rx-1/rps_cpus)

    [[ $old_mask == *$mask* ]] && return

    log "set nic mask[$mask]"
    while (($i < $nic_queues))
    do
	echo $mask > /sys/class/net/eth0/queues/rx-$i/rps_cpus
	echo 4096 > /sys/class/net/eth0/queues/rx-$i/rps_flow_cnt
	let i++
done

    echo $flow_entries > /proc/sys/net/core/rps_sock_flow_entries

    log "set_rps: mask: $mask, nic_queues: $nic_queues, flow_entries: $flow_entries. "
}

set_rps
