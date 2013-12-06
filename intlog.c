#include <tgmath.h>
#include <stdio.h>

int intsed_(int* n)
{
    union {
        float e;
        int d;
    } un;
    un.e = (int)*n;
    return un.d;
}

char intlog_(int* n)
{
    union {
        float e;
        int d;
    } un;
    un.d = *n;
    un.e = (fabs(un.e) < 1.e-20) ? 42.0 : sin(un.e);
    *n = un.d;
    return (((char*)(&un.d))[1]);
}
