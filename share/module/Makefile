obj-m += err-mod.o
err-mod-objs += main.o toggle.o

mod-err:
	make -C ../linux M=$(PWD)

clean:
	make -C ../linux M=$(PWD) clean
