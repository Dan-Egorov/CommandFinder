#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "help.h"

int main(int argc, char *argv[]) {
    int size_to = 20;
    int size_from = 0;
    
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-h") == 0 || strcmp(argv[i], "--help") == 0) {
            show_help(argv[0]);
            return 0;
        }
        else if (strcmp(argv[i], "-v") == 0 || strcmp(argv[i], "--version") == 0) {
            printf("Версия 1.0\n");
            return 0;
        }
        else if ((strcmp(argv[i], "-t") == 0) && ((argc-1) > i) && (isnum(argv[i+1]))){
            size_to = atoi(argv[i+1]);
            if (size_to > 1001){
                printf("Real big number");
                return 1;
            }
        }
        else if ((strcmp(argv[i], "-f") == 0) && ((argc-1) > i) && (isnum(argv[i+1]))){
            size_from = atoi(argv[i+1]);
            if (size_from > 1000){
                printf("Real big number");
                return 1;
            }
        }else if(!(isnum(argv[i]))){
            printf("Unknown flag: %s\n", argv[i]);
            return 1;
        }
    }

    lst_t list_cmd;
    list_cmd = readCommands();
    writeCommands(list_cmd, size_from, size_to);
    return 0;
}