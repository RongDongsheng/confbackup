#!/bin/bash

set_rps() {
    echo 3f > /sys/class/net/eth0/queues/rx-0/rps_cpus
        echo fc0 > /sys/class/net/eth0/queues/rx-1/rps_cpus
        echo 3f000 > /sys/class/net/eth0/queues/rx-2/rps_cpus
        echo fc0000 > /sys/class/net/eth0/queues/rx-3/rps_cpus
        echo 3f000000 > /sys/class/net/eth0/queues/rx-4/rps_cpus
        echo f,c0000000 > /sys/class/net/eth0/queues/rx-5/rps_cpus
        echo 3f0,00000000 > /sys/class/net/eth0/queues/rx-6/rps_cpus
        echo fc00,00000000 > /sys/class/net/eth0/queues/rx-7/rps_cpus
        echo 3f0000,00000000 > /sys/class/net/eth0/queues/rx-8/rps_cpus
        echo fc00000,00000000 > /sys/class/net/eth0/queues/rx-9/rps_cpus
        echo 3,f0000000,00000000  > /sys/class/net/eth0/queues/rx-10/rps_cpus
        echo fc,00000000,00000000 > /sys/class/net/eth0/queues/rx-11/rps_cpus
        echo 3f00,00000000,00000000 > /sys/class/net/eth0/queues/rx-12/rps_cpus
        echo fc000,00000000,00000000 > /sys/class/net/eth0/queues/rx-13/rps_cpus
        echo 3f00000,00000000,00000000 > /sys/class/net/eth0/queues/rx-14/rps_cpus
        echo fc000000,00000000,00000000 > /sys/class/net/eth0/queues/rx-15/rps_cpus
}


set_rfs() {
    local nic_queues=`ls -l /sys/class/net/eth0/queues/ |grep -i rx |wc -l`
    local i=0

    if [ $nic_queues -eq 0 ]; then
    log "set_rps: the nic_queues is 0, ignored."
    return 0
    fi

    while (($i < $nic_queues))
    do
    echo 4096 > /sys/class/net/eth0/queues/rx-$i/rps_flow_cnt
    let i++
done
}

set_rps
set_rfs
