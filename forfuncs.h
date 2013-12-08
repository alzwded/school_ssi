// Copyright (c) 2013, Vlad Meșco
// All rights reserved.
// See LICENSE for a license description

#ifndef ENC_H
#define ENC_H

// Initialization functions
extern void keyhas_(
        char const* K,
        int const* NK,
        int const* MAGIC1,
        int const* MAGIC2);
extern void setper_(
        char const PERM[64]);

// Encryption functions
extern void enc_(
        char const* restrict T,
        int const* restrict NT,
        char const* restrict K,
        int const* restrict NK,
        char* restrict R);
extern void tob64_(
        char const* restrict T,
        int const* restrict NT,
        char* restrict T64);
extern void spacfr_(
        char const* restrict T,
        int const* restrict NT,
        char* restrict TS,
        int* restrict NTS);
extern void despcf_(
        char const* restrict TS,
        int const* restrict NTS,
        char* restrict T,
        int* restrict NT);
extern void deb64_(
        char const* restrict T64,
        int const* restrict NT64,
        char* restrict T);
extern void dec_(
        char const* restrict T,
        int const* restrict NT,
        char const* restrict K,
        int const* restrict NK,
        char* restrict R);

#endif
