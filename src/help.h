#pragma once

typedef struct cmd
{
    int ind;
    char* cmd;
}cmd_t;

typedef struct lst
{
    cmd_t* list;
    int len;
}lst_t;

void show_help(const char *program_name);
int isnum(char* stroke);
lst_t readCommands();
void writeCommands(lst_t list, int size_from_cmd, int size_to_cmd);