grammar grammarForPython;

tokens {INDENT, DEDENT}


@lexer::members {
    private final java.util.Queue<Token> tokenQueue = new java.util.LinkedList<>();
    private Token pastToken = null;
    private int tabsInc = 0;
    @Override
    public Token nextToken() {
        if(!tokenQueue.isEmpty()) {
            pastToken = tokenQueue.poll();
            return pastToken;
        }

        Token currToken = super.nextToken();
        tokenQueue.add(currToken);

        if(currToken.getType() != grammarForPythonParser.ENLINE || pastToken == null) {
            pastToken = currToken;
            return tokenQueue.poll();
        }

        if(pastToken.getType() == ENDCOLONS) {
            tabsInc++;
            tokenQueue.add(new CommonToken(grammarForPythonParser.INDENT));
        }

        String nextTab = "";
        for(int i=0; i<tabsInc; i++)
            nextTab += "    ";

        Token newToken = super.nextToken();

        if(newToken.getType() != TAB) {
            for(int i=0; i<tabsInc; i++) {
                tokenQueue.add(new CommonToken(grammarForPythonParser.DEDENT));
            }
            tabsInc = 0;
            tokenQueue.add(newToken);
            return tokenQueue.poll();
        }

        String spaceToTab = newToken.getText().replace("\t", "    ");
        if(spaceToTab.length() != nextTab.length()) {
            int length = (nextTab.length() - spaceToTab.length()) / 4;
            for(int i=0; i<length; i++) {
                tabsInc--;
                tokenQueue.add(new CommonToken(grammarForPythonParser.DEDENT));
            }
        }

        return tokenQueue.poll();
    }

}



start: (statement | ENLINE)*;

// If/else block in python - if(...):
// While- while(...):
//For Loops - for x in something:
//variables defintions
statement: controlExpr=expr               #controlExp
         | 'print(' controlExpr=expr ')'   #controlPrintExp
         | 'if' if_controlExpr=expr ENDCOLONS ENLINE if_body=stmntField ('elif' elif_controlExpr=expr ENDCOLONS ENLINE elif_body=stmntField)* ('else' ENDCOLONS ENLINE else_body=stmntField)? #controlIfStatment
         | 'while' controlExpr=expr ':' ENLINE body=stmntField #controlWhileStatment
         | 'for' vars=VARS ' in range(' begin=expr ',' last=expr ')' ENDCOLONS ENLINE body=stmntField  #controlForStatment
         | vars=VARS asgnmnt=ASGNMNT controlExpr=expr #contolAssignmentStatment
         | vars=VARS '=' controlExpr=expr  #controlEqualStatment
         | CRTCOMMENTS #controlCommentStatment
         ;

stmntField: INDENT (stat=statement ENLINE*)+ DEDENT;


expr: atom=STRING                                  #theStringExp
    | atom= VARS                             #theAtomVariabeExp
    | atom= INTEGER                            #theAtomIntegerExp
    | var=FLOAT                              #theAtomFloatExp
    | 'break'                                   #theBreakExp
    | '(' controlExpr=expr ')'                          #theExprForPar
    | left=expr cndl=CONDIT right=expr           #theCondExp
    | l=expr arth=ARTHMT r=expr                   #theMathExp
    | left=expr 'and' right=expr                #theAndExpr
    | 'str(' controlExpr=expr ')'                       #theStrExp
    | 'int('controlExpr=expr')'                         #theIntExp
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
