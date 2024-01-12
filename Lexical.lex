%{

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#define YYSTYPE struct Digits
#include "VarClass.h"
#include "SyntaxInter.tab.h"


%}



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







int yywrap(){return 1;}