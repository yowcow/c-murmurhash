#ifndef MURMURHASH3_H
#define MURMURHASH3_H

#define ROT32(x, y) ((x << y) | (x >> (32 - y))) // avoid effort

uint32_t murmur3_32(const char *, uint32_t, uint32_t);

#endif
