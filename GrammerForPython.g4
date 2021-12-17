grammer GrammerForPython;





// If/else block
statement: controlExpr=expr                             
         | 'print(' controlExpr=expr ')'  
         | 'if' if_controlExpr=expr ENDCOLONS ENLINE if_block=statement_block ('elif' elif_controlExpr=expr ENDCOLONS ENLINE elif_block=statement_block)* ('else' ENDCOLONS ENLINE else_block=statement_block)? #ifStatement



expr: 
    | var=VARS                                  #variables expression
    | atom=INT                              #int expression 
    | atom=FLT                                #float expression
    | atom=STR                               #string expression
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
COMMENTS: '#' ~( '\r' | '\n' )*;

//...

// Colons
ENDCOLONS: ':';

// End of Lines
ENLINE: '\r' ? '\n' | '\r';

