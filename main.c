#include "forfuncs.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

int main(int argc, char* argv[])
{
    char* test1 = (char*)malloc(sizeof(char) * 100);
    memset(test1, '\0', sizeof(char) * 100);
    strcpy(test1, "asd");
    int testLen = 100 * sizeof(char);
    char* testKey = "asdqwe";
    int testKeyLen = (int)strlen(testKey);
    char* test2 = (char*)malloc(sizeof(char) * 100);
    memset(test2, '\0', sizeof(char) * 100);
    strcpy(test2, "no no no");

    static const int magic1 = 42;
    keyhas_(testKey, &testKeyLen, &magic1);

    enc_(test1, &testLen, testKey, &testKeyLen, test2);

    char* rrr = (char*)malloc(sizeof(char) * 201);
    memset(rrr, '\0', sizeof(char) * 200);
    tob64_(test2, &testLen, rrr);
    rrr[200] = '\0';
    printf("%s\n", rrr);
    testLen *= 2;

    char qweqwe[400];
    int nqweqwe;
    spacfr_(rrr, &testLen, qweqwe, &nqweqwe);
    qweqwe[nqweqwe] = '\0';
    printf("\n");
    printf("%s\n", qweqwe);

    keyhas_(testKey, &testKeyLen, &magic1);
    char deqweqwe[400];
    int ndeq;
    despcf_(qweqwe, &nqweqwe, deqweqwe, &ndeq);
    deqweqwe[ndeq] = '\0';
    printf("\n");
    printf("%s\n", deqweqwe);

    return 0;
}
