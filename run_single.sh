#!/bin/bash
duration=30
# prefix="single_dc"
prefix="single_dc_other"

set -v

function run_tests {
	write_concurrent 100

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
	# JANUS+TAPIR
	# ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -c 1 -c 2 -c 4 -c 8 -c 16 -c 24 -c 28 -c 32 -s $shards -u $cpu -r 3 -d $duration $exp_name
	# OTHERS
	./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc  -m 2pl_ww:multi_paxos -m occ:multi_paxos -c 1 -c 2 -c 4 -c 8 -c 16 -c 24 -c 28 -c 32 -s $shards -u $cpu -r 3 -d $duration $exp_name
	
	new_experiment $exp_name
}



run_tests