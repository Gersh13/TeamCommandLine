grammer GrammerForPython;





// If/else block
statement: controlExpr=expr                             
         | 'print(' controlExpr=expr ')'  
         | 'if' if_controlExpr=expr ENDCOLONS ENLINE if_block=statement_block ('elif' elif_controlExpr=expr ENDCOLONS ENLINE elif_block=statement_block)* ('else' ENDCOLONS ENLINE else_block=statement_block)? #ifStatement



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
