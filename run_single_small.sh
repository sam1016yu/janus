#!/bin/bash
duration=30
concurrent=1
prefix="single_dc_small"

set -v

function run_tests {
	write_concurrent

	# tpca_fixed 3
	# zipf_graph 3
	tpcc 4 

#	rw_fixed
#	tpca_fixed
#	tpcc
#	zipf_graph_open 6
#	zipf_graph 1
#	zipf_graph 3
#	zipf_graph 6
#	rw
#	zipfs
}


function write_concurrent {
	echo -e "n_concurrent: $concurrent\n" > /tmp/concurrent.yml
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
	# ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -c 1 -c 10  -s $shards -u $cpu -r 3 -d $duration $exp_name
	./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -c 10  -s $shards -u $cpu -r 3 -d $duration $exp_name
	new_experiment $exp_name
}



run_tests