# app_sys_loop: app_sys_loop.c
# 	gcc -static $< -o $@ -lpthread
# app_sys_loop_spin_lock: app_sys_loop_spin_lock.c
# 	gcc -static $< -o $@ -lpthread

all: app_sys_mt app_sys_mt_pingpong spin app_sys_mt_pingpong_nopinning  app_sys_mt_pingpong_nopinning_opt

app_sys_mt: app_sys_mt.c
	gcc -static $< -o $@ -lpthread

app_sys_mt_pingpong: app_sys_mt.c
	gcc -DPINGPONG -static $< -o $@ -lpthread

app_sys_mt_pingpong_nopinning: app_sys_mt.c
	gcc -DPINGPONG -DNOPINNING -static $< -o $@ -lpthread

app_sys_mt_pingpong_nopinning_opt: app_sys_mt.c
	gcc -O1 -DPINGPONG -DNOPINNING -static $< -o $@ -lpthread

ping_pong_test:
	for i in $(seq 0 30); do numactl  --membind=0  -C  0,2 ./app_sys_mt_pingpong $i 0 | cut -d ' ' -f 5-; done

spin: spin.c
	gcc -static $< -o $@

# numactl  --membind=0  -C  0,2 ./app_sys_loop_volatile 25 0
# for i in $(seq 0 30); do ./app_sys_loop_volatile 0 $i | cut -d ' ' -f 5-; done

# run_expt:
# 	echo pwr,trial,ipc; for i in $(seq 1 30); do for j in $(seq 1 5); do echo -n $i,$j,; grep 'ins' <(timeout -s SIGINT 2 perf stat ./app_sys_loop $i 2>&1 ) | cut -d '#' -f 2 |  awk '{print $1}'; done;  done

clean:
	-rm -rf app_sys_mt
	-rm -rf app_sys_mt_pingpong
	-rm -rf spin
	-rm app_sys_mt_pingpong_nopinning
	-rm app_sys_mt_pingpong_nopinning_opt
