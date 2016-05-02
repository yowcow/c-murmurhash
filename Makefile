.PHONY: update-submodules test clean

BUILD=build
RESOURCES=resources
SRC=src

all: update-submodules $(BUILD)/libbloom.so

$(BUILD)/libbloom.so: $(BUILD)/murmurhash.o $(BUILD)/bloom.o
	mkdir -p $(RESOURCES) && \
	gcc -Wall -fPIC -shared -O2 -I murmurhash.c -I mt -I $(SRC) \
	$(BUILD)/murmurhash.o \
	$(BUILD)/bloom.o \
	-o $(RESOURCES)/libbloom.so

test: $(BUILD)/murmurhash-test $(BUILD)/mt-test $(BUILD)/bloom-test
	./$(BUILD)/murmurhash-test
	./$(BUILD)/mt-test
	./$(BUILD)/bloom-test

$(BUILD)/bloom.o:
	mkdir -p $(BUILD) && \
	gcc -Wall -fPIC -O2 -c -I murmurhash.c -I mt -I $(SRC) \
		$(SRC)/bloom.c \
		-o $(BUILD)/bloom.o

$(BUILD)/bloom-test: $(BUILD)/murmurhash.o $(BUILD)/bloom.o
	mkdir -p $(BUILD) && \
	gcc -Wall -fPIC -O2 -I murmurhash.c -I mt -I $(SRC) \
		$(BUILD)/murmurhash.o \
		$(BUILD)/bloom.o \
		$(SRC)/bloom-test.c \
		-o $(BUILD)/bloom-test

$(BUILD)/murmurhash.o:
	mkdir -p $(BUILD) && \
	gcc -Wall -fPIC -O2 -c -I murmurhash.c \
		murmurhash.c/murmurhash.c \
		-o $(BUILD)/murmurhash.o

$(BUILD)/murmurhash-test: $(BUILD)/murmurhash.o
	mkdir -p $(BUILD) && \
	gcc -Wall -fPIC -O2 -I murmurhash.c \
		$(BUILD)/murmurhash.o \
		$(SRC)/murmurhash-test.c \
		-o $(BUILD)/murmurhash-test

$(BUILD)/mt-test:
	mkdir -p $(BUILD) && \
	gcc -Wall -fPIC -O2 -I mt \
		$(SRC)/mt-test.c \
		-o $(BUILD)/mt-test

update-submodules:
	git submodule update --init

clean:
	-rm -rf $(BUILD) $(RESOURCES)
