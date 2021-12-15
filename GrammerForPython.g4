grammer GrammerForPython;





// If/else block
if: 'if' '(' control_expression ')'
         then_clause;
         
ifElse: 'if' '(' control_expression ')'
              then_clause
         'elif' '(' control_expression ')'
               else_clause;


//Variables Definitions



// While and For Loops
while: 'while' '(' control_expression ')' 
        body;
        
forLoop: 'for' expr1 'in' list
          statement;


//Arithmetic Operators



// Assignment Operators



// Conditional Statements


//...


