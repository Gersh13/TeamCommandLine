grammer GrammerForPython;





// If/else block
ifElse: 'if' control_expression
        then_clause
        else_clause;


//Variables Definitions



// While and For Loops
while: 'while' control_expression body
        
forLoop: 'for' expr1; expr2; expr3
          statement


//Arithmetic Operators



// Assignment Operators



// Conditional Statements
CONDSTAT: '<' | '<=' | '>' | '>=' | '==' | '!=' | 'and' | 'or' | 'not' ;

// Endline/Newline
ENLINE: '\r' ? '\n' | '\r';

// Whitespaces
WS: [ \r\n\t] + -> skip;

// Comments
COMMENTS: '#' ~( '\r' | '\n' )*;

//...


//Rules

If: 'if';
Else: 'else';
While: 'while';
For: 'for';

