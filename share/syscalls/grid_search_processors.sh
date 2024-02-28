#!/bin/bash

REPS=8
WORK=23

# run workloads
for i in $(seq 0 $[ $(nproc) - 1 ] )
do
    for j in $(seq 0 $[ $(nproc) - 1 ] )
    do
        if [[ $i == $j ]]
        then
            echo -n '('$i';'$j'),'

            for rep in $(seq 1 $REPS)
            do
                echo -n 0,
            done
            echo

            # echo skipping
           continue
        fi
        echo -n '('$i';'$j')',
        # echo doing work

        # jq -s add/length <(for rep in $(seq 1 $REPS); do taskset -c $i,$j ./app_sys_mt_pingpong_nopinning $WORK 0; done)
        # Run expt
        for rep in $(seq 1 $REPS); do taskset -c $i,$j ./app_sys_mt_pingpong_nopinning $WORK 0; echo -n ,; done

        echo


    done
done
