grammar Declaraciones;

/*
    Parser
*/
string: (' "' STR '" ')*;

anytype: BOOL | string | NUMBER | STR;

var : STR;

values: NUMBER | var;

arithmeticOperation : values OPERATOR values arithmeticOperation
                    | values OPERATOR values;

toEqual: anytype | var | arithmeticOperation;

declare: data_types var EQUALS toEqual DELIMITATOR
        | data_types var DELIMITATOR;

data_types: BOOLEAN
          | STRING
          | INTEGER
          | DATE
          | TIMEOF
          | REALS
          | UTC
          | ANYTYPE
          | VOID;

caller: THIS DOT var | className STATIC_CALLER var | anytype;

conditions: caller BOOL_OPS caller;

evaluator: OPENPAR conditions CLOSEPAR
         | OPENPAR conditions BOOL_OPS OPENPAR conditions CLOSEPAR CLOSEPAR
         | conditions BOOL_OPS conditions
         | conditions;

return: RETURN anytype;

className: STR;

if: IF evaluator return DELIMITATOR
  | IF evaluator return return DELIMITATOR
  | IF evaluator return DELIMITATOR ELSE return DELIMITATOR;

forSelect: SELALL | STR | var className INDEX HINT className ;

select: SELECT forSelect FROM className WHERE evaluator | SELECT forSelect WHERE evaluator;

coma: ', ';

callFunc: var DOT var
        | callFunc OPENPAR CLOSEPAR
        | var STATIC_CALLER  var OPENPAR var OPENPAR (string coma)* (string coma)* var (coma)* callFunc SELALL arithmeticOperation CLOSEPAR
        | var OPENPAR (string coma)*  callFunc CLOSEPAR
        | var callFunc
        | var STATIC_CALLER var OPENPAR var CLOSEPAR
        | var COUNT;

whileins: callFunc  DELIMITATOR whileins
        | callFunc DELIMITATOR
        ;

while: WHILE (select '{ ')* (whileins ' }')*;

/*
    Lex
*/
COUNT: '++';
WHERE: 'where';
FROM: 'from';
SELALL: '*';
HINT: 'hint';
INDEX: 'index';
SELECT: 'select';
WHILE: 'while';
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

OPERATOR : '+'
          |'*'
          |'/'
          |'-';
CLOSECOMI: '"';
OPENCOMI: '"';
VOID: 'void';
ANYTYPE: 'anyType';
UTC: 'utcDateTime';
REALS: 'decimal';
TIMEOF: 'timeOfDay';
DATE: 'date';
INTEGER: 'int';
STRING: 'str';
BOOLEAN : 'boolean';
BOOL: 'true' | 'false';
STR: [[a-zA-Z]+ ;
NUMBER: [0-9]+ ;
WHITESPACE : [ \t\r\n]+ -> skip;