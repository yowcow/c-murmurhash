#include <assert.h>
#include <stdio.h>
#include <stdint.h>
#include "murmurhash.h"

void test_murmurhash(char * key, uint32_t len, uint32_t expected) {
    uint32_t seed = 12345678;
    uint32_t result = murmurhash(key, len, seed);
    assert(result == expected);
}

int main() {

    test_murmurhash("hoge", 4, 3328321342);
    test_murmurhash("hogefuga", 8, 946012105);
    test_murmurhash("hogefugahogefuga", 16, 1081591432);

    return 0;
}
