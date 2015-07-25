%{
	#include "calc.h"
    #include "3.tab.hpp"
    #include <cmath>
    #include <string>
    using namespace std;
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
.               { return *yytext; }

%%