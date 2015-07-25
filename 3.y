%{
    #include <cstdio>
	#include <iostream>
	#include <string>
    #include "calc.h"
	using namespace std;
	
    void yyerror(char *s) {
      fprintf (stderr, "%s\n", s);
    }

	extern int yylex (void);



%}

%union {
double     val;  
symrec  *tptr;  
}

%token <val>  NUM        
%token <tptr> VAR FNCT   
%type  <val>  exp
%token NEG

%right '='
%left '-' '+'
%left '*' '/'
%left NEG     
%right '^'   

%debug

%%

input:   
        | input line
;

line:
          '\n'
        | exp '\n'   { printf ("\t%.10g\n", $1); }
        | error '\n' { yyerrok;                  }
;

exp:      NUM                { $$ = $1;                         }
        | VAR                { $$ = $1->value.var;              }
        | VAR '=' exp        { $$ = $3; $1->value.var = $3;     }
        | FNCT '(' exp ')'   { $$ = (*($1->value.fnctptr))($3); }
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