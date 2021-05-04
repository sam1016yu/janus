#!/bin/bash
duration=30
# prefix="test_run_all"
# prefix="test_run_all_others"
# prefix="no_dist"
# prefix="baseline"
prefix="0503_10ms_large"

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



function tpcc1 {
	shards=$1
	cpu=$2
	concurrent=100
	exp_name=${prefix}_tpccTJ_${shards}shards_${cpu}cpus_${concurrent}cc
	write_concurrent $concurrent
	# ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -c 1 -c 10  -s $shards -u $cpu -r 3 -d $duration $exp_name
	# ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -c 1 -c 2 -c 4 -c 8 -c 16 -c 24 -c 28 -c 32  -s $shards -u $cpu -r 3 -d $duration $exp_name
	#  -m 2pl_ww:multi_paxos -m occ:multi_paxos -m tapir:tapir
	./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir  -c 1 -c 2 -c 4 -c 8 -c 14 -c 16 -c 24 -c 28 -c 32  -s $shards -u $cpu -r 3 -d $duration $exp_name
	new_experiment $exp_name
}


function tpcc2 {
	shards=$1
	cpu=$2
	concurrent=1
	exp_name=${prefix}_tpccTJ_${shards}shards_${cpu}cpus_${concurrent}cc
	write_concurrent $concurrent
	# ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -c 1 -c 10  -s $shards -u $cpu -r 3 -d $duration $exp_name
	# ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -c 1 -c 2 -c 4 -c 8 -c 16 -c 24 -c 28 -c 32  -s $shards -u $cpu -r 3 -d $duration $exp_name
	#  -m 2pl_ww:multi_paxos -m occ:multi_paxos -m tapir:tapir
	./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir  -c 1 -c 10 -s $shards -u $cpu -r 3 -d $duration $exp_name
	new_experiment $exp_name
}

function tpcc3 {
	shards=$1
	cpu=$2
	concurrent=100
	exp_name=${prefix}_tpcc2O_${shards}shards_${cpu}cpus_${concurrent}cc
	write_concurrent $concurrent
	# ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -c 1 -c 10  -s $shards -u $cpu -r 3 -d $duration $exp_name
	# ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -c 1 -c 2 -c 4 -c 8 -c 16 -c 24 -c 28 -c 32  -s $shards -u $cpu -r 3 -d $duration $exp_name
	#  -m 2pl_ww:multi_paxos -m occ:multi_paxos -m tapir:tapir
	./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m 2pl_ww:multi_paxos -m occ:multi_paxos  -c 1 -c 2 -c 4 -c 8 -c 14 -c 16 -c 24 -c 28 -c 32  -s $shards -u $cpu -r 3 -d $duration $exp_name
	new_experiment $exp_name
}


function tpcc4 {
	shards=$1
	cpu=$2
	concurrent=1
	exp_name=${prefix}_tpcc2O_${shards}shards_${cpu}cpus_${concurrent}cc
	write_concurrent $concurrent
	# ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -c 1 -c 10  -s $shards -u $cpu -r 3 -d $duration $exp_name
	# ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -c 1 -c 2 -c 4 -c 8 -c 16 -c 24 -c 28 -c 32  -s $shards -u $cpu -r 3 -d $duration $exp_name
	#  -m 2pl_ww:multi_paxos -m occ:multi_paxos -m tapir:tapir
	./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc  -m 2pl_ww:multi_paxos -m occ:multi_paxos  -c 1 -c 10 -s $shards -u $cpu -r 3 -d $duration $exp_name
	new_experiment $exp_name
}

