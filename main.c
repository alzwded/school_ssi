#include "forfuncs.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

FILE* configFile, *inFile, *outFile;
char permutation[64], key[256], inputText[10 << 20], outputText[10 << 20], buffer[10 << 20];
int nkey, ninputText, noutputText;
int magic1, magic2;

void config() {
    int buf;
    fscanf(configFile, "%d %d", &magic1, &magic2);
    for(int i = 0; i < 64; fscanf(configFile, "%d", &buf), permutation[i++] = buf);
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
    printf("b64: %s\n\n", inputText);
    spacfr_(inputText, &ninputText, outputText, &noutputText);
    printf("spa: %s\n\n", outputText);
    fwrite(outputText, sizeof(char), noutputText, outFile);
}

void decrypt() {
    ninputText = fread(inputText, sizeof(char), 10 << 20, inFile);
    printf("%s\n\n", inputText);
    despcf_(inputText, &ninputText, outputText, &noutputText);
    printf("%s\n\n", outputText);
    deb64_(outputText, &noutputText, inputText);
    noutputText /= 2;
    dec_(inputText, &noutputText, key, &nkey, outputText);
    fwrite(outputText, sizeof(char), noutputText, outFile);
}

int main(int argc, char* argv[]) {
    if(argc != 5) {
        printf("usage: %s (e|d) configFile inFile outFile\n", argv[0]);
        return 255;
    } else {
        switch(argv[1][0]) {
        default:
            printf("usage: %s (e|d) [configFile]\n", argv[0]);
            return 255;
        case 'e':
        case 'd':
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
