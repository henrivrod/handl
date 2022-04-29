type bop = Pow | Add | Sub | Div | Mult | Mod | Equal | Neq | Less | And | Or | Greater | LessEqual | GreaterEqual

type prim = Int | Bool | Float | Char| String | Note

type typ = PrimitiveType of prim | PrimArray of typ * int | PhraseType | SongType

type expr =
  | Literal of int
  | BoolLit of bool
  | FloatLit of float
  | ChrLit of char
  | StrLit of string
  | ArrLit of expr list
  | Id of string
  | Not of expr
  | Binop of expr * bop * expr
  | Assign of string * expr
  | ArrAssign of string * expr * expr
  | ArrAccess of string * expr
  | NoteAssign of string * expr * expr
  | PhraseAssign of string
  | PhraseAdd of string * expr
  | SongMeasure of string * expr
  | SongAssign of string
  | Call of string * expr list
  | SongTempo of string * expr
  | SongBars of string * expr
  | SongTimeSignature of string * expr
 

type stmt =
  | Block of stmt list
  | Expr of expr
  | IfElse of expr * stmt * stmt
  | If of expr * stmt
  | While of expr * stmt
  | ForMeasure of int * int * expr * stmt
  | For of expr * expr * expr * stmt
  | Return of expr

type bind = typ * string

type func_def = {
  rtyp: typ;
  fname: string;
  formals: bind list;
  locals: bind list;
  body: stmt list;
}

type program = bind list * func_def list

(* Pretty-printing functions *)
let string_of_op = function
    Add -> "+"
  | Sub -> "-"
  | Pow -> "^"
  | Mult -> "*"
  | Div -> "/"
  | Mod -> "%"
  | Equal -> "=="
  | Neq -> "!="
  | LessEqual -> "<="
  | GreaterEqual -> ">="
  | Less -> "<"
  | Greater -> ">"
  | And -> "and"
  | Or -> "or"

let string_of_prim = function
    Int -> "int"
    | Bool -> "bool"
    | Float -> "float"
    | String -> "string"
    | Char -> "char"
    | Note -> "Note"

let rec string_of_typ = function
  PrimitiveType(t) -> string_of_prim t
  | PrimArray(t, s) -> match t with
        PrimitiveType(x) -> "Array <" ^ string_of_prim x ^ ">" ^  "["^ string_of_int s ^"]"
        | _ -> failwith "Array on non-primitive type"
  | _ -> failwith "Error"

let rec string_of_expr = function
    Literal(l) -> string_of_int l
  | FloatLit(f) -> string_of_float f
  | BoolLit(true) -> "true"
  | BoolLit(false) -> "false"
  | ChrLit(l) -> "'" ^ Char.escaped l ^ "'"
  | StrLit(l) -> "\"" ^ l ^ "\""
  | ArrLit(a) -> "[" ^ string_of_arr a ^ "]"
  | Id(s) -> s
  | Not(e) -> "not " ^ string_of_expr e
  | Binop(e1, o, e2) ->
    string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | Assign(v, e) -> v ^ " = " ^ string_of_expr e
  | ArrAssign(s, e1, e2) -> s ^ "[" ^ string_of_expr e1 ^ "]" ^
                            " = " ^ string_of_expr e2
  | ArrAccess(s,e) -> s ^ "[" ^ string_of_expr e ^ "]"
  | NoteAssign(id, pitch, duration) -> "Note " ^ id ^ " = " ^ "Note( " ^ string_of_expr pitch ^ ", " ^ string_of_expr duration ^ ")"
  | PhraseAssign(id) -> "Phrase " ^ id ^ " = Phrase()"
  | PhraseAdd(id, note) -> id ^ ".add(" ^ string_of_expr note ^ ")"
  | SongMeasure(id, value) -> id ^ ".measure(" ^ string_of_expr value ^ ")"
  | SongAssign(id) -> "Song " ^ id ^ " = Song()"
  | Call(f, el) ->
        f ^ "(" ^ String.concat ", " (List.map string_of_expr el) ^ ")"
  | SongTempo(id, value) -> id ^ ".tempo" ^ " = " ^ string_of_expr value
  | SongBars(id, value) -> id ^ ".bars" ^ " = " ^ string_of_expr value
  | SongTimeSignature(id, value) -> id ^ ".timeSignature" ^ " = " ^ string_of_expr value

and string_of_arr l =
   if List.length l = 0 then "" else
   if List.length l > 1 then string_of_expr (List.hd l) ^ "," ^ string_of_arr (List.tl l) else string_of_expr (List.hd l)

let rec string_of_stmt = function
    Block(stmts) ->
    "{\n" ^ String.concat "" (List.map string_of_stmt stmts) ^ "}\n"
  | Expr(expr) -> string_of_expr expr ^ ";\n";
  | IfElse(e, s1, s2) ->  string_of_if_else(e,s1,s2)
  | If(e, s) -> string_of_if(e,s)
  | While(e, s) -> "while (" ^ string_of_expr e ^ ") " ^ string_of_stmt s
  | ForMeasure(i1, i2, e, s) -> "for (measure " ^ string_of_int i1 ^ " through " ^ string_of_int i2 ^ " in " ^ string_of_expr e ^ ") " ^ string_of_stmt s
  | For(e1, e2, e3, s) -> "for (" ^ string_of_expr e1 ^ "; " ^ string_of_expr e2 ^ "; " ^ string_of_expr e3 ^ "; " ^ string_of_stmt s
  | Return(expr) -> "return " ^ string_of_expr expr ^ ";\n"
and string_of_if_else (e, s1, s2)=
    let part1 =
        match s1 with
            Expr(expr)-> string_of_stmt s1
            | Block(stmts)->string_of_stmt(s1)
            | _ -> failwith "Error"
    in
    let part2 =
        match s2 with
            Expr(expr)-> "\n" ^ string_of_stmt s2
            | Block(stmts)->"\n" ^ string_of_stmt(s2)
            | IfElse(e1,s3,s4)->string_of_stmt(s2)
            | If(e1,s3) ->string_of_stmt(s2)
            | _ -> failwith "Error"
    in
    "if (" ^ string_of_expr e ^ ")\n" ^
        part1 ^  "else" ^ part2
and string_of_if (e, s)=
    let part1 =
        match s with
            Expr(expr)-> string_of_stmt s
            | Block(stmts)->string_of_stmt(s)
            | _ -> failwith "Error"
    in
    "if (" ^ string_of_expr e ^ ")\n" ^ part1

let string_of_vdecl (t, id) = string_of_typ t ^ " " ^ id ^ ";\n"

let string_of_fdecl fdecl =
  string_of_typ fdecl.rtyp ^ " " ^
  fdecl.fname ^ "(" ^ String.concat ", " (List.map snd fdecl.formals) ^
  ")\n{\n" ^
  String.concat "" (List.map string_of_vdecl fdecl.locals) ^
  String.concat "" (List.map string_of_stmt fdecl.body) ^
  "}\n"

let string_of_program (vars, funcs) =
  "\n\nParsed program: \n\n" ^
  String.concat "" (List.map string_of_vdecl vars) ^ "\n" ^
  String.concat "\n" (List.map string_of_fdecl funcs)