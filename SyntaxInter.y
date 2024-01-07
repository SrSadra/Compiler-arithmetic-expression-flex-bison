%{ 
#include "VarClass.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define YYSTYPE struct Digits

int varInd = 1;
char* getVar();

char* genVar(char* first,char op,char* second);
void plusFunc(struct Digits* res ,struct Digits* a , struct Digits* b);
void minusFunc(struct Digits* res ,struct Digits* a , struct Digits* b);

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
     | E END {printf("%s = %s" , $1.tmp , $1.arr); return 0;}
;

E : T { $$ = $1;}
  | E '+' T 
  {
    plusFunc(&$$ , &$1 , &$3);
    printf("in plus %s , %s , %s\n" , $$.arr  , $1.arr , $3.arr);
    strcpy($$.tmp , genVar($1.tmp , '+' ,$3.tmp));

  }
  | E '-' T  
  {
    minusFunc(&$$ , &$1 , &$3);
    strcpy($$.tmp , genVar($1.tmp , '-' ,$3.tmp));
  }
  ;

T : F 
    { 
    $$ = $1;
    }
  | T '*' F 
  | T '/' F 
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

void plusFunc(struct Digits* res ,struct Digits* a , struct Digits* b){
  int flg = 0;
  int size = a->arrSize;
  char temp[2];
  strcpy(res->arr , a->arr);
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
        strcat(res->arr , temp);
        size++;
    }
    flg = 0;
  }
  res->arrSize = size;
}

void minusFunc(struct Digits* res ,struct Digits* a , struct Digits* b){
  int flg = 0;
  char temp[2];
  int ind = 0;
  res->arr[0] = '\0';
  res->arrSize = 0;
  for (int i = 0 ; i < a->arrSize ; i++){
    for (int j = 0 ; j < b->arrSize ; j++){
      if (a->arr[i] == b->arr[j]){
        flg = 1;
        break;
      }
    }
    if (flg == 0){
      temp[0] = a->arr[i];
      temp[1] = '\0';
      strcat(res->arr , temp);
      res->arrSize += 1;
      printf("\nin minus %s\n" , res->arr);
    }
    flg = 0;
  }
}



int main() {
    printf("Enter the expression\n");
    yyparse(); //when main calls yyparse() (which will be created by bison) it will call yylex() (which will be created by flex) to get the next token.
    return 0;
}

/* For printing error messages */
int yyerror(char* s) {
    printf("okey");
    return 0;
}