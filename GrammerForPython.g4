grammer GrammerForPython;


// If/else block
// Python If: if(...):

if: 'if' '(' control_expression ')' ':'
         then_clause;
         
//if(...):
//elif(...):

ifElse: 'if' '(' control_expression ')' ':'
              then_clause
         'elif' '(' control_expression ')' ':'
               else_clause;


//Variables Definitions



// While and For Loops
//while(...):
while: 'while' '(' control_expression ')' ':'
        body;
        
        
//for x in ... :
forLoop: 'for' expr1 'in' list ':'
          statement;


//Arithmetic Operators
ARITH_OP: ( '+' | '-' | '*' | '/' | '%' | '^' );



// Assignment Operators
ASGNMNT_OP: ( '=' | '+=' | '-=' | '*=' | '/=' | '^=' '%=' );


// Conditional Statements
CONDSTAT: '<' | '<=' | '>' | '>=' | '==' | '!=';

// Endline/Newline
ENLINE: '\r' ? '\n' | '\r';

// Whitespaces
WS: [ \r\n\t] + -> skip;

// Comments
COMMENTS: '#' ~( '\r' | '\n' )*;

//...


//Rules
INT: [0-9]+ ;

