#!/bin/bash
duration=30
# prefix="test_run_all"
# prefix="test_run_all_others"
# prefix="no_dist"
# prefix="baseline"
prefix="0906_test_space"

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




function Janus_TPCC {
	shards=$1
	cpu=$2
	replica=$3
	concurrent=100
	# echo "|shards:${shards}|cpus:${cpu}|replica:${replica}"
	# exp_name=${prefix}_tpccTJ2O_${shards}shards_${cpu}cpus_${concurrent}cc_${replica}
	# write_concurrent $concurrent
	# #  -m 2pl_ww:multi_paxos -m occ:multi_paxos -m tapir:tapir
	# timeout -s SIGTSTP 5m ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -m 2pl_ww:multi_paxos -m occ:multi_paxos  -c 128 -s $shards -u $cpu -r $replica -d $duration $exp_name
	# new_experiment $exp_name

	concurrent=1
	exp_name=${prefix}_tpccTJ2O_${shards}shards_${cpu}cpus_${concurrent}cc_${replica}
	write_concurrent $concurrent
	timeout -s SIGTSTP 5m ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq  -m tapir:tapir -m 2pl_ww:multi_paxos -m occ:multi_paxos  -c 10  -s $shards -u $cpu -r $replica -d $duration $exp_name
	new_experiment $exp_name

}




function run_tests {
	# Janus_TPCC 6 2 3
	# Janus_TPCC 12 4 3

	# for shard in 3 6 12 24 36 48 60 
	# do
	# 	for cpu in 1 2 4
	# 	do
	# 		for replica in 1 2 4 8
	# 		do
	# 			Janus_TPCC $shard $cpu $replica
	# 		done
	# 	done
	# done


	# for shard in 36 48 60 
	# do
	# 	for cpu in 4 8 16
	# 	do
	# 		for replica in 1 4 8
	# 		do
	# 			Janus_TPCC $shard $cpu $replica
	# 		done
	# 	done
	# done

	shard=2
	cpu=4
	replica=47
	
	Janus_TPCC $shard $cpu $replica

}



run_tests 2>&1 | tee -a ~/tpcc_space_manual.log