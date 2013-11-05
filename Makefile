TARGET = iridium-frontend 
CC=gcc
CFLAGS=-g -Wall
LDFLAGS=


BIN_NAME = $(TARGET)

SOURCES = $(wildcard *.c)
OBJECTS = $(patsubst %.c, %.o,$(SOURCES))

$(TARGET) : Makefile.dependencies $(OBJECTS)
	$(CC) -o $@ $(OBJECTS) $(LDFLAGS)

Makefile.dependencies:: $(SOURCES) $(HEADERS)
	$(CC) $(CFLAGS) -MM $(SOURCES) > Makefile.dependencies

-include Makefile.dependencies
	
build:
	@mkdir -p tests

valgrind:
	@valgrind "--track-origins=yes" $(BIN_NAME)

clean:
	rm -rf $(TARGET) 
	rm -rf *.o
	rm -rf Makefile.dependencies
