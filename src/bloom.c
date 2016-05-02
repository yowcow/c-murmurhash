#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include "bloom.h"
#include "MT.h"
#include "murmurhash.h"

void BF_init_mt() {
    init_genrand((unsigned)time(NULL));
}

double BF_generate_real_rand() {
    return genrand_real2();
}

uint32_t * BF_get_filter_cells(
    uint32_t * cells,
    char * key,
    uint32_t key_len,
    double * seeds,
    uint32_t seed_count,
    uint32_t filter_len
) {

    for (uint32_t i = 0; i < seed_count; i++) {
        uint32_t hash_uint32 = murmurhash(
            key,
            key_len,
            (uint32_t)(seeds[i] * UINT32_MAX)
        );

        cells[i] = (uint32_t)(hash_uint32 % filter_len);
    }

    return cells;
}
