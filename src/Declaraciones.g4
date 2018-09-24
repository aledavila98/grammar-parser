grammar Declaraciones;

/*
    Parser
*/
anytype: BOOL | STR | NUMBER;

var : STR;

values: NUMBER | var;

arithmeticOperation : values OPERATOR values;

data_types: BOOLEAN
          | STRING
          | INTEGER
          | DATE
          | TIMEOF
          | REALS
          | UTC
          | ANYTYPE
          | VOID;

toEqual: anytype | var | arithmeticOperation;

declare : data_types var EQUALS toEqual DELIMITATOR
        | data_types var DELIMITATOR;

caller: THIS DOT var | className STATIC_CALLER var | anytype;

conditions: caller BOOL_OPS caller;

evaluator: OPENPAR conditions CLOSEPAR
         | OPENPAR conditions BOOL_OPS OPENPAR conditions CLOSEPAR CLOSEPAR;

return: RETURN anytype;

className: STR;

if: IF evaluator return DELIMITATOR
  | IF evaluator return return DELIMITATOR
  | IF evaluator return DELIMITATOR ELSE return DELIMITATOR;

/*
    Lex
*/
STRINGFORMAT : 'strFmt';
IF: 'if';
ELSE: 'else';
RETURN: 'return';
CLOSEPAR: ')';
OPENPAR: '(';
BOOL_OPS: '&&'
        | '||'
        | '=='
        | '<'
        | '>'
        | '<='
        | '>=';
STATIC_CALLER: '::';
DOT: '.';
THIS: 'this';
DELIMITATOR: ';';
EQUALS: '=';
VOID: 'void';
ANYTYPE: 'anyType';
UTC: 'utcDateTime';
REALS: 'decimal';
TIMEOF: 'timeOfDay';
DATE: 'date';
INTEGER: 'int';
STRING: 'str';
BOOLEAN : 'boolean';
OPERATOR : '+'
          |'*'
          |'/'
          |'-';
STR: [[a-zA-Z]+ ;
NUMBER: [0-9]+ ;
BOOL: 'true' | 'false';
WHITESPACE : [ \t\r\n]+ -> skip;