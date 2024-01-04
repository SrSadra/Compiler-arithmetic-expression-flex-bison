%{ 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "VarClass.h"
#define YYSTYPE struct Digits*

int varInd = 1;
char* getVar();
char* plusFunc(struct Digits* a, struct Digits* b);
char *genVar(char* first,char op,char* second);

%}
 

%token NUMBER
%token END

%left '+' '-'
%left '*' '/'

%start Input
%%

Input:
     | Input Line
;

Line:
     END
     | E END { printf("-t%d = %d-" , varInd , $1->tmp); return 0;}
;

E : T { $$ = $1;}
  | E '+' T 
    { 
      printf("ajab%s" , $1->tmp);
    printf("%s\n", $1->arr );
    $$->tmp = genVar($1->tmp , '+' , $3->tmp);
    $$->arr = plusFunc($1 , $3);
    }
  | E '-' T 
    { 
    $$->tmp = genVar($1->tmp , '-' , $3->tmp);
    $$->arr = plusFunc($1 , $3);
    }
  ;

T : F 
    { 
    $$ = $1;
    }
  | T '*' F 
    { 
    $$->tmp = genVar($1->tmp , '*' , $3->tmp);
    $$->arr = plusFunc($1 , $3);
    }
  | T '/' F 
    { 
    $$->tmp = genVar($1->tmp , '/' , $3->tmp);
    }
  ;

F : '(' E ')' { $$ = $2; }
  | NUMBER  { $$ = $1; }
  ;

%%

char *genVar(char* first,char op,char* second)
{
    char* word = (char*)malloc(sizeof(char) * 1000);
    sprintf(word,"t%d",varInd++);
    printf("%s = %s %c %s\n",word,first,op,second);

    return word; //Returns variable name like t1,t2,t3... properly
}


char* plusFunc(struct Digits* a , struct Digits* b){
  int flg = 0;
  char temp[2];
  for (int i = 0 ; i < b->arrSize ; i++){
    for (int j = 0 ; j < a->arrSize ; j++){
      if (b->arr[i] == a->arr[j]){
        flg = 1;
        break;
      }
    }
    if (flg == 0){
        temp[0] = b->arr[i];
        temp[1] = '\0';  // Null-terminate the string
        strcat(a->arr, temp);
    }
    flg = 0;
  }
  return a->arr;
}



int main() {
    printf("Enter the expression\n");
    yyparse(); //when main calls yyparse() (which will be created by bison) it will call yylex() (which will be created by flex) to get the next token.
    return 0;
}

/* For printing error messages */
int yyerror(char* s) {
    printf("\n---%s\n" , s);
    return 0;
}
