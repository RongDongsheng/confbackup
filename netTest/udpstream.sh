#!/bin/bash
dir=$(cd `dirname $0`;pwd)
. $dir/host

length=$1
count=$2
i=0;
for ((i=1;i<=count;i++))
do
    #echo "Instance:$i-------"
    ./netperf -t UDP_STREAM -H $host -l 43200 -- -m $length & #for udp
done
