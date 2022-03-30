(* Semantically-checked Abstract Syntax Tree and functions for printing it *)

open Ast

type sexpr = typ * sx
and sx =
    SLiteral of int
  | SBoolLit of bool
  | SFloatLit of float
  | SChrLit of char
  | SStrLit of string
  | SArrLit of expr list
  | SId of string
  | SNot of sexpr
  | SBinop of sexpr * bop * sexpr
  | SAssign of string * sexpr
  | SArrAssign of string * sexpr * sexpr
  | SArrAccess of string * sexpr
  | SNoteAssign of string * string * float
  | SPhraseAssign of string
  | SSongAssign of string
  | SCall of string * sexpr list
 

type sstmt =
    SBlock of stmt list
  | SExpr of expr
  | SIf of sexpr * sstmt * els
  | SWhile of sexpr * sstmt
  | SForMeasure of int * int * sexpr * sstmt
  | SFor of sexpr * sexpr * sexpr * sstmt
  | SReturn of sexpr
and els = NoElse | SElse of stmt | SElseIf of sexpr * sstmt * els

(* func_def: ret_typ fname formals locals body *)
type sfunc_def = {
  srtyp: typ;
  sfname: string;
  sformals: bind list;
  slocals: bind list;
  sbody: sstmt list;
}

type sprogram = bind list * sfunc_def list

(* Pretty-printing functions *)
let rec string_of_sexpr (t, e) =
  "(" ^ string_of_typ t ^ " : " ^ (match e with
    SLiteral(l) -> string_of_int l
  | SFloatLit(f) -> string_of_float f
  | SBoolLit(true) -> "true"
  | SBoolLit(false) -> "false"
  | SChrLit(l) -> "'" ^ Char.escaped l ^ "'"
  | SStrLit(l) -> "\"" ^ l ^ "\""
  | SArrLit(a) -> "[" ^ string_of_arr a ^ "]"
  | SId(s) -> s
  | SNot(e) -> "not " ^ string_of_expr e
  | SBinop(e1, o, e2) ->
    string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | SAssign(v, e) -> v ^ " = " ^ string_of_expr e
  | SArrAssign(s, e1, e2) -> s ^ "[" ^ string_of_expr e1 ^ "]" ^
                            " = " ^ string_of_expr e2
  | SArrAccess(s,e) -> s ^ "[" ^ string_of_expr e ^ "]"
  | SNoteAssign(id, pitch, duration) -> "Note " ^ id ^ " = " ^ "Note( " ^ pitch ^ ", " ^ string_of_float duration ^ ")"
  | SPhraseAssign(id) -> "Phrase " ^ id ^ " = Phrase()"
  | SSongAssign(id) -> "Song " ^ id ^ " = Song()"
  | SCall(f, el) ->
            f ^ "(" ^ String.concat ", " (List.map string_of_sexpr el) ^ ")"
      ) ^ ")"
  and string_of_arr l =
     if List.length l = 0 then "" else
     if List.length l > 1 then string_of_expr (List.hd l) ^ "," ^ string_of_arr (List.tl l) else string_of_expr (List.hd l)

let rec string_of_sstmt = function
    SBlock(stmts) -> "{\n" ^ String.concat "" (List.map string_of_stmt stmts) ^ "}\n"
  | SExpr(expr) -> string_of_expr expr ^ ";\n";
  | SReturn(expr) -> "return " ^ string_of_sexpr expr ^ ";\n"
  | SIf(e, s, el) ->  "if (" ^ string_of_expr e ^ ") {\n" ^
                        string_of_stmt s ^ "}" ^ string_of_else el
  | SWhile(e, s) -> "while (" ^ string_of_expr e ^ ") " ^ string_of_stmt s
  | SForMeasure(i1, i2, e, s) -> "for (measure " ^ string_of_int i1 ^ " through " ^ string_of_int i2 ^ " in " ^ string_of_expr e ^ ") " ^ string_of_stmt s
  | SFor(e1, e2, e3, s) -> "for (" ^ string_of_expr e1 ^ "; " ^ string_of_expr e2 ^ "; " ^ string_of_expr e3 ^ "; " ^ string_of_stmt s
and string_of_else = function
    NoElse -> ""
    | SElse(s) -> "\nelse {\n" ^ string_of_stmt s ^ "}"
    | SElseIf(e,s,el) -> "\nelse if (" ^ string_of_expr e ^ ") { \n" ^
                       string_of_stmt s ^ "}" ^ string_of_else el

let string_of_sfdecl fdecl =
  string_of_typ fdecl.srtyp ^ " " ^
  fdecl.sfname ^ "(" ^ String.concat ", " (List.map snd fdecl.sformals) ^
  ")\n{\n" ^
  String.concat "" (List.map string_of_vdecl fdecl.slocals) ^
  String.concat "" (List.map string_of_sstmt fdecl.sbody) ^
  "}\n"

let string_of_sprogram (vars, funcs) =
  "\n\nSementically checked program: \n\n" ^
  String.concat "" (List.map string_of_vdecl vars) ^ "\n" ^
  String.concat "\n" (List.map string_of_sfdecl funcs)
