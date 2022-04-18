(* Ocamllex scanner for HANDL *)

{ open Handlparse }

let digit = ['0'-'9']
let letter = ['a'-'z' 'A'-'Z']

rule token = parse
  [' ' '\t' '\r' '\n'] { token lexbuf } (* Whitespace *)
| "/*"     { comment lexbuf }           (* Comments *)
| '('      { LPAREN }
| ')'      { RPAREN }
| '{'      { LBRACE }
| '}'      { RBRACE }
| '['      { LBRACK }
| ']'      { RBRACK }
| ';'      { SEMI }
| ','      { COMMA }
| '+'      { PLUS }
| '-'      { MINUS }
| '*'      { TIMES }
| '/'      { DIVISION }
| '%'      { MODULO }
| '^'      { POWER }
| '='      { ASSIGN }
| "=="     { EQ }
| "!="     { NEQ }
| '<'      { LT }
| ">="     { GEQ }
| "<="     { LEQ }
| '>'      { GT }
| "and"    { AND }
| "or"     { OR }
| "not"    { NOT }
| "if"     { IF }
| "else"   { ELSE }
| "while"  { WHILE }
| "return" { RETURN }
| "int"    { INT }
| "float"  { FLOAT }
| "bool"   { BOOL }
| "true"   { BLIT(true)  }
| "false"  { BLIT(false) }
| "Array"  { ARRAY }
| "char"   { CHAR }
| "String" { STRING }
| "for" { FOR }
| "Note" { NOTE }
| "Phrase" { PHRASE }
| ".add" { ADDNOTE }
| ".tempo" { TEMPO }
| ".timeSignature" { TIMESIGNATURE }
| "Song" { PHRASE }
| "measure" { MEASURE }
| "through" { THROUGH }
| "in" { IN }
| '"'((digit | letter)* as str)'"'  { STRLIT(str) }
| '''((digit | letter) as chr)'''   { CHRLIT(chr) }
| digit+ as lem  { LITERAL(int_of_string lem) }
| digit+ '.' digit+ ( ['e' 'E'] ['+' '-']? digit+ )? as lem {FLIT(float_of_string lem) }
| letter (digit | letter | '_')* as lem { ID(lem) }
| eof { EOF }
| _ as char { raise (Failure("illegal character " ^ Char.escaped char)) }

and comment = parse
  "*/" { token lexbuf }
| _    { comment lexbuf }
