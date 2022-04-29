/* Ocamlyacc parser for HANDL */

%{
open Ast
%}

%token SEMI LPAREN RPAREN LBRACE RBRACE ASSIGN LBRACK RBRACK
%token PLUS MINUS TIMES DIVISION MODULO POWER
%token EQ NEQ LT GT AND OR NOT LEQ GEQ
%token IF ELSE WHILE INT BOOL FLOAT CHAR STRING NOTE
%token FOR MEASURE THROUGH IN
%token RETURN COMMA ARRAY PHRASE SONG
%token ADDNOTE MEASURE
%token TIMESIGNATURE TEMPO BARS 
%token <int> LITERAL
%token <bool> BLIT
%token <float> FLIT
%token <char> CHRLIT
%token <string> ID STRLIT
%token EOF

%start program
%type <Ast.program> program

%right ASSIGN
%left NOT
%left OR
%left AND
%left EQ NEQ LEQ GEQ
%left LT
%left GT
%left POWER
%left TIMES DIVISION MODULO
%left PLUS MINUS

%%
program:
  decls EOF { $1}

decls:
   /* nothing */ { ([], [])               }
 | vdecl SEMI decls { (($1 :: fst $3), snd $3) }
 | fdecl decls { (fst $2, ($1 :: snd $2)) }

vdecl_list:
  /*nothing*/ { [] }
  | vdecl SEMI vdecl_list  {  $1 :: $3 }

/* int x */
vdecl:
  typ_rule ID { ($1, $2) }

typ_rule:
  primitive_typ             { PrimitiveType($1) }
  | ARRAY LT typ_rule GT LBRACK LITERAL RBRACK      { PrimArray($3,$6) }
  | handl_typ_rule          { $1                }
primitive_typ:
  INT                       { Int  }
  | BOOL                    { Bool }
  | FLOAT                   { Float }
  | CHAR                    { Char }
  | STRING                  { String }

handl_typ_rule:
  PHRASE                    { PhraseType }
  | SONG                      { SongType }

/* fdecl */
fdecl:
  vdecl LPAREN formals_opt RPAREN LBRACE vdecl_list stmt_list RBRACE
  {
    {
      rtyp=fst $1;
      fname=snd $1;
      formals=$3;
      locals=$6;
      body=$7
    }
  }

/* formals_opt */
formals_opt:
  /*nothing*/ { [] }
  | formals_list { $1 }

formals_list:
  vdecl { [$1] }
  | vdecl COMMA formals_list { $1::$3 }

stmt_list:
  /* nothing */ { [] }
  | stmt_rule stmt_list  { $1::$2 }

stmt_rule:
  expr_rule SEMI                                                        { Expr $1          }
  | LBRACE stmt_list RBRACE                                        { Block $2         }
  | IF LPAREN expr_rule RPAREN stmt_rule ELSE stmt_rule        { IfElse ($3, $5, $7)  }
  | IF LPAREN expr_rule RPAREN stmt_rule                       { If ($3, $5)}
  | WHILE LPAREN expr_rule RPAREN stmt_rule                             { While ($3,$5)    }
  | FOR LPAREN MEASURE LITERAL THROUGH LITERAL IN expr_rule RPAREN stmt_rule     { ForMeasure($4, $6, $8, $10) }
  | FOR LPAREN expr_rule SEMI expr_rule SEMI expr_rule RPAREN stmt_rule  { For($3, $5, $7, $9) }
  | RETURN expr_rule SEMI                        { Return $2      }

expr_rule:
  | BLIT                                        { BoolLit $1            }
  | LITERAL                                     { Literal $1            }
  | FLIT                                        { FloatLit $1           }
  | CHRLIT                                      { ChrLit $1             }
  | STRLIT                                      { StrLit $1             }
  | LBRACK array_opt RBRACK                         { ArrLit $2             }
  | ID                                          { Id $1                 }
  | expr_rule POWER expr_rule                   { Binop ($1, Pow, $3)   }
  | expr_rule PLUS expr_rule                    { Binop ($1, Add, $3)   }
  | expr_rule MINUS expr_rule                   { Binop ($1, Sub, $3)   }
  | expr_rule TIMES expr_rule                   { Binop ($1, Mult, $3)  }
  | expr_rule DIVISION expr_rule                { Binop ($1, Div, $3)   }
  | expr_rule MODULO expr_rule                  { Binop ($1, Mod, $3)   }
  | expr_rule EQ expr_rule                      { Binop ($1, Equal, $3) }
  | expr_rule NEQ expr_rule                     { Binop ($1, Neq, $3)   }
  | expr_rule LT expr_rule                      { Binop ($1, Less, $3)  }
  | expr_rule GT expr_rule        { Binop ($1, Greater, $3)  }
  | expr_rule LEQ expr_rule        { Binop ($1, LessEqual, $3)  }
  | expr_rule GEQ expr_rule        { Binop ($1, GreaterEqual, $3)  }
  | expr_rule AND expr_rule                     { Binop ($1, And, $3)   }
  | expr_rule OR expr_rule                      { Binop ($1, Or, $3)    }
  | NOT expr_rule                               { Not ($2)              }
  | ID ASSIGN expr_rule                         { Assign ($1, $3)       }
  | LPAREN expr_rule RPAREN                     { $2                    }
  | ID LBRACK expr_rule RBRACK ASSIGN expr_rule { ArrAssign($1, $3, $6) }
  | ID LBRACK expr_rule RBRACK                  { ArrAccess($1, $3)     }
  | NOTE ID ASSIGN NOTE LPAREN expr_rule COMMA expr_rule RPAREN           { NoteAssign($2, $6, $8) }
  | ID ASSIGN PHRASE LPAREN RPAREN       { PhraseAssign $1       }
  | ID ADDNOTE LPAREN expr_rule RPAREN            { PhraseAdd($1, $4)     }
  | ID MEASURE LPAREN expr_rule RPAREN            { SongMeasure($1, $4)     }
  | ID TEMPO ASSIGN expr_rule                          {SongTempo($1, $4)}
  | ID BARS ASSIGN expr_rule                          {SongBars($1, $4)}
  | ID TIMESIGNATURE ASSIGN expr_rule                          {SongTimeSignature($1, $4)}
  | ID ASSIGN SONG LPAREN RPAREN       { SongAssign $1       }
  | ID LPAREN array_opt RPAREN { Call ($1, $3)  }

array_opt:
  /*nothing*/ { [] }
  | array { $1 }

array:
  expr_rule  { [$1] }
  | expr_rule COMMA array { $1::$3 }
