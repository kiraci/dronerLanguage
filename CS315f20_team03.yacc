%{
	#include <stdio.h>
	#include <stdlib.h>
	int yylex(void);
	void yyerror(char* s);
	extern int yylineno;
%}

%token LEFT_BRACKET
%token RIGHT_BRACKET
%token LEFT_CURLY_BRACKET
%token RIGHT_CURLY_BRACKET
%token LEFT_SQUARE_BRACKET
%token RIGHT_SQUARE_BRACKET
%nonassoc EQUALITY_OP
%nonassoc NOT_EQUAL_OP
%left GREATER_THAN_OP
%left LESS_THAN_OP
%left GREATER_THAN_EQUAL_OP
%left LESS_THAN_EQUAL_OP
%token OR
%token AND
%token NOT
%token COLON
%token COMMA
%token DOT
%token ADD_OP
%token SUBTRACT_OP
%token MULTIPLY_OP
%token DIVIDE_OP
%token EXPONENT_OP
%token SIGN
%token CLASS_IDENT
%token BOOLEAN
%token INPUT
%token OUTPUT
%token FUNC
%token MAIN
%token CLASS
%token IF
%token THEN
%token ELSE_DO
%token FOR
%token FOREACH
%token WHILE
%token DO
%token INT_TYPE
%token BOOLEAN_TYPE
%token REAL_TYPE
%token STRING_TYPE
%token CHAR_TYPE
%token VOID_TYPE
%token COMMENT
%token INTEGER
%token REAL
%token RETURN
%token IDENTIFIER
%token CHAR
%token STRING
%token READ_INC;
%token READ_ALT;
%token READ_TEMP;
%token READ_ACC;
%token CONTROL_CAM;
%token TAKE_PIC;
%token READ_TIME;
%token CONNECT_PC;
%token UPPER_LETTER;
%token FUNC_CALL;
%left ASSIGN_LEFT_TO_RIGHT_OP
%right ASSIGN_RIGHT_TO_LEFT_OP

%%
program:
	main
	|class_declare
	|class_declare main

main:
	MAIN LEFT_BRACKET RIGHT_BRACKET LEFT_CURLY_BRACKET stmts RIGHT_CURLY_BRACKET

class_declare:
	CLASS GREATER_THAN_OP UPPER_LETTER LESS_THAN_OP LEFT_CURLY_BRACKET stmts RIGHT_CURLY_BRACKET

stmts:
	stmt
	|stmt stmts

stmt:
	loops
	|decision
	|declaration
	|input
	|output
	|constructor_call
	|constructor_declare
	|function_declaration
	|primitive_function_dec
	|COMMENT
	|RETURN parameter_arg
	|assignment
	|precedence

constructor_declare:
	GREATER_THAN_OP UPPER_LETTER LESS_THAN_OP LEFT_BRACKET RIGHT_BRACKET LEFT_CURLY_BRACKET stmts RIGHT_CURLY_BRACKET
	|GREATER_THAN_OP UPPER_LETTER LESS_THAN_OP LEFT_BRACKET parameter_decs RIGHT_BRACKET LEFT_CURLY_BRACKET stmts RIGHT_CURLY_BRACKET

constructor_call:
	GREATER_THAN_OP UPPER_LETTER LESS_THAN_OP IDENTIFIER LEFT_BRACKET parameter_args RIGHT_BRACKET

assignment:
	IDENTIFIER ASSIGN_RIGHT_TO_LEFT_OP assign_expr
	|declaration ASSIGN_RIGHT_TO_LEFT_OP assign_expr
	|assign_expr ASSIGN_LEFT_TO_RIGHT_OP IDENTIFIER
	|assign_expr ASSIGN_LEFT_TO_RIGHT_OP declaration

assign_expr:
	precedence
	|BOOLEAN
	|STRING
	|CHAR

precedence:
	precedence ADD_OP term
	|precedence SUBTRACT_OP term
	|term

term:
	term MULTIPLY_OP factor
	|term DIVIDE_OP factor
	|factor

factor:
	idc EXPONENT_OP factor
	|idc

idc:
	LEFT_SQUARE_BRACKET precedence RIGHT_SQUARE_BRACKET
	|REAL
	|INTEGER
	|IDENTIFIER
	|function_call
	|primitive_function_call

declaration:
	type_ident IDENTIFIER


type_ident:
	INT_TYPE
	|BOOLEAN_TYPE
	|REAL_TYPE
	|STRING_TYPE
	|CHAR_TYPE
	|VOID_TYPE

function_call:
	FUNC_CALL COLON IDENTIFIER LEFT_BRACKET parameter_args RIGHT_BRACKET
	|FUNC_CALL COLON IDENTIFIER DOT IDENTIFIER LEFT_BRACKET parameter_args RIGHT_BRACKET

primitive_function_call:
	CLASS_IDENT DOT primitive_name LEFT_BRACKET parameter_args RIGHT_BRACKET

primitive_name:
	READ_INC
	|READ_ALT
	|READ_TEMP
	|READ_ACC
	|CONTROL_CAM
	|TAKE_PIC
	|READ_TIME
	|CONNECT_PC

