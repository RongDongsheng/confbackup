#!/bin/bash
dir=$(cd `dirname $0`;pwd)
echo "host=\"$1\"" >${dir}/host
