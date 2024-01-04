%{
#include "SyntaxInter.tab.h"
#include <stdlib.h>
#include <string.h>
#include "VarClass.h"
#include <stdio.h>
#define YYSTYPE struct Digits


%}

struct Digits getDigits(int val)


digit [0-9]
integer {digit}+
space [ \t]+   

/* For skipping whitespaces */

 
%% 

{integer}  { 
            yylval =  getDigits(atoi(yytext));
            return NUMBER;
            } 

{space} ;

"+" {return '+';}
"-" {return '-';}
"*" {return '*';}
"/" {return '/';}
"(" {return '(';}
")" {return ')';}

"\n" {return END;}

%%


void reverseString(char* str) {
    int length = strlen(str);
    for (int i = 0; i < length / 2; i++) {
        char temp = str[i];
        str[i] = str[length - i - 1];
        str[length - i - 1] = temp;
    }
}

struct Digits* getDigits(int val){
    printf("%d" ,val);
    struct Digits* digits =(struct Digits*) malloc(sizeof(struct Digits));
    digits->value = val;
    int i = 0;
    digits->arr = (char*) malloc(sizeof(char) * 1000);
    digits->arrSize = 0;
    while (val != 0){
        digits->arr[i++] = (val  % 10) + '0';
        val /= 10;
    };
    digits->arr[i] = '\0';
    digits->arrSize = i;
    reverseString(digits->arr);
    digits->tmp = (char*) malloc(sizeof(char) * 1000);
    strcpy(digits->tmp , digits->arr);
    printf("alo");
    return digits;
}



int yywrap(){return 1;}


