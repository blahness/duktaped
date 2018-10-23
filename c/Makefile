DESTDIR=
PREFIX=

STATIC=libduktape.a

CC = gcc
CFLAGS = -Wall -Winline -pipe

LDFLAGS = -L./
LIBS    =

SRC = duktape.c

OBJ = $(SRC:.c=.o)

$(STATIC): $(OBJ)
		@echo "[Link (Static)]"
		@ar rcs $@ $^

.c.o:
		@echo [Compile] $<
		@$(CC) -c $(CFLAGS) $< -o $@

clean:
		rm -f $(OBJ) *~ core tags *.bak Makefile.bak libgeniePi.*

.PHONY: install
install: $(STATIC)
		@install -m 0755 $< $(DESTDIR)$(PREFIX)/lib

all: install
		$(CC) -g -Wall -o program program.c $(LDFLAGS) $(LIBS)