%{
    #include <cstdio>
	#include <iostream>
	#include <string>
	using namespace std;
	
    void yyerror(char *s) {
      fprintf (stderr, "%s\n", s);
    }

	extern int yylex (void);
%}

%token NUM

%debug

%%

EVALUATE: EXPR          { printf("=%d\n", $$); } ;

EXPR:    TERM
        | EXPR '+' TERM { $$ = $1 + $3; }
        | EXPR '-' TERM { $$ = $1 - $3; }
;

TERM:    NUM
        | TERM '*' NUM  { $$ = $1 * $3; }
        | TERM '/' NUM  { $$ = $1 / $3; }
;

%%

int main()
{
	//yydebug=1;
	yyparse();
}