import java_cup.runtime.Symbol;

%%

%class Lexer
%public
%unicode
%cup
%line
%column

%{

private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
}

private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
}

%}

/* MACROS */

LineTerminator = \r|\n|\r\n
WhiteSpace = {LineTerminator} | [ \t\f]

ID = [a-zA-Z_][a-zA-Z0-9_]*
NUMBER = [0-9]+

%%

/* IGNORAR ESPAÇOS */
{WhiteSpace}     { }

/* PALAVRAS RESERVADAS */
"if"             { return symbol(sym.IF); }
"then"           { return symbol(sym.THEN); }
"else"           { return symbol(sym.ELSE); }
"while"          { return symbol(sym.WHILE); }

/* OPERADORES */
"=="             { return symbol(sym.EQ); }
"!="             { return symbol(sym.NE); }
">="             { return symbol(sym.GE); }
"<="             { return symbol(sym.LE); }
">"              { return symbol(sym.GT); }
"<"              { return symbol(sym.LT); }

"+"              { return symbol(sym.PLUS); }
"-"              { return symbol(sym.MINUS); }
"*"              { return symbol(sym.TIMES); }
"/"              { return symbol(sym.DIV); }
"%"              { return symbol(sym.MOD); }

"="              { return symbol(sym.ASSIGN); }

/* SÍMBOLOS */
";"              { return symbol(sym.SEMI); }
"("              { return symbol(sym.LPAREN); }
")"              { return symbol(sym.RPAREN); }
"{"              { return symbol(sym.LBRACE); }
"}"              { return symbol(sym.RBRACE); }

/* IDENTIFICADORES E NÚMEROS */
{ID}             { return symbol(sym.ID, yytext()); }
{NUMBER}         { return symbol(sym.NUMBER, Integer.parseInt(yytext())); }

/* ERRO */
.                { throw new Error("Caractere inválido: " + yytext()); }