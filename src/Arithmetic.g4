grammar Arithmetic;

/*
 * Parser Rules
 */

sum  : NUMBER '+' NUMBER
       | VARIABLE '+' VARIABLE
       | NUMBER '+' VARIABLE
       | VARIABLE '+' NUMBER;
division : NUMBER '/' NUMBER
           | VARIABLE '/' VARIABLE
           | NUMBER '/' VARIABLE
           | VARIABLE '/' NUMBER;
multiplying : NUMBER '*' NUMBER;
substraction : NUMBER '-' NUMBER;

/*
 * Lexer Rules
 */

NUMBER     : [0-9]+ ;
VARIABLE : [a-z]+ ;

WHITESPACE : ' ' -> skip ;