#!/bin/bash
duration=30
prefix="test_run_once"

set -v

function write_concurrent {

	echo -e "n_concurrent: $1\n" > /tmp/concurrent.yml
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
	cpu=$2
	concurrent=$3
	exp_name=${prefix}_tpcc_${shards}shards_${cpu}cpus_${concurrent}cc
	# ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -c 1 -c 10  -s $shards -u $cpu -r 3 -d $duration $exp_name
	# ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -c 32  -s $shards -u $cpu -r 3 -d $duration $exp_name
	./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -m 2pl_ww:multi_paxos -m occ:multi_paxos  -c 200  -s $shards -u $cpu -r 3 -d $duration $exp_name
	new_experiment $exp_name
}



function tpcc_all_large {
	shards=$1
	cpu=$2
	concurrent=100
	exp_name=${prefix}_tpccTJ2O_${shards}shards_${cpu}cpus_${concurrent}cc
	write_concurrent $concurrent
	# ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -c 1 -c 10  -s $shards -u $cpu -r 3 -d $duration $exp_name
	# ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -c 1 -c 2 -c 4 -c 8 -c 16 -c 24 -c 28 -c 32  -s $shards -u $cpu -r 3 -d $duration $exp_name
	#  -m 2pl_ww:multi_paxos -m occ:multi_paxos -m tapir:tapir
	./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc --m brq:brq  -m tapir:tapir -m 2pl_ww:multi_paxos -m occ:multi_paxos -c 196  -s $shards -u $cpu -r 3 -d $duration $exp_name
	new_experiment $exp_name
}


function run_tests {
	# write_concurrent 100
	# tpcc 18 6 100
	write_concurrent 100
	tpcc_all_large 48 16
	# write_concurrent 100
	# tpcc 48 16 100

	# write_concurrent 100
	# tpcc 12 4 100
	# write_concurrent 100
	# tpcc 24 4 100
}



run_tests