#include <stdint.h>
#include <stdio.h>
#include "murmurhash3.h"

int main() {

    printf("==> Hello, world\n");

    char* key = "あいうえお";
    uint32_t len = 4;
    uint32_t seed = 12345678;

    uint32_t hash = murmur3_32(key, len, seed);

    printf("==> Hash: %u\n", hash);

    return 0;
}
