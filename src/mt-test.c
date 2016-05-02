#include <assert.h>
#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include "MT.h"

int main() {

    init_genrand((unsigned) time(NULL));

    double rnd = genrand_real2();
    uint32_t result = (uint32_t)(rnd * UINT32_MAX);

    assert(result >= 0);
    assert(result <  UINT32_MAX);

    return 0;
}
