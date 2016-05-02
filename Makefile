.PHONY: update-submodules clean

BUILD=build
SRC=src

all: update-submodules

test: $(BUILD)/murmurhash-test $(BUILD)/mt-test
	./$(BUILD)/murmurhash-test
	./$(BUILD)/mt-test

$(BUILD)/murmurhash.o:
	mkdir -p $(BUILD) && \
	gcc -Wall -fPIC -O2 -c -I murmurhash.c \
		murmurhash.c/murmurhash.c \
		-o $(BUILD)/murmurhash.o

$(BUILD)/murmurhash-test: $(BUILD)/murmurhash.o
	gcc -Wall -fPIC -O2 -I murmurhash.c \
		murmurhash.c/murmurhash.c $(SRC)/murmurhash-test.c \
		-o $(BUILD)/murmurhash-test

$(BUILD)/mt-test:
	gcc -Wall -fPIC -O2 -I mt \
		$(SRC)/mt-test.c \
		-o $(BUILD)/mt-test

update-submodules:
	git submodule update --init

clean:
	-rm -rf build
