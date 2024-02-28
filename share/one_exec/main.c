#include <stdio.h>
#include <string.h>
#include "program1.h"
#include "program2.h"

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Please provide an argument to choose a program (1 or 2).\n");
        return 1;
    }

    if (strcmp(argv[1], "1") == 0) {
        run_program1();
    } else if (strcmp(argv[1], "2") == 0) {
        run_program2();
    } else {
        printf("Invalid argument. Choose either 1 or 2.\n");
        return 1;
    }

    return 0;
}
