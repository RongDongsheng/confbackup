#!/bin/bash
dir=$(cd `dirname $0`;pwd)
$dir/info.sh
echo "--->Begin to kill......"
killall netperf
pkill netperf
killall netserver
echo "--->After kill......"
$dir/info.sh
