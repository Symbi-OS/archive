REDIS_CMD=../../artifacts/redis/fed30/redis-server --protected-mode no --save '' --appendonly no
TASKSET_CMD=taskset -c 0 bash -c

run_redis:
	${TASKSET_CMD} '${REDIS_CMD}'

run_redis_passthrough:
	${TASKSET_CMD} 'shortcut.sh -p --- ${REDIS_CMD}'

run_redis_interpose:
	${TASKSET_CMD} 'shortcut.sh --- ${REDIS_CMD}'

run_redis_elev:
	${TASKSET_CMD} 'shortcut.sh -be --- ${REDIS_CMD}'

run_redis_sc_write:
	${TASKSET_CMD} 'shortcut.sh -be -s "write->ksys_write" --- ${REDIS_CMD}'

run_redis_sc_read:
	${TASKSET_CMD} 'shortcut.sh -be -s "read->ksys_read" --- ${REDIS_CMD}'

run_redis_sc_rw:
	${TASKSET_CMD} 'shortcut.sh -be -s "write->ksys_write" -s "read->ksys_read" --- ${REDIS_CMD}'

