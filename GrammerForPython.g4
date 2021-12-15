grammer GrammerForPython;





// If/else block
ifElse: if control_expression
        then_clause
        else_clause;


//Variables Definitions



// While and For Loops
while: while control_expression
        body
        
forLoop: for expr1; expr2; expr3
          statment


//Arithmetic Operators



// Assignment Operators



// Conditional Statements
CONDSTAT: '<' | '<=' | '>' | '>=' | '==' | '!=';

// Comments
COMMENTS: '#' ~( '\r' | '\n' )*;

//...
