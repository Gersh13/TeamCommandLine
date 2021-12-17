grammer GrammerForPython;





// If/else block in python - if(...):
// While- while(...):
//For Loops - for x in something:  
//variables defintions
statement: controlExpr=expr                             
         | 'print(' controlExpr=expr ')'  
         | 'if' if_controlExpr=expr ENDCOLONS ENLINE if_body=statement_body ('elif' elif_controlExpr=expr ENDCOLONS ENLINE elif_body=statement_body)* ('else' ENDCOLONS ENLINE else_body=statement_body)?
         | 'while' controlExpr=expr ':' ENLINE body=statement_body
         | 'for' vars=VARS ' in range(' start=expr ',' last=expr ')' ENDCOLONS ENLINE body=statement_body
         | vars=VARS asgnmnt=ASGNMNT controlExpr=expr
         | vars=VARS EQUAL controlExpr=expr
         | CRTCOMMENTS;


//Variables Definitions
VARS: [a-zA-Z_][a-zA-Z0-9_]*;




//Arithmetic Operators
ARTHMT: '+'|'-'|'/'|'*'|'^'|'%';





// Assignment Operators
ASGNMNT: '+='|'-='|'*='|'/='|'^='|'%=';


// Conditional Statements
CONDIT: '<'|'<='|'>'|'>='|'=='|'!=';


//Rules
ENDCOLONS: ':';
ENLINE: '\r' ? '\n' | '\r';
CRTCOMMENTS: '#'(~[\r\n])*; //# comment in python
EQUAL: '=';
