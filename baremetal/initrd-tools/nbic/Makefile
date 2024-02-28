VERSION = $(shell ./nbic --version)
DESTDIR =
PREFIX = /usr/local
BINDIR = $(PREFIX)/bin
PROGRAMS = cpio-add cpio-chroot cpio-diff cpio-du cpio-edit cpio-filter \
           cpio-fsck cpio-img cpio-ls cpio-merge cpio-pack cpio-unpack \
           cpio-vmdk disk-cpio img-edit img-vmdk nbic nd trace-files

all:

clean:
	rm -f *~ nbic-*.tar.gz 0.*

check:
	test/000-atime
	test/001-nbic

dist:
	rsync -a --delete --exclude=.git $(PWD)/ /tmp/nbic-$(VERSION)/
	tar -C /tmp -czf nbic-$(VERSION).tar.gz nbic-$(VERSION)
	rm -r /tmp/nbic-$(VERSION)

install: all
	install -d $(DESTDIR)$(BINDIR)
	install -m 755 $(PROGRAMS) $(DESTDIR)$(BINDIR)
