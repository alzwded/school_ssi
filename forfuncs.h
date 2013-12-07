#ifndef ENC_H
#define ENC_H

extern void enc_(
        char* restrict T,
        int* restrict NT,
        char* restrict K,
        int* restrict NK,
        char* restrict R);
extern void tob64_(
        char* restrict T,
        int* restrict NT,
        char* restrict T64);
extern void spacfr_(
        char* restrict T,
        int* restrict NT,
        char* restrict TS,
        int* restrict NTS);

#endif
