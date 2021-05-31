#!/bin/bash
dir=$(cd `dirname $0`;pwd)
. $dir/host

length=$1
count=$2
i=0;
for ((i=1;i<=count;i++))
do
    echo "Instance:$i-------"
    ./netperf -H $host -t TCP_STREAM -l 100000 -- -m $length & #for bandwidth
done