function tpcc12 {
	shards=$1
	cpu=$2
	concurrent=100
	exp_name=${prefix}_tpccTJ2O_${shards}shards_${cpu}cpus_${concurrent}cc
	write_concurrent $concurrent
	# ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -c 1 -c 10  -s $shards -u $cpu -r 3 -d $duration $exp_name
	# ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -c 1 -c 2 -c 4 -c 8 -c 16 -c 24 -c 28 -c 32  -s $shards -u $cpu -r 3 -d $duration $exp_name
	#  -m 2pl_ww:multi_paxos -m occ:multi_paxos -m tapir:tapir
	./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -m 2pl_ww:multi_paxos -m occ:multi_paxos -c 1 -c 2 -c 4 -c 8 -c 14  -s $shards -u $cpu -r 3 -d $duration $exp_name
	new_experiment $exp_name

	concurrent=1
	exp_name=${prefix}_tpccTJ2O_${shards}shards_${cpu}cpus_${concurrent}cc
	write_concurrent $concurrent
	./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -m 2pl_ww:multi_paxos -m occ:multi_paxos -c 1 -c 10  -s $shards -u $cpu -r 3 -d $duration $exp_name
	new_experiment $exp_name
}

function tpcc_all {
	shards=$1
	cpu=$2
	concurrent=100
	exp_name=${prefix}_tpccTJ2O_${shards}shards_${cpu}cpus_${concurrent}cc
	write_concurrent $concurrent
	# ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -c 1 -c 10  -s $shards -u $cpu -r 3 -d $duration $exp_name
	# ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -c 1 -c 2 -c 4 -c 8 -c 16 -c 24 -c 28 -c 32  -s $shards -u $cpu -r 3 -d $duration $exp_name
	#  -m 2pl_ww:multi_paxos -m occ:multi_paxos -m tapir:tapir
	./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -m 2pl_ww:multi_paxos -m occ:multi_paxos -c 1 -c 2 -c 4 -c 8 -c 14 -c 16 -c 24 -c 28 -c 32 -s $shards -u $cpu -r 3 -d $duration $exp_name
	new_experiment $exp_name

	concurrent=1
	exp_name=${prefix}_tpccTJ2O_${shards}shards_${cpu}cpus_${concurrent}cc
	write_concurrent $concurrent
	./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -m 2pl_ww:multi_paxos -m occ:multi_paxos -c 1 -c 10  -s $shards -u $cpu -r 3 -d $duration $exp_name
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
	./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -m 2pl_ww:multi_paxos -m occ:multi_paxos -c 48 -c 64 -c 80 -c 96 -c 112 -c 128 -c 144 -c 160 -c 176 -c 192 -s $shards -u $cpu -r 3 -d $duration $exp_name
	new_experiment $exp_name
}

function tpcc_NP_all {
	shards=$1
	cpu=$2
	concurrent=100
	exp_name=${prefix}_tpccTJ2O_${shards}shards_${cpu}cpus_${concurrent}cc
	write_concurrent $concurrent
	# ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -c 1 -c 10  -s $shards -u $cpu -r 3 -d $duration $exp_name
	# ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -c 1 -c 2 -c 4 -c 8 -c 16 -c 24 -c 28 -c 32  -s $shards -u $cpu -r 3 -d $duration $exp_name
	#  -m 2pl_ww:multi_paxos -m occ:multi_paxos -m tapir:tapir
	./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc2.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -m 2pl_ww:multi_paxos -m occ:multi_paxos -c 1 -c 2 -c 4 -c 8 -c 14 -c 16 -c 24 -c 28 -c 32 -s $shards -u $cpu -r 3 -d $duration $exp_name
	new_experiment $exp_name

	concurrent=1
	exp_name=${prefix}_tpccTJ2O_${shards}shards_${cpu}cpus_${concurrent}cc
	write_concurrent $concurrent
	./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc2.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -m 2pl_ww:multi_paxos -m occ:multi_paxos -c 1 -c 10  -s $shards -u $cpu -r 3 -d $duration $exp_name
	new_experiment $exp_name
}




function run_tests {
	tpcc_all_large 6 2
	tpcc_all_large 12 4
	# tpcc_all 18 6
	# tpcc_all 24 8
	# tpcc_all 48 16
}



run_tests