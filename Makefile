TARGET = pro1 

CC=gcc
CFLAGS=-g -Wall

SRCDIR = src
OBJDIR = obj
BINDIR = bin

BIN_NAME := $(BINDIR)/$(TARGET)

SOURCES := $(wildcard $(SRCDIR)/*.c)
OBJECTS := $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o,$(SOURCES))

$(BINDIR)/$(TARGET):$(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $@
	
$(OBJECTS):$(SOURCES)
	$(CC) $(CFLAGS) $< -c -o $@
	
build:
	@mkdir -p obj
	@mkdir -p bin
	@mkdir -p tests

run:
	@$(BIN_NAME)

valgrind:
	@valgrind "--track-origins=yes" $(BIN_NAME)

clean:
	rm -rf bin/*
	rm -rf obj/*

