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
    YY_BUFFER_STATE buffer = yy_scan_string("1+2\nlog(10)\n");
	yyparse();
    yy_delete_buffer(buffer);
}
