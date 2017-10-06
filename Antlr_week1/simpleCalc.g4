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


start   : statement* expr EOF ;

statement2 : statement;

statement : ID '=' expr ';' #Assigment
		|'WHILE' '(' condition ')' 'DO' '{' statement* '}' ';' #While
		|'IF' '(' condition ')' 'DO' '{' statement* '}' ';' #If
		|'IF' '(' condition ')' 'DO' '{' statement* '}' 'ELSE DO' '{' statement2* '}' ';' #IfElse
		;

condition : 'NOT' condition #ConditionNOT
		| condition 'AND' condition #ConditionAND
		| condition 'OR' condition #ConditionOR
		| expr COND expr #Compare
		| '(' condition ')'  #ConditionParenthesis
		;


expr	: expr OP2 expr # Multiplication
	| expr OP1 expr # AdditionSub
	| NUM  	        # Constant
	| ID            # Variable
	| '(' expr ')'  # Parenthesis
	;

OP2 : ('*'|'/') ;
OP1 : ('+'|'-') ;

COND : ('=='|'!='|'<'|'>'|'<='|'>=');

NUM 	: ('0'..'9')+ ;
ID	: ('A'..'Z'|'a'..'z'|'_')* ;
WHITESPACE : [ \n\t\r]+ -> skip;
