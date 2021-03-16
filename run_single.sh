#!/bin/bash
duration=30
prefix="single_dc"

set -v

function run_tests {
	write_concurrent 1

	tpcc 6 
}


function write_concurrent {
	echo -e "n_concurrent: ${1}\n" > /tmp/concurrent.yml
}

function new_experiment {
	rm -rf tmp/* log/* 
	tar -czvf ~/${1}.tgz archive && rm -rf archive && mkdir -p archive
	printf '=%.0s' {1..40}
	echo
	echo "end $1"
	printf '=%.0s' {1..40}
	echo
}



function tpcc {
	shards=$1
	if [[ shards -le 3 ]]
	then
		cpu=1
	else
		cpu=2
	fi
	exp_name=${prefix}_tpcc_${shards}
	./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -c 1 -c 10 -c 100 -c 200 -c 400 -c 800 -c 1600 -c 2400 -c 2800 -c 3200 -s $shards -u $cpu -r 3 -d $duration $exp_name
	new_experiment $exp_name
}



run_tests