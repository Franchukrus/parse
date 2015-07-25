%{
	#include "calc.h"
    #include "3.tab.hpp"
    #include <cmath>
    #include <string>
    using namespace std;

    double cot(double x)
    {
    	return cos(x)/sin(x);
    }
%}

%option yylineno
%option noyywrap

%%

\n              { return '\n'; }
[/][/].*\n      ; // comment
[0-9]+          { yylval.val = stod(yytext);
                  return NUM;
                }
[ \t\r]      	; // whitespace
sin				{ yylval.func = sin;
				  return FNCT; }
cos				{yylval.func=cos;
				 return FNCT;}
tan				{yylval.func=tan;
				 return FNCT;}
cot				{yylval.func=cot;
				 return FNCT;}
log				{yylval.func=log10;
				 return FNCT;}
.               { return *yytext; }

%%