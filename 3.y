%{
    #include <cstdio>
	#include <iostream>
	#include <string>
    #include <cmath>
    #include "calc.h"
	using namespace std;
	
    void yyerror(char *s) {
      fprintf (stderr, "%s\n", s);
    }

	extern int yylex (void);



%}

%union {
    double val;
    func_t func;
}

%token <val>  NUM        
%token <func> FNCT   
%type  <val>  exp

%right '='
%left '-' '+'
%left '*' '/'
%left NEG     
%right '^'   

%debug

%%

input:  line 
        | input line
;

line:
          '\n'
        | exp '\n'   { cout << $1 << endl; }
        | error '\n' { yyerrok;                  }
;

exp:      NUM                { $$ = $1;                         }
        | FNCT '(' exp ')'   { $$ = ($1)($3); }
        | exp '+' exp        { $$ = $1 + $3;                    }
        | exp '-' exp        { $$ = $1 - $3;                    }
        | exp '*' exp        { $$ = $1 * $3;                    }
        | exp '/' exp        { $$ = $1 / $3;                    }
        | '-' exp  %prec NEG { $$ = -$2;                        }
        | exp '^' exp        { $$ = pow ($1, $3);               }
        | '(' exp ')'        { $$ = $2;                         }
;

%%

int main()
{
	//yydebug=1;
	yyparse();
}