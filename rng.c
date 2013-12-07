#include <tgmath.h>

#define BYTE(X) (((char*)(X))[2])

int rngsed_(int* n)
{
    union {
        float e;
        int d;
    } un;
    un.e = (int)*n;
    return BYTE(&un.d);
}

char rnglog_(int* n)
{
    union {
        float e;
        int d;
    } un, doi;
    un.d = *n;
    doi.e = sin(un.e);
    un.d = (19073 * un.d + 33068) + doi.d;
    *n = un.d;
    return BYTE(&un.d);
}
