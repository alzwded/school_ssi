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

    enc_(test1, &testLen, testKey, &testKeyLen, test2);

    char* rrr = (char*)malloc(sizeof(char) * 201);
    memset(rrr, '\0', sizeof(char) * 200);
    tob64_(test2, &testLen, rrr);
    rrr[200] = '\0';

    printf("%s\n", rrr);

    return 0;
}
