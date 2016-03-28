.PHONY: clean

all: build/murmurhash3.o

build/murmurhash3.o:
	mkdir -p build && \
	gcc -c -Wall -fPIC -I src -std=c11 -O2 \
	src/murmurhash3.c \
	-o build/murmurhash3.o

test: build/murmurhash3-test
	./build/murmurhash3-test

build/murmurhash3-test: build/murmurhash3.o
	gcc -Wall -fPIC -I src -std=c11 -O2 \
	build/murmurhash3.o src/murmurhash3-test.c \
	-o build/murmurhash3-test

clean:
	-rm -rf build
