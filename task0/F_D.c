#include <ctype.h>
#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


void print_d(char* link){
    FILE* my_file;
    my_file=fopen(link,"r");
    int i=fileno(my_file);
    printf("%d",i);
    printf("%c",'\n');
    fclose(my_file);
    printf("%s","CLOSING DONE");    
    printf("%c",'\n');
}

int main(int argc, char** argv){
    print_d(argv[1]);
    return 0;
}