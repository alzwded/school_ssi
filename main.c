#include "forfuncs.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define PRINT(X) printf(#X); fflush(stdout);

int main(int argc, char* argv[])
{
    char clearText[102];
    memset(clearText, '\0', sizeof(char) * 100);
    strcpy(clearText, "Some example text followed by many NULLs|abcdefghijklmnopqestuvwxyz");
    int nClearText = 100 * sizeof(char);
    char* testKey = "asdqwe";
    int testKeyLen = (int)strlen(testKey);
    char encText[102];
    memset(encText, '\0', sizeof(char) * 100);
    strcpy(encText, "no no no");

    printf("%s\n", clearText);

    static const char perm[64] = {
        61, 3, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 13, 15, 16, 19, 18, 17,
        20, 21, 22, 23, 24, 25, 26, 27, 28, 31, 30, 29, 32, 33, 34, 35, 36,
        39, 38, 37, 40, 41, 42, 43, 44, 45, 46, 49, 48, 47, 50, 53, 52, 51,
        54, 55, 56, 57, 58, 59, 60, 64, 63, 62, 1,
    };
    static const int magic1 = 42;
    static const int magic2 = 3;
    keyhas_(testKey, &testKeyLen, &magic1, &magic2);
    setper_(perm);

    enc_(clearText, &nClearText, testKey, &testKeyLen, encText);
    encText[nClearText] = '\0';

    char tob64[400];
    memset(tob64, '\0', sizeof(char) * nClearText);
    tob64_(encText, &nClearText, tob64);
    tob64[2 * nClearText] = '\0';
    printf("\n");
    printf("%s\n", tob64);
    nClearText *= 2;

    char randomized[400];
    int nrandomized;
    spacfr_(tob64, &nClearText, randomized, &nrandomized);
    randomized[nrandomized] = '\0';
    printf("\n");
    printf("%s\n", randomized);

    keyhas_(testKey, &testKeyLen, &magic1, &magic2);
    char derandomized[400];
    int ndeq;
    despcf_(randomized, &nrandomized, derandomized, &ndeq);
    derandomized[ndeq] = '\0';
    printf("\n");
    printf("%s\n", derandomized);

    char deb64[102];
    deb64_(derandomized, &ndeq, deb64);
    ndeq /= 2;
    deb64[ndeq] = '\0';

    char decText[102];
    dec_(deb64, &ndeq, testKey, &testKeyLen, decText);
    decText[ndeq] = '\0';
    printf("\n");
    printf("%s\n", decText);

    return 0;
}
