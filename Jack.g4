grammar Jack;

/**
 * Lexical rules
 */
KEYWORD		: 	'class' | 'constructor' | 'function' | 'method' | 'field' 
            |   'static' | 'var' | 'int' | 'char' | 'boolean' | 'void'
            |   'true'  | 'false' | 'null' | 'this' | 'let' | 'do' |'if' 
            |   'else' | 'while' | 'return' ;
            
SYMBOL 		:  '{' | '}' | '(' | ')' | '[' | ']' | '.' |',' |';' |'+' |'-'
			| '*' |'/' |'&'|'|'| '<' |'>' |'=' |'~' ;
			
INTEGERCONSTANT 	: '0' |('1'..'9')('0'..'9')* ;

ABC		: 'a'..'z' | 'A'..'Z';

STRINGCONSTANT		: '"' * '"';

IDENTIFIER	: (ABC | '_')(ABC | '_' | ('0'..'9'))* ;


/**
 *  grammars
 */
 
 /**
  * program structures
  */
  myclass			:    'class' className '{' classVarDec* subroutineDec* '}' ;
  
  classVarDec		: 	('static' | 'feild') type varName (',' varName)* ';' ;
  
  type 				:	'int' | 'char' | 'boolean' | className ;
  
  subroutineDec		:   ('constructor' | 'function' |'method') ('void' | type) subroutineName '(' parameterList ')' subroutineBody ;
  
  parameterList		:  ((type varName) (',' type varName)*)? ;
  
  subroutineBody	:  '{' varDec* statements '}';
  
  varDec			:  'var' type varName (',' varName)* ';' ;
  
  className			: IDENTIFIER;
  
  subroutineName	: IDENTIFIER;
  
  varName			: IDENTIFIER;
  
   
 /**
  *  statements
  */ 
  
  statements 		: statement* ;
  
  statement 		: letStatement | ifStatement | whileStatement | doStatement | returnStatement ;
  
  letStatement		: 'let' varName ('[' expression ']')? '=' expression ';' ;
  
  ifStatement		: 'if' '(' expression ')' '{' statements '}' ('else' '{' statements '}')? ;
  
  whileStatement    : 'while' '(' expression ')' '{' statements '}' ;
  
  doStatement		: 'do' subroutineCall ';' ;
  
  returnStatement	: 'return' expression? ';' ;
  
  
  /**
   * expression
   */
   
   expression		: term (op term)* ;
   
   term				: INTEGERCONSTANT | STRINGCONSTANT | keywordConstant | varName 
   					| varName '[' expression ']' | subroutineCall | '(' expression ')' | unaryOp term ;
   					
   subroutineCall   : subroutineName '(' expressionList ')' | (className | varName)'.'subroutineName '{' expressionList '}';
   
   expressionList 	: (expression (',' expression)*)? ;
   
   op				: '+' | '-' | '*' | '/'| '&' | '|' | '<' | '>' | '=' ;
   
   unaryOp			: '-' | '~' ;
   
   keywordConstant  : 'true' | 'false' | 'null' | 'this' ;