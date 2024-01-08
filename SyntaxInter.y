%{ 
#include "VarClass.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define YYSTYPE struct Digits

int varInd = 1;
char* getVar();

char *genVar(char* resArr, char* first,char op,char* second);
int sumDigits(struct Digits* b);

void plusFunc(struct Digits* res ,struct Digits* a , struct Digits* b);
void minusFunc(struct Digits* res ,struct Digits* a , struct Digits* b);
void mulFunc(struct Digits* res ,struct Digits* a , struct Digits* b);
void divFunc(struct Digits* res ,struct Digits* a , struct Digits* b);

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
     | E END {return 0;}
;

E : T { $$ = $1;}
  | E '+' T 
  {
    plusFunc(&$$ , &$1 , &$3);
    strcpy($$.tmp , genVar($$.arr, $1.tmp , '+' ,$3.tmp));

  }
  | E '-' T  
  {
    minusFunc(&$$ , &$1 , &$3);
    strcpy($$.tmp , genVar($$.arr , $1.tmp , '-' ,$3.tmp));

  }
  ;

T : F 
    { 
    $$ = $1;
    }
  | T '*' F 
  {
    mulFunc(&$$ , &$1 , &$3);
    strcpy($$.tmp , genVar($$.arr , $1.tmp , '*' ,$3.tmp));
  }
  | T '/' F 
  {
    divFunc(&$$ , &$1 , &$3);
    strcpy($$.tmp , genVar($$.arr , $1.tmp , '/' ,$3.tmp));
  }
  ;

F : '(' E ')' { $$ = $2; }
  | NUMBER  { $$ = $1; }
  ;

%%

char *genVar(char* resArr, char* first,char op,char* second){
    char* word = (char*)malloc(sizeof(char) * 1000);
    sprintf(word,"t%d",varInd++);
    printf("%s = %s %c %s\n",word,first,op,second);
    printf("%s = %s\n" , word , resArr);
    return word; //Returns variable name like t1,t2,t3... properly
}

void plusFunc(struct Digits* res ,struct Digits* a , struct Digits* b){
  int flg = 0;
  int size = a->arrSize;
  int ind = size;
  strcpy(res->arr , a->arr);
  for (int i = 0 ; i < b->arrSize ; i++){
    for (int j = 0 ; j < a->arrSize ; j++){
      if (b->arr[i] == a->arr[j]){
        flg = 1;
        break;
      }
    }
    if (flg == 0){
        res->arr[ind++] = b->arr[i];
    }
    flg = 0;
  }
  res->arr[ind] = '\0';
  res->arrSize = ind;
}

void minusFunc(struct Digits* res ,struct Digits* a , struct Digits* b){
  int flg = 0;
  int ind = 0;
  for (int i = 0 ; i < a->arrSize ; i++){
    for (int j = 0 ; j < b->arrSize ; j++){
      if (a->arr[i] == b->arr[j]){
        flg = 1;
        break;
      }
    }
    if (flg == 0){
      res->arr[ind++] = a->arr[i];
    }
    flg = 0;
  }
  res->arrSize = ind;
  res->arr[ind] = '\0';
}

int sumDigits(struct Digits* b){
  int result = 0;
  for (int i = 0 ; i < b->arrSize ; i++){
    result += (b->arr[i] - '0');
    if (result > 9){
      int tmp = result;
      result = 0;
      while (tmp != 0){
        result += tmp % 10;
        tmp /= 10;
      }
    }
  }
  return result;
}


void mulFunc(struct Digits* res ,struct Digits* a , struct Digits* b){
  int result = sumDigits(b);

  strcpy(res->arr , a->arr);
  res->arrSize = a->arrSize;
  int flg = 0;
  for (int j = 0 ; j < res->arrSize ; j++){
    if (a->arr[j] == (result + '0')){
      flg = 1;
      break;
    }
  }
  if (flg == 0){
    res->arr[a->arrSize] = result + '0';
    res->arr[a->arrSize + 1] = '\0';
    res->arrSize = res->arrSize + 1;
  }
}


void divFunc(struct Digits* res ,struct Digits* a , struct Digits* b){
  int result = sumDigits(b);
  res->arrSize = 0;
  int ind = 0;
  for (int j = 0 ; j < a->arrSize ; j++){
    if (a->arr[j] != (result + '0')){
      res->arr[ind++] = a->arr[j];
    }
  }
  res->arr[ind] = '\0';
  res->arrSize = ind;
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