parameter_args:
	parameter_arg
	|parameter_arg COMMA parameter_args
	|

parameter_arg:
	IDENTIFIER
	|BOOLEAN
	|INTEGER
	|STRING
	|REAL
	|CHAR

parameter_decs:
	declaration
	|declaration COMMA parameter_decs

function_declaration:
	FUNC declaration LEFT_BRACKET parameter_decs RIGHT_BRACKET LEFT_CURLY_BRACKET stmts RIGHT_CURLY_BRACKET
	|FUNC declaration LEFT_BRACKET RIGHT_BRACKET LEFT_CURLY_BRACKET stmts RIGHT_CURLY_BRACKET

primitive_function_dec:
	CLASS_IDENT BOOLEAN_TYPE CONNECT_PC LEFT_BRACKET INT_TYPE IDENTIFIER RIGHT_BRACKET LEFT_CURLY_BRACKET stmts RIGHT_CURLY_BRACKET
	|CLASS_IDENT REAL_TYPE READ_INC LEFT_BRACKET RIGHT_BRACKET LEFT_CURLY_BRACKET stmts RIGHT_CURLY_BRACKET
	|CLASS_IDENT REAL_TYPE READ_ALT LEFT_BRACKET RIGHT_BRACKET LEFT_CURLY_BRACKET stmts RIGHT_CURLY_BRACKET
	|CLASS_IDENT REAL_TYPE READ_TEMP LEFT_BRACKET RIGHT_BRACKET LEFT_CURLY_BRACKET stmts RIGHT_CURLY_BRACKET
	|CLASS_IDENT REAL_TYPE READ_ACC LEFT_BRACKET RIGHT_BRACKET LEFT_CURLY_BRACKET stmts RIGHT_CURLY_BRACKET
	|CLASS_IDENT VOID_TYPE CONTROL_CAM LEFT_BRACKET BOOLEAN_TYPE IDENTIFIER RIGHT_BRACKET LEFT_CURLY_BRACKET stmts RIGHT_CURLY_BRACKET
	|CLASS_IDENT VOID_TYPE TAKE_PIC LEFT_BRACKET BOOLEAN_TYPE IDENTIFIER COMMA INT_TYPE IDENTIFIER RIGHT_BRACKET LEFT_CURLY_BRACKET stmts RIGHT_CURLY_BRACKET
	|CLASS_IDENT INT_TYPE READ_TIME LEFT_BRACKET RIGHT_BRACKET LEFT_CURLY_BRACKET stmts RIGHT_CURLY_BRACKET

loops:
	while
	|for
	|do_while

while:
	WHILE LEFT_BRACKET logic_precedence RIGHT_BRACKET LEFT_CURLY_BRACKET stmts RIGHT_CURLY_BRACKET

for:
	FOR LEFT_BRACKET assignment COLON expression COLON assignment RIGHT_BRACKET LEFT_CURLY_BRACKET stmts RIGHT_CURLY_BRACKET


do_while:
	DO LEFT_CURLY_BRACKET stmts RIGHT_CURLY_BRACKET WHILE LEFT_BRACKET logic_precedence RIGHT_BRACKET

expression:
	assign_expr relational assign_expr

relational:
	EQUALITY_OP
	|NOT_EQUAL_OP
	|GREATER_THAN_OP
	|LESS_THAN_OP
	|GREATER_THAN_EQUAL_OP
	|LESS_THAN_EQUAL_OP

logic_precedence:
	logic_precedence OR logic_term
	|logic_term

logic_term:
	logic_term AND logic_factor
	|logic_factor

logic_factor:
	NOT logic_idc
	|logic_idc

logic_idc:
	LEFT_BRACKET logic_precedence RIGHT_BRACKET
	|assign_expr
	|expression

decision:
	conditional

conditional:
	if_stmt
	|if_else_stmt

if_stmt:
	 IF LEFT_BRACKET logic_precedence RIGHT_BRACKET THEN LEFT_CURLY_BRACKET stmts RIGHT_CURLY_BRACKET

if_else_stmt:
	IF LEFT_BRACKET logic_precedence RIGHT_BRACKET THEN LEFT_CURLY_BRACKET stmts RIGHT_CURLY_BRACKET ELSE_DO LEFT_CURLY_BRACKET stmts RIGHT_CURLY_BRACKET

input:
	INPUT LEFT_BRACKET IDENTIFIER RIGHT_BRACKET
	|INPUT LEFT_BRACKET parameter_decs RIGHT_BRACKET
	|INPUT LEFT_BRACKET IDENTIFIER COMMA STRING RIGHT_BRACKET
	|INPUT LEFT_BRACKET declaration COMMA STRING RIGHT_BRACKET

output:
	OUTPUT LEFT_BRACKET logic_precedence RIGHT_BRACKET

%%
void yyerror(char *s) {
	fprintf(stdout, "Syntax error on line %d !\n", yylineno);
}

int main(void){
 	yyparse();
	if(yynerrs < 1){
		printf("Input has been parsed and it's accepted!\n");
	}
 	return 0;
}