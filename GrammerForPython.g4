grammer GrammerForPython;





// If/else block
statement: controlExpr=expr                             
         | 'print(' controlExpr=expr ')'  
         | 'if' if_controlExpr=expr ENDCOLONS ENLINE if_block=statement_block ('elif' elif_controlExpr=expr ENDCOLONS ENLINE elif_block=statement_block)* ('else' ENDCOLONS ENLINE else_block=statement_block)? #ifStatement


//Variables Definitions
VARS: [a-zA-Z_][a-zA-Z0-9_]*;


// While and For Loops



//Arithmetic Operators
ARTHMT: '+'|'-'|'/'|'*'|'^'|'%';





// Assignment Operators
ASGNMNT: '+='|'-='|'*='|'/='|'^='|'%=';


// Conditional Statements
CONDIT: '<'|'<='|'>'|'>='|'=='|'!=';

//...

ENDCOLONS: ':';
ENLINE: '\r' ? '\n' | '\r';
