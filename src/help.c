#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include "help.h"

void show_help(const char *program_name){
    printf("Using: %s [OPTIONS] <args>\n", program_name);
    printf("Options:\n");
    printf("  -h, --help     Show this certificate\n");
    printf("  -v, --version  Show version\n");
    printf("  -f, [numb]    Choose which number to count from\n");
    printf("  -t, [numb]    Choose what number to count to\n");
}

int isnum(char* stroke){
    size_t size = strlen(stroke);

    for (int i = 0; i < size; i++){
        if (!isdigit(stroke[i])){
            return 0;
        }
    }
    return 1;
}

lst_t readCommands(){
    char* home = getenv("HOME");
    size_t cap_lst = 10, size_lst = 0;
    lst_t list_of_cmd;
    list_of_cmd.list = malloc(cap_lst*sizeof(cmd_t));

    char path[1024];
    snprintf(path, sizeof(path), "%s/.zsh_history", home);

    FILE *fl = fopen(path, "r");
    if (!fl){
        printf("Error");
        exit(0);
    }

    int num = 0;

    char line[1024];
    while (fgets(line, sizeof(line), fl)){
        if ((size_lst+1) >= cap_lst){
            cap_lst *= 2;
            list_of_cmd.list = realloc(list_of_cmd.list, cap_lst*sizeof(cmd_t));
        }

        list_of_cmd.list[size_lst].cmd = malloc((strlen(line)+1)*sizeof(char));
        strcpy(list_of_cmd.list[size_lst].cmd, line);
        list_of_cmd.list[size_lst++].ind = num;
        num++;
    }

    list_of_cmd.len = num;
    fclose(fl);
    return list_of_cmd;
}

void writeCommands(lst_t list, int size_from_cmd, int size_to_cmd){
    int num = 0;
    for (int i = (list.len-1-size_from_cmd); i >= (list.len-size_to_cmd); i--){
        printf("%d: %s", num, list.list[i].cmd);
        num++;
    }
    for (int i = 0; i < list.len; i++){
        free(list.list[i].cmd);
    }
    free(list.list);
}