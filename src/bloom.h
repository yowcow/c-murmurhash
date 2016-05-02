#ifndef BLOOM_H
#define BLOOM_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

void BF_init_mt();
double BF_generate_real_rand();
uint32_t * BF_get_filter_cells(
    uint32_t *,
    char *,
    uint32_t,
    double *,
    uint32_t,
    uint32_t
);

#ifdef __cplusplus
}
#endif

#endif
