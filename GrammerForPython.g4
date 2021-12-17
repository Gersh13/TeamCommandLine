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


expr: 
     | var=VARS                                  #variables expression
     | atom=INTEGER                              #int expression 
     | atom=FLOAT                                #float expression
     | atom=STRING                               #string expression
     | 'str(' exp=expr ')'                       #convert to a string 
     | 'int('exp=expr')'                         #convert to an int
     | 'break'                                   #thebreak statment 
     | '(' exp=expr ')'                          #parenthesis statment
     | left=expr 'and' right=expr                #the and statment
     | l=expr arth=ARTHMT r=expr                   #arithmeticExpr
     | left=expr cndl=CONDIT right=expr            #conditionalExpr


     ;




//Variables Definitions
VARS: [a-zA-Z_][a-zA-Z0-9_]*;

// Integers (Be sure to check for Unary vs Negative)
INT: '-' ? [0-9]+;

// Floats (Be sure to check for Unary vs Negative)
FLT: '-' ? ([0-9]*[.]) ? [0-9]+;

// Strings
STR: '"' ('\\' ["\\] | ~["\\\r\n])* '"';

// Tab Spacings
TAB: ('\t'|'    ');


// While and For Loops


//Arithmetic Operators
ARTHMT: '+'|'-'|'/'|'*'|'^'|'%';


// Assignment Operators
ASGNMNT: '+='|'-='|'*='|'/='|'^='|'%=';


// Conditional Statements
CONDIT: '<'|'<='|'>'|'>='|'=='|'!='|'and'|'or'|'not';


// Whitespaces
WS: [ \r\n\t] + -> skip;

// Comments
//COMMENTS: '#' ~( '\r' | '\n' )*;

//...

//Rules

//  Colons
ENDCOLONS: ':';

// End of Lines
ENLINE: '\r' ? '\n' | '\r';
CRTCOMMENTS: '#'(~[\r\n])*; //# comment in python
EQUAL: '=';

