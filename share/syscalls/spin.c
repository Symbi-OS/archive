#include <stdio.h>
#include <stdlib.h>

#include <time.h>

// call this function to start a nanosecond-resolution timer
struct timespec timer_start() {
  struct timespec start_time;
  /* clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start_time); */
  clock_gettime(CLOCK_MONOTONIC, &start_time);
  return start_time;
}

// call this function to end a timer, returning nanoseconds elapsed as a long
long timer_end(struct timespec start_time) {
  struct timespec end_time;
  clock_gettime(CLOCK_MONOTONIC, &end_time);
  long diffInNanos = (end_time.tv_sec - start_time.tv_sec) * (long)1e9 +
                     (end_time.tv_nsec - start_time.tv_nsec);
  return diffInNanos;
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
      printf("usage ./while.c <total_work> \n");
      exit(1);
    }

    int work_total = 1 << atoi(argv[1]);
    // The work.

    struct timespec vartime = timer_start();

    int myvar = 0;
    while (work_total--){
      while(myvar < 0);
      myvar = 42;
      while (myvar < 0) ;
      myvar = 42;
    }

    long time_elapsed_nanos = timer_end(vartime);
    printf("Time taken (micro seconds): %ld\n", time_elapsed_nanos / 1000);

    return 0;
  }
