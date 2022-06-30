%{#include<stdlib.h>
#include<stdio.h>
#include<string.h>

int yylex();

FILE *par;
void yyerror(char *s) {fprintf(par,"ERROR\n");}
int yywrap(void) {
 return 1;
}

%}

%union{
int num;
char *str;
}

%token<str> ID IF WHILE LPARENTHESIS RPARENTHESIS ASSIGN SEMICOL LBRAC RBRAC LSQR RSQR OPR TYPE COMMA RET
%token<num> NUM

%%

     
STM  :  declare_vr  
        | declare_fun 
        | define_fun
        | call_f
        | IF_ST 
        | WHILE_ST 
        | parts
        ;

IF_ST : IF LPARENTHESIS EXP RPARENTHESIS LBRAC body RBRAC {fprintf(par,"   Id-if\n");}
         |IF LPARENTHESIS EXP RPARENTHESIS LBRAC body RBRAC "else" LBRAC body RBRAC {fprintf(par,"  Id-if "); 
         fprintf(par," Id-else \n");}
         ;
        
WHILE_ST : WHILE LPARENTHESIS EXP RPARENTHESIS LBRAC body RBRAC {fprintf(par," Id-While\n");}
           ; 
           

parts: | ID ASSIGN EXP SEMICOL                      {fprintf(par,"Var: %s  ",$1);}
           | ID LSQR EXP RSQR ASSIGN EXP SEMICOL         {fprintf(par,"Var: %s  ",$1);}
           | ID OPR OPR SEMICOL                      {fprintf(par,"Var: %s  ",$1);}    
           | ID OPR OPR SEMICOL                        {fprintf(par,"Var: %s  ",$1);} 
           ;
call_f :   ID LPARENTHESIS args RPARENTHESIS SEMICOL {fprintf(par,"Var- %s ",$1);fprintf(par,"FUN-CALL\n");}
           | RET EXP SEMICOL               {fprintf(par," RET\n");}  
           | RET LBRAC EXP RBRAC SEMICOL  {fprintf(par," RET\n");}
           | ID LPARENTHESIS RPARENTHESIS SEMICOL {fprintf(par,"Var- %s ",$1);fprintf(par,"\nFUN-CALL\n");}
          ;
declare_vr :  | TYPE ID LSQR EXP RSQR SEMICOL {fprintf(par,"local var: %s\n",$2);}
        | TYPE ID LSQR EXP RSQR ASSIGN EXP SEMICOL   {fprintf(par,":= \nLocal var- %s  ",$2);}
        | TYPE ID  SEMICOL {fprintf(par,"local var %s\n",$2);}
        | TYPE ID ASSIGN EXP SEMICOL {fprintf(par,":= \nlocal var: %s\n",$2);}
        ;
                             
define_fun : TYPE ID LPARENTHESIS args_fun RPARENTHESIS LBRAC body RBRAC {fprintf(par,"Id-%s\n",$2);}
            | TYPE ID LPARENTHESIS  RPARENTHESIS LBRAC body RBRAC {fprintf(par,"Id-%s\n",$2);}
            ; 

declare_fun : TYPE ID LPARENTHESIS args_fun RPARENTHESIS SEMICOL {fprintf(par,"Var- %s ",$1);
          fprintf(par,"Function Declaration: %s \n",$2);}
          ;
                           

args :    | args COMMA EXP {fprintf(par,"FUN-ARG\n");} 
          | EXP {fprintf(par,"FUN-ARG\n");}      
          ;
                     

                   
body : STM
          | body STM 
          ;   
        
args_fun : TYPE ID {fprintf(par,"Id-main\n");fprintf(par,"function argument: %s\n",$2);}
         | TYPE ID COMMA args_fun {fprintf(par,"function arg: %s\nFunction body\n",$2);}
         ;
               


EXP : ID                   {fprintf(par," var- %s  ",$1);}
     | NUM                 {fprintf(par," Const: %d  ",$1);}
     | LSQR EXP RSQR         
     | EXP COMMA EXP
     | ID EXP      
     | EXP OPR EXP      
     | LPARENTHESIS EXP RPARENTHESIS 
     ;
     

    

%%



int main(int argc[],char *argv[]){
extern FILE *yyin,*yyout;
yyin=fopen(argv[1],"r");
par=fopen("Parser.txt","w");
yyout=fopen("Lexer.txt","w");

yyparse();

return 0;}
