%{
	#include <stdio.h>
	#include "y.tab.h"
	void yyerror(char *);
%}

number [0-9]
lowerLetter [a-z]
upperLetter [A-Z]
alphabet [A-Za-z_$]
className {upperLetter}+

leftBracket \(
rightBracket \)
leftCurlyBracket \{
rightCurlyBracket \}
leftSqBracket \[
rightSqBracket \]

assignRightLeft <-
assignLeftRight ->
equalOp ==
notEqualOp !=
greaterThanOp >
lessThanOp <
greaterThanEqualOp >=
lessThanEqualOp <=

orOp \|\|
andOp \&\&
notOp \!
colon \:
semicolon \;
comma \,
dot \.

addOp \+
subOp \-
multOp \*
divOp \/
exponentOp \^

newLine \n
space [ ]+
tab [\t]

sign[+|-]

classIdent droner
boolean yes|no|true|false|on|off
dronerIn droner.in
dronerOut droner.out
function func
main launch
classDec class
return return
call_func call

if if
then then
elseDo elseDo
for for
while while
do do

digit number
bool boolean
real real
str string
chr character
void none

read-inclination readInclination
read-altitude readAltitude
read-temperature readTemperature
read-acceleration readAcceleration
control-camera camera
take-picture takePhoto
read-timestamp getTimeStamp
connect-computer connectComputer

comment [#].*
integers ({sign}?{number}+)
float ({sign}?{number}+(\.)?{number}+)
ident ({alphabet}+{number}*)
string \".*\"
char \'{upperLetter}\'|\'{lowerLetter}\'|\'{number}\'

%option yylineno
%%

{leftBracket} return LEFT_BRACKET;
{rightBracket} return RIGHT_BRACKET;
{leftCurlyBracket} return LEFT_CURLY_BRACKET;
{rightCurlyBracket} return RIGHT_CURLY_BRACKET;
{leftSqBracket} return LEFT_SQUARE_BRACKET;
{rightSqBracket} return RIGHT_SQUARE_BRACKET;
{assignRightLeft} return ASSIGN_RIGHT_TO_LEFT_OP;
{assignLeftRight} return ASSIGN_LEFT_TO_RIGHT_OP;
{equalOp} return EQUALITY_OP;
{notEqualOp} return NOT_EQUAL_OP;
{greaterThanOp} return GREATER_THAN_OP;
{lessThanOp} return LESS_THAN_OP;
{greaterThanEqualOp} return GREATER_THAN_EQUAL_OP;
{lessThanEqualOp} return LESS_THAN_EQUAL_OP;
{orOp} return OR;
{andOp} return AND;
{notOp} return NOT;
{colon} return COLON;
{semicolon} ;
{comma} return COMMA;
{dot} return DOT;
{addOp} return ADD_OP;
{subOp} return SUBTRACT_OP;
{multOp} return MULTIPLY_OP;
{divOp} return DIVIDE_OP;
{exponentOp} return EXPONENT_OP;
{newLine} ;
{space} ;
{tab} ;
{sign} return SIGN;
{classIdent} return CLASS_IDENT;
{boolean} return BOOLEAN;
{dronerIn} return INPUT;
{dronerOut} return OUTPUT;
{function} return FUNC;
{main} return MAIN;
{classDec} return CLASS;
{if} return IF;
{then} return THEN;
{elseDo} return ELSE_DO;
{for} return FOR;
{while} return WHILE;
{do} return DO;
{digit} return INT_TYPE;
{bool} return BOOLEAN_TYPE;
{real} return REAL_TYPE;
{str} return STRING_TYPE;
{chr} return CHAR_TYPE;
{void} return VOID_TYPE;
{comment} return COMMENT;
{integers} return INTEGER;
{float} return REAL;
{return} return RETURN;
{read-inclination} return READ_INC;
{read-altitude} return READ_ALT;
{read-temperature} return READ_TEMP;
{read-acceleration} return READ_ACC;
{control-camera} return CONTROL_CAM;
{take-picture} return TAKE_PIC;
{read-timestamp} return READ_TIME;
{connect-computer} return CONNECT_PC;
{className} return UPPER_LETTER;
{string} return STRING;
{char} return CHAR;
{call_func} return FUNC_CALL;
{ident} return IDENTIFIER;

%%
int yywrap(void){
	return 1;
}