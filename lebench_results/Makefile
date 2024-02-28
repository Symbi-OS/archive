PARALLEL= -j$(shell nproc)

mybench_small: gcc-build glibc-build
	- rm -rf mybench_small.static mybench_small.o
#	gcc -c -o mybench_small.o mybench_small.c -ggdb -mno-red-zone -UUSE_VMALLOC -UBYPASS -UUSE_MALLOC \
#		-DREF_TEST -DWRITE_TEST -DREAD_TEST -DMMAP_TEST -DMUNMAP_TEST -DPF_TEST -DEPOLL_TEST \
#		-USELECT_TEST -UPOLL_TEST
#	ld -static -o mybench_small.static mybench_small.o 
	gcc -o mybench_small mybench_small.c -ggdb -mno-red-zone -UUSE_VMALLOC -UBYPASS -UUSE_MALLOC \
		-DREF_TEST -DWRITE_TEST -DREAD_TEST -DMMAP_TEST -DMUNMAP_TEST -DPF_TEST -DEPOLL_TEST \
		-USELECT_TEST -UPOLL_TEST


#GCC
gcc-dir:
	git clone --depth 1 --branch releases/gcc-9.3.0 'https://github.com/gcc-mirror/gcc.git'
	cd ./gcc; ./contrib/download_prerequisites

gcc-build:
	- mkdir $@
	- mkdir gcc-install
	cd $@; \
          TARGET=x86_64-elf ../gcc/configure \
          --enable-languages=c,c++ --without-headers \
          --with-multilib-list=m64 --disable-multilib
	make -C $@ all-gcc $(PARALLEL)
	make -C $@ all-target-libgcc CFLAGS_FOR_TARGET='-ggdb -O2 -mno-red-zone' $(PARALLEL)


#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------

#GLIBC
glibc-dir:
	git clone --depth 1 --branch glibc-2.31 https://github.com/bminor/glibc.git

glibc-build:
	- rm -rf glibc-build
	mkdir glibc-build
	cd glibc-build && ~/../glibc/configure CFLAGS="-g -O2 -fthread-jumps -mno-red-zone" --prefix=/dev/null
	cd glibc-build && make $(PARALLEL)