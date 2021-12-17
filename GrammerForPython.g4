grammar grammarForPython;

tokens {INDENT, DEDENT}


@lexer::members {
    private final java.util.Queue<Token> tokenQueue = new java.util.LinkedList<>();
    //Set pastToken to null
    private Token pastToken = null;
    //Incrementer for tabs
    private int tabsInc = 0;
    @Override
    public Token nextToken() {
        if(!tokenQueue.isEmpty()) {
            //Grab a past token
            pastToken = tokenQueue.poll();
            //Return past token
            return pastToken;
        }
        
        //Get current token
        Token currToken = super.nextToken();
        //Add current token to token queue
        tokenQueue.add(currToken);

        
        if(currToken.getType() != grammarForPythonParser.ENLINE || pastToken == null) {
            //Past token is now current token
            pastToken = currToken;
            //Return token queue again
            return tokenQueue.poll();
        }

        if(pastToken.getType() == ENDCOLONS) {
            //Increment token incrementer
            tabsInc++;
            //Add to token queue
            tokenQueue.add(new CommonToken(grammarForPythonParser.INDENT));
        }

        //String for next tab temp
        String nextTab = "";
        for(int i=0; i<tabsInc; i++)
            //Every time there's a tab, add a tab space
            nextTab += "    ";

        //Grab newer token
        Token newToken = super.nextToken();

        if(newToken.getType() != TAB) {
            for(int i=0; i<tabsInc; i++) {
                tokenQueue.add(new CommonToken(grammarForPythonParser.DEDENT));
            }
            //Reset tab incrementer
            tabsInc = 0;
            //Add the new token into the token queue
            tokenQueue.add(newToken);
            //return token queue
            return tokenQueue.poll();
        }

        //Grab spaces to tab from the new token text
        String spaceToTab = newToken.getText().replace("\t", "    ");
        if(spaceToTab.length() != nextTab.length()) {
            //length is equal to the next tab's length subtracted by the space to tab divided by 4 as a whole to convert
            int length = (nextTab.length() - spaceToTab.length()) / 4;
            for(int i=0; i<length; i++) {
                //Decrement tab incrementer
                tabsInc--;
                //Add to token queue
                tokenQueue.add(new CommonToken(grammarForPythonParser.DEDENT));
            }
        }
        
        //Add token queue
        return tokenQueue.poll();
    }

}


//Start definitions
start: (statement | ENLINE)*;

// If/else block in python - if(...):
// While- while(...):
//For Loops - for x in something:
//variables defintions
//Statment defintions
//  Print definitions
//  if, else if, else, definitions
//  while definitions
//  variable defeintions assignments
//  comments in python
statement: controlExpr=expr               #controlExp
         | 'print(' controlExpr=expr ')'   #controlPrintExp
         | 'if' if_controlExpr=expr ENDCOLONS ENLINE if_body=stmntField ('elif' elif_controlExpr=expr ENDCOLONS ENLINE elif_body=stmntField)* ('else' ENDCOLONS ENLINE else_body=stmntField)? #controlIfStatment
         | 'while' controlExpr=expr ':' ENLINE body=stmntField #controlWhileStatment
         | 'for' vars=VARS ' in range(' begin=expr ',' last=expr ')' ENDCOLONS ENLINE body=stmntField  #controlForStatment
         | vars=VARS asgnmnt=ASGNMNT controlExpr=expr #contolAssignmentStatment
         | vars=VARS '=' controlExpr=expr  #controlEqualStatment
         | CRTCOMMENTS #controlCommentStatment
         ;

//statementfield definitions
stmntField: INDENT (stat=statement ENLINE*)+ DEDENT;

//Expressions Definitions
//  Structure is variable = association #FunctionName 
//      (To be renamed and in the generated tiles)
//  Atoms = String / Variable / Integer
//  Var = Float
//  Break Statement
//  Control Expression Surrounded by Paratheses
//  Left Expression, Control Condition, Right Expression
//  Left Expression, Arithmetic Expression, Right Expression
//  Left Expression, AND, Right Expression
//  String encapsulating Control Expression
//  Integer encapsulating Control Expression
expr: atom=STRING                                  #StringExpressionDef
    | atom= VARS                             #VariableExpressionDef
    | atom= INTEGER                            #IntegerExpressionDef
    | var=FLOAT                              #FloatExpressionDef
    | 'break'                                   #BreakDefinition
    | '(' controlExpr=expr ')'                          #ControlExpressionDef
    | left=expr cndl=CONDIT right=expr           #ConditionalExprerssionDef
    | l=expr arth=ARTHMT r=expr                   #ArithmeticExpressionDef
    | left=expr 'and' right=expr                #AndExpressionDef
    | 'str(' controlExpr=expr ')'                       #StringControlExpressionDef
    | 'int('controlExpr=expr')'                         #IntegerControlExpressionDef
    ;





//Variables Definitions
//  undercase to UPPERCASE, 0-9
VARS: [a-zA-Z_][a-zA-Z0-9_]*;

// Integers (Be sure to check for Unary vs Negative)
//  Could be negative, 0-9
INTEGER: '-' ? [0-9]+;

// Floats (Be sure to check for Unary vs Negative)
//  Could be negative, 0-9 DECIMAL(.) 0-9
FLOAT: '-' ? ([0-9]*[.]) ? [0-9]+;

// Strings
//  String from documentations
STRING: '"' ('\\' ["\\] | ~["\\\r\n])* '"';

// Tab Spacings
//  \t tab as well as literal tab space
TAB: ('\t'|'    ');


// While and For Loops
//DONT NEED THESE

//Arithmetic Operators
//  Addition, Minus
//  Divid, Times
//  Power, Modulus
ARTHMT: '+'|'-'|'/'|'*'|'^'|'%';


// Assignment Operators
//  Add To and Equals, Subtract and Equals
//  Times and Equals, Divid and Equals
//  Power to and Equals
//  Modulus to and Equals
ASGNMNT: '+='|'-='|'*='|'/='|'^='|'%=';


// Conditional Statements
//  Less Than, Less Than or Equal
//  Greater Than, Greater Than or Equal
//  Equals, Doesnt Equals
//  AND, OR, NOT
CONDIT: '<'|'<='|'>'|'>='|'=='|'!='|'and'|'or'|'not';


// Whitespaces
//  Whiespaces according to documentations (go to next)
WS: [ \r\n\t] + -> skip;

// Comments
//  Comments according to documentations
//COMMENTS: '#' ~( '\r' | '\n' )*;

//...

//Rules

//  Colons
//  Used to define
ENDCOLONS: ':';

// End of Lines
//  USE ONE OF THE BELOW
//ENLINE: '\r' ? '\n' | '\r'; 
ENLINE: '\n' | '\r\n' | '\r';
//Python Comments
CRTCOMMENTS: '#'(~[\r\n])*; //# comment in python
