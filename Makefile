CC = gcc
CFLAGS = --std=gnu99 -Wall -O3
OBJS = ifstats.o

PREFIX ?= /usr/local
BIN = $(DESTDIR)$(PREFIX)/bin
LIB = $(DESTDIR)$(PREFIX)/lib
INCLUDE = $(DESTDIR)$(PREFIX)/include
MAN = $(DESTDIR)$(PREFIX)/share/man/man3

all: staticlib

staticlib: $(OBJS)
	ar -cr libifstats.a $(OBJS)

test: ifstats.c ifstats.h
	$(CC) -c -DIFSTATS_TEST $(CFLAGS) -o ifstats.o ifstats.c
	$(CC) $(CFLAGS) $(OBJS) -o ifstatstest

install:
	cp libifstats.a $(LIB)
	cp ifstats.h $(INCLUDE)
	mkdir -p $(MAN)
	install -g 0 -o 0 -m 644 man/ifstats.3 $(MAN)
	gzip -f $(MAN)/ifstats.3
	ln -f -s $(MAN)/ifstats.3.gz $(MAN)/getIfStats.3.gz
	ln -f -s $(MAN)/ifstats.3.gz $(MAN)/releaseStats.3.gz

clean:
	-rm -f *.o
	-rm -f *.a
	-rm -f ifstatstest

.PHONY : test clean
