%{
#include <stdlib.h>
#include "y.tab.h"
//extern YYSTYPE yylval;
void yyerror(char *s);
//extern FILE *yyout,*yyin;

%}

%%    

"while"         {fprintf(yyout,"key : while\n");return WHILE;}
"int"           {fprintf(yyout,"Datatype : int\n");return TYPE;}
"char"          {fprintf(yyout,"Datatype : char\n");return TYPE;}
"char*"      {fprintf(yyout,"Datatype : char*\n");return TYPE;}
"char**"      {fprintf(yyout,"Datatype : char**\n");return TYPE;}
"if"            {fprintf(yyout,"key : if\n");return IF;}
","             {fprintf(yyout,"Comma : ,\n");return COMMA;}
";"             {fprintf(yyout,"SemiCol : ;  \n");return SEMICOL;}
"|"             {fprintf(yyout,"Or: | \n");return OPR;}
"&"             {fprintf(yyout,"And : &\n");return OPR;}
"-"             {fprintf(yyout,"Ao(subtraction) : -\n");return OPR;}
"+"             {fprintf(yyout,"Ao(addition) : +\n");return OPR;}
"*"             {fprintf(yyout,"Ao(multiplication): * \n");return OPR;}
"/"             {fprintf(yyout,"Ao(division) :  \n");return OPR;}
"="             {fprintf(yyout,"Assignment : =\n");return ASSIGN;}
"("             {fprintf(yyout,"Leftparenthesis : ( \n");return LPARENTHESIS;}
")"             {fprintf(yyout,"Rightparenthesis : ) \n");return RPARENTHESIS;}
"<"             {fprintf(yyout,"Less : < \n");return OPR;}
">"             {fprintf(yyout,"Greater : > \n");return OPR;}
"{"             {fprintf(yyout,"Leftbracket : { \n");return LBRAC;}
"}"             {fprintf(yyout,"Rigthbracket : } \n");return RBRAC;}
"["             {fprintf(yyout,"Lsquare : [\n");return LSQR;}
"]"             {fprintf(yyout,"Rsquare : ]\n");return RSQR;}
">="            {fprintf(yyout,"relational operator : >=\n");return OPR;}
"<="            {fprintf(yyout,"relational operator : <=\n");return OPR;}
"=="            {fprintf(yyout,"relational operator : ==\n");return OPR;}
"!="            {fprintf(yyout,"relational operator : !=\n");return OPR;}
"return"        {fprintf(yyout,"RETURN: return\n");return RET;}

[a-zA-Z][a-zA-Z0-9_]*   {yylval.str=strdup(yytext); fprintf(yyout,"Id : %s\n",yytext);return ID;}

[0-9]+         {yylval.num=atoi(yytext); fprintf(yyout," Num : %s\n",yytext);return NUM;}          
[ \t\n]+       ;
.               {fprintf(yyout,"ERROR \n");}    
%%


