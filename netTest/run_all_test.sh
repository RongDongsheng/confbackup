#!/bin/sh

output()
{
	echo "==================================================" >> $file
	echo "                    $1                      " >> $file
	echo "==================================================" >> $file
	echo -e "\nNetwork\n" >> $file
	sar -n DEV 10 1|grep Average|awk '{if($2 ~ /IFACE/) print $3 "\t" $4 "\t" $5 "\t" $6; if ($2 ~ /eth1/) print $3 "\t" $4 "\t" $5*8/1000 "M\t" $6*8/1000"M"}' >> $file
	echo -e "\nCPU Usage\n" >> $file
	mpstat -P ALL 10 1 |grep Average >> $file
	echo -e "\n\n" >> $file
}

cores=`lscpu|egrep '^CPU\(s\):'|cut -d : -f 2|sed s/[[:space:]]//g`
date=`date +%F-%T`
file="/root/netTest/test_output/$cores-cores-on-$1GNic-$date"
mkdir /root/netTest/test_output
touch $file

./kill.sh
./tcprr.sh 128 700
sleep 30
output tcprr128

sleep 20

./kill.sh
./tcprr.sh 1400 700
sleep 30
output tcprr1400

sleep 20

./kill.sh
./tcpstrem.sh 1400 $cores
sleep 30
output tcpstream1400

sleep 20

./kill.sh
./tcpstrem.sh 16384 $cores
sleep 30
output tcpstream16k

sleep 20

./kill.sh
./udpstream.sh 128 $cores
sleep 30
output udpstream128

sleep 20

./kill.sh
./udpstream.sh 1400 $cores
sleep 30
output udpstream1400
