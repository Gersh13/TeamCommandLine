grammar grammarForPython;

tokens {INDENT, DEDENT}

    /*
    added some custom lexing because lexing indents is a mess
    should work with file
    */


start: (statement | ENLINE)*;

// If/else block in python - if(...):
// While- while(...):
//For Loops - for x in something:
//variables defintions
statement: controlExpr=expr
         | 'print(' controlExpr=expr ')'
         | 'if' if_controlExpr=expr ENDCOLONS ENLINE if_body=stmntField ('elif' elif_controlExpr=expr ENDCOLONS ENLINE elif_body=stmntField)* ('else' ENDCOLONS ENLINE else_body=stmntField)?
         | 'while' controlExpr=expr ':' ENLINE body=stmntField
         | 'for' vars=VARS ' in range(' begin=expr ',' last=expr ')' ENDCOLONS ENLINE body=stmntField
         | vars=VARS asgnmnt=ASGNMNT controlExpr=expr
         | vars=VARS EQUAL controlExpr=expr
         | CRTCOMMENTS;

stmntField: INDENT (stat=statement ENLINE*)+ DEDENT;


expr: atom=STRING                                  #theStringExp
    | atom= VARS                             #theAtomVariabeExp
    | atom= INTEGER                            #theAtomIntegerExp
    | var=FLOAT                              #theAtomFloatExp
    | 'break'                                   #theBreakExp
    | '(' exp=expr ')'                          #theExprForPar
    | left=expr cndl=CONDIT right=expr           #theCondExp
    | l=expr arth=ARTHMT r=expr                   #theMathExp
    | left=expr 'and' right=expr                #theAndExpr
    | 'str(' exp=expr ')'                       #theStrExp
    | 'int('exp=expr')'                         #theIntExp
    ;





//Variables Definitions
VARS: [a-zA-Z_][a-zA-Z0-9_]*;

// Integers (Be sure to check for Unary vs Negative)
INTEGER: '-' ? [0-9]+;

// Floats (Be sure to check for Unary vs Negative)
FLOAT: '-' ? ([0-9]*[.]) ? [0-9]+;

// Strings
STRING: '"' ('\\' ["\\] | ~["\\\r\n])* '"';

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
//ENLINE: '\r' ? '\n' | '\r';
ENLINE: '\n' | '\r\n' | '\r';
CRTCOMMENTS: '#'(~[\r\n])*; //# comment in python
EQUAL: '=';
