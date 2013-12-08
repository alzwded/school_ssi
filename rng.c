// Copyright (c) 2013, Vlad Meșco
// All rights reserved.
// See LICENSE for a license description

#include <tgmath.h>

/** Union used to access the inidividual bytes of a float */
typedef union {
    float e;
    int d;
#define INT(X) (X.d)
#define FLOAT(X) (X.e)
} FI_t;

/** Macro used to retrieve a certain byte from an int/float */
#define BYTE(X) (((char*)(X))[2])

/** Function used to seed the RNG.
  * returns the initial STATE of the RNG */
int rngsed_(int const* n)
{
    FI_t un;
    // initialize the number as a float
    FLOAT(un) = (int)*n;
    // the 3rd byte (in order, LE) should contain the boundary
    //    between the exponent and the mantissa, so grab that
    return BYTE(&INT(un));
}

/** Function used to retrieve the next random value.
  * The state variable is updated to reflect the current state.
  * returns a new random number */
char rnglog_(int* state)
{
    FI_t un, doi;
    INT(un) = *state;
    FLOAT(doi) = sin(FLOAT(un));
    INT(un) = (19073 * INT(un) + 33068) + INT(doi);
    *state = INT(un);
    return BYTE(&INT(un));
}
