grammar simpleCalc;

/* A grammar for arithmetic expressions

Variables: start, expr
Terminals: EOF (end of file, a builtin symbol),
           '+', '*',  NUM, ID, and the ignored WHITESPACE

ANTLR Notation: 

Instead of the usual grammar notation
  Variable -> alpha_1 | ... | alpha_n
the ANTLR notation is
  Variable :  alpha_1 | ... | alpha_n ;

The labels like "#Addition" help later in processing the parse tree.

*/


start   : assignment* expr EOF ;

assignment : ID '=' expr ';' ;

expr	: expr OP2 expr # Multiplication
	| expr OP1 expr # Addition
	| NUM  	        # Constant
	| ID            # Variable
	| '(' expr ')'  # Parenthesis
	;

OP2 : ('*'|'/') ;
OP1 : ('+'|'-') ;

NUM 	: ('0'..'9')+ ;
ID	: ('A'..'Z'|'a'..'z'|'_')* ;
WHITESPACE : [ \n\t\r]+ -> skip;

