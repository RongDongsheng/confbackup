#!/bin/bash
killall netperf
dir=$(cd `dirname $0`;pwd)
. $dir/host

length=$1
count=$2
i=0;
for ((i=1;i<=count;i++))
do
    #echo "Instance:$i-------"
    ./netperf -t UDP_STREAM -H 172.16.10.43 -l 240 -- -m $length & #for udp
done
