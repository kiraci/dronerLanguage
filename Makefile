parser: y.tab.c lex.yy.c y.tab.h
	gcc -o parser y.tab.c lex.yy.c y.tab.h
	./parser < CS315f20_team03.test

y.tab.c y.tab.h: CS315f20_team03.yacc
	yacc -v -d CS315f20_team03.yacc

lex.yy.c: CS315f20_team03.lex
	lex CS315f20_team03.lex
clean:
	rm y.* parser lex*