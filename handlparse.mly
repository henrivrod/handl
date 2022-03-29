/* Ocamlyacc parser for HANDL */

%{
open Ast
%}

%token SEMI LPAREN RPAREN LBRACE RBRACE ASSIGN LBRACK RBRACK
%token PLUS MINUS TIMES DIVISION MODULO POWER
%token EQ NEQ LT GT AND OR NOT LEQ GEQ
%token IF ELSE WHILE INT BOOL FLOAT CHAR STRING NOTE
%token FOR MEASURE THROUGH IN
%token RETURN COMMA ARRAY
%token <int> LITERAL
%token <bool> BLIT
%token <float> FLIT
%token <char> CHRLIT
%token <string> ID STRLIT
%token EOF

%start program_rule
%type <Ast.program> program_rule

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

program_rule:
  vdecl_list_rule stmt_list_rule EOF { {locals=$1; body=$2} }

vdecl_list_rule:
  /*nothing*/                   { []       }
  | vdecl_rule vdecl_list_rule  { $1 :: $2 }

vdecl_rule:
  typ_rule ID SEMI { ($1, $2) }

typ_rule:
  primitive_typ             { PrimitiveType($1) }
  | array_typ_rule          { $1                }

primitive_typ:
  INT                       { Int  }
  | BOOL                    { Bool }
  | FLOAT                   { Float }
  | CHAR                    { Char }
  | STRING                  { String }

array_typ_rule:
  ARRAY LT typ_rule GT      { ArrayType($3) }

stmt_list_rule:
    /* nothing */               { []     }
    | stmt_rule stmt_list_rule  { $1::$2 }

stmt_rule:
  expr_rule SEMI                                                        { Expr $1          }
  | LBRACE stmt_list_rule RBRACE                                        { Block $2         }
  | IF LPAREN expr_rule RPAREN LBRACE stmt_rule RBRACE else_stmt        { If ($3, $6, $8)  }
  | WHILE LPAREN expr_rule RPAREN stmt_rule                             { While ($3,$5)    }
  | FOR LPAREN MEASURE LITERAL THROUGH LITERAL IN expr_rule RPAREN stmt_rule     { ForMeasure($4, $6, $8, $10) }
  | FOR LPAREN expr_rule SEMI expr_rule SEMI expr_rule RPAREN stmt_rule  { For($3, $5, $7, $9) }

else_stmt:
                                                                        { NoElse           }
  | ELSE LBRACE stmt_rule RBRACE else_stmt                              { Else $3          }
  | ELSE IF LPAREN expr_rule RPAREN LBRACE stmt_rule RBRACE else_stmt   { ElseIf($4,$7,$9) }

expr_rule:
  | BLIT                                        { BoolLit $1            }
  | LITERAL                                     { Literal $1            }
  | FLIT                                        { FloatLit $1           }
  | CHRLIT                                      { ChrLit $1             }
  | STRLIT                                      { StrLit $1             }
  | ID                                          { Id $1                 }
  | expr_rule POWER expr_rule                    { Binop ($1, Pow, $3)   }
  | expr_rule PLUS expr_rule                    { Binop ($1, Add, $3)   }
  | expr_rule MINUS expr_rule                   { Binop ($1, Sub, $3)   }
  | expr_rule TIMES expr_rule                   { Binop ($1, Mult, $3)   }
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
  | NOTE ID ASSIGN NOTE LPAREN STRLIT COMMA FLIT RPAREN           { NoteAssign($2, $6, $8) }

