#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include "bloom.h"

void test_BF_init_mt() {
    BF_init_mt();
    assert(true);
}

void test_BF_generate_real_rand() {

    for (int i = 0; i < 10; i++) {
        double res = BF_generate_real_rand();
        assert(res >= 0.0 && res < 1.0);
    }
}

void test_BF_get_filter_cells() {

    double seeds[64];

    for (uint32_t i = 0; i < 64; i++) {
        seeds[i] = BF_generate_real_rand();
    }

    uint32_t cells[64];
    BF_get_filter_cells(cells, "hogehoge", 8, seeds, 64, 16);

    for (uint32_t i = 0; i < 64; i++) {
        uint32_t cell = *(cells + i);
        assert(cell >= 0 && cell < 64);
    }
}

int main() {

    test_BF_init_mt();

    test_BF_generate_real_rand();

    test_BF_get_filter_cells();

    return 0;
}
