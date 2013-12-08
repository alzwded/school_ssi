// Copyright (c) 2013, Vlad Meșco
// All rights reserved.
// See LICENSE for a license description

#include "forfuncs.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

FILE* configFile, *inFile, *outFile;
char key[256], inputText[10 << 20], outputText[10 << 20];
int nkey, ninputText, noutputText, magic1, magic2;

void config() {
    char permutation[64];
    fscanf(configFile, "%d %d", &magic1, &magic2);
    for(int i = 0, buf; i < 64; fscanf(configFile, "%d", &buf), permutation[i++] = buf);
    fgets(key, 256, stdin);
    nkey = strlen(key);
    if(key[nkey - 1] == '\n' || key[nkey - 1] == '\r') key[--nkey] = '\0';
    keyhas_(key, &nkey, &magic1, &magic2);
    setper_(permutation);
}

void encrypt() {
    ninputText = fread(inputText, sizeof(char), 10 << 20, inFile);
    enc_(inputText, &ninputText, key, &nkey, outputText);
    tob64_(outputText, &ninputText, inputText);
    ninputText *= 2;
    spacfr_(inputText, &ninputText, outputText, &noutputText);
    fwrite(outputText, sizeof(char), noutputText, outFile);
}

void decrypt() {
    ninputText = fread(inputText, sizeof(char), 10 << 20, inFile);
    despcf_(inputText, &ninputText, outputText, &noutputText);
    deb64_(outputText, &noutputText, inputText);
    noutputText /= 2;
    dec_(inputText, &noutputText, key, &nkey, outputText);
    fwrite(outputText, sizeof(char), noutputText, outFile);
}

int main(int argc, char* argv[]) {
#define USAGE { printf("usage: %s (e|d) configFile inFile outFile\n", argv[0]); return 255; }
    if(argc != 5) USAGE
    else {
        switch(argv[1][0]) {
        default:
            USAGE
        case 'e': case 'd':
            configFile = fopen(argv[2], "r");
            inFile = fopen(argv[3], "rb");
            outFile = fopen(argv[4], "wb");
            config();
            if(argv[1][0] == 'e') encrypt();
            else decrypt();
        }
    }
    fclose(configFile);
    fclose(inFile);
    fclose(outFile);
    return 0;
}
