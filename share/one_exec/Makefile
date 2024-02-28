CC = gcc

all: combined_program

main.o: main.c program1.h program2.h
	$(CC) -c $< -o $@

program1.o: program1.c program1.h
	$(CC) -c $< -o $@

program2.o: program2.c program2.h
	$(CC) -c $< -o $@

combined_program: main.o program1.o program2.o
	$(CC) $^ -o $@

.PHONY: clean
clean:
	rm -f *.o combined_program
