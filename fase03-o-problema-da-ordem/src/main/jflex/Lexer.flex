package br.maua.cic303;

import java_cup.runtime.Symbol;

%%

%class Lexer
%public
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

WhiteSpace = [ \t\r\n]+
Identifier = [a-zA-Z][a-zA-Z0-9_]*
Number = [0-9]+

%%

{WhiteSpace} { }

"if" { return symbol(sym.IF); }
"then" { return symbol(sym.THEN); }
"else" { return symbol(sym.ELSE); }
"while" { return symbol(sym.WHILE); }

"(" { return symbol(sym.LPAREN); }
")" { return symbol(sym.RPAREN); }

"{" { return symbol(sym.LBRACE); }
"}" { return symbol(sym.RBRACE); }

";" { return symbol(sym.SEMI); }

"=" { return symbol(sym.ASSIGN); }

"+" { return symbol(sym.PLUS); }
"-" { return symbol(sym.MINUS); }

"*" { return symbol(sym.TIMES); }
"/" { return symbol(sym.DIV); }
"%" { return symbol(sym.MOD); }

"==" { return symbol(sym.EQ); }
"!=" { return symbol(sym.NE); }

"<=" { return symbol(sym.LE); }
">=" { return symbol(sym.GE); }

"<" { return symbol(sym.LT); }
">" { return symbol(sym.GT); }

{Identifier} {
    return symbol(sym.ID, yytext());
}

{Number} {
    return symbol(sym.NUMBER, yytext());
}

. {
    throw new RuntimeException("Erro Léxico");
}