gcc -c       src/main.c        -o bin/main.o

#
# Create the object files for the static library (without -fPIC)
#
gcc -c       src/tq84/add.c    -o bin/static/add.o
gcc -c       src/tq84/answer.c -o bin/static/answer.o

#
# object files for shared libraries need to be compiled as position independent
# code (-fPIC) because they are mapped to any position in the address space.
#
gcc -c -fPIC src/tq84/add.c    -o bin/shared/add.o
gcc -c -fPIC src/tq84/answer.c -o bin/shared/answer.o

# Create static library
ar rcs bin/static/libtq84.a bin/static/add.o bin/static/answer.o

# Link statically
gcc   bin/main.o  -Lbin/static -ltq84 -o bin/statically-linked

# Create the shared library
gcc -shared bin/shared/add.o bin/shared/answer.o -o bin/shared/libtq84.so


#
#  In order to create a shared library, position independent code
#  must be generated. This can be achieved with `-fPIC` flag when
#  c-files are compiled.
#
#  If the object files are created without -fPIC (such as when the static object files are produces), then
#      gcc -shared bin/static/add.o bin/static/answer.o -o bin/shared/libtq84.so
#  produces this error:
#     /usr/bin/ld: bin/tq84.o: relocation R_X86_64_PC32 against symbol `gSummand' can not be used when making a shared object; recompile with -fPIC
#

# Link dynamically with the shared library
# Note the order:
#   -ltq84-shared needs to be placed AFTER main.c

gcc  bin/main.o -Lbin/shared -ltq84 -o bin/use-shared-library

# Use the shared library with LD_LIBRARY_PATH
#  If the shared object is in a non standard location, we
#  need to tell where it is via the LD_LIBRARY_PATH
#  environment variable
#
# ./use-shared-object
#    ./use-shared-object: error while loading shared libraries: libtq84.so: cannot open shared object file: No such file or directory
echo about to run shared lib
LD_LIBRARY_PATH=$(pwd)/bin/shared bin/use-shared-library
