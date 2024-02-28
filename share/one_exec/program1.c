#include <stdio.h>
#include <unistd.h>
#include "program1.h"

int run_program1() {
    printf("This is program 1.\n");
    printf("program1 about to exec program2\n");

    int fork_result = fork();
    if (fork_result == 0) {
        // this is the child process
        char *args[] = {"./combined_program", "2", NULL};
        execvp(args[0], args);
    } else {
        printf("program1 finished\n");
    }

    return 0;
}
