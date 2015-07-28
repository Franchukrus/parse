%{
    #include <cstdio>
	#include <iostream>
	#include <string>
    #include <cmath>
    #include "calc.h"
	using namespace std;
    double result;
    double x;
    void yyerror(char *s) {
      fprintf (stderr, "%s\n", s);
    }

	extern int yylex (void);

    struct yy_buffer_state;
    typedef struct yy_buffer_state* YY_BUFFER_STATE;
    extern YY_BUFFER_STATE yy_scan_string ( const char *str );
    extern void yy_delete_buffer (YY_BUFFER_STATE b  );
%}

%union {
    double val;
    func_t func;
}

%token <val>  NUM
%token <func> FNCT
%type  <val>  exp
%token VAR

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
        | exp '\n'   { result=$1; }
        | error '\n' { yyerrok;                  }
        | VAR '=' exp        { x = $3;                         }
;

exp:      NUM                { $$ = $1;                         }
        | VAR                { $$ = x;                          }
        | VAR '=' exp        { x = $3;                         }
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

double parser(double X, string mmathematical_expression)
{
    x=X;
    YY_BUFFER_STATE buffer = yy_scan_string(mmathematical_expression.c_str());
    yyparse();
    yy_delete_buffer(buffer);
    return result;
}
