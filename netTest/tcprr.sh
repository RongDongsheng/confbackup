#!/bin/bash
dir=$(cd `dirname $0`;pwd)
. $dir/host

length=$1
count=$2
i=0;
for ((i=1;i<=count;i++))
do
    echo "Instance:$i-------"
    ./netperf -H $host -l 43200 -t TCP_RR -- -r $length,$length & #for pps
done
