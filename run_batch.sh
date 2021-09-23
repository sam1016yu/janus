#!/bin/bash
duration=30
# prefix="test_run_all"
# prefix="test_run_all_others"
# prefix="no_dist"
# prefix="baseline"
prefix="0916_run1"

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
	echo "|shards:${shards}|cpus:${cpu}|replica:${replica}"
	exp_name=${prefix}_tpccJ_${shards}shards_${cpu}cpus_${concurrent}cc_${replica}rep
	write_concurrent $concurrent
	#  -m 2pl_ww:multi_paxos -m occ:multi_paxos -m tapir:tapir
	timeout -s SIGTSTP 15m ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq -c 1 -c 2 -c 5 -c 10 -c 20 -c 40  -s $shards -u $cpu -r $replica -d $duration $exp_name
	new_experiment $exp_name

	concurrent=1
	exp_name=${prefix}_tpccJ_${shards}shards_${cpu}cpus_${concurrent}cc_${replica}rep
	write_concurrent $concurrent
	timeout -s SIGTSTP 15m ./run_all.py -g -hh config/hosts.yml -cc config/client_closed.yml -cc /tmp/concurrent.yml -cc config/tpcc.yml -cc config/tapir.yml -b tpcc -m brq:brq   -c 1 -c 10 -c 20 -c 40 -c 80 -s $shards -u $cpu -r $replica -d $duration $exp_name
	new_experiment $exp_name

}




function run_tests {

	for Ncpu in 1 2 3 4
	do
		for rep in 1 3 5 7
		do
			for ((WH=1; WH*rep/Ncpu<=27; WH=WH*2))
			do
				date
				echo "CPU:${Ncpu}|rep:${rep}|WH:${WH}"
				Janus_TPCC $WH $Ncpu $rep
			done
		done
	done



}



run_tests 2>&1 | tee -a ~/${prefix}_tpcc_batch_run.log