TARGET = iridium 

CC=gcc
CFLAGS=-g -Wall
LDFLAGS=-lpthread

SRCDIR = src
OBJDIR = obj
BINDIR = bin

BIN_NAME := $(BINDIR)/$(TARGET)

SOURCES := $(wildcard $(SRCDIR)/*.c)
OBJECTS := $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o,$(SOURCES))

$(BINDIR)/$(TARGET):$(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $@ $(LDFLAGS)

$(OBJDIR)/%.o: $(SRCDIR)/%.c $(SRCDIR)/%.h
	$(CC) -c  $(CFLAGS) $< -o $@
	
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

