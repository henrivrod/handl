type bop = Pow | Add | Sub | Div | Mult | Mod | Equal | Neq | Less | And | Or | Greater | LessEqual | GreaterEqual

type prim = Int | Bool | Float | Char| String 

type typ = PrimitiveType of prim | ArrayType of typ

type expr =
  | Literal of int
  | BoolLit of bool
  | FloatLit of float
  | ChrLit of char
  | StrLit of string
  | Id of string
  | Not of expr
  | Binop of expr * bop * expr
  | Assign of string * expr
  | ArrAssign of string * expr * expr
  | ArrAccess of string * expr

type stmt =
  | Block of stmt list
  | Expr of expr
  | If of expr * stmt * els
  | While of expr * stmt
  | ForMeasure of int * int * expr * stmt
  | For of expr * expr * expr * stmt
and els = NoElse | Else of stmt | ElseIf of expr * stmt * els

type bind = typ * string

type program = {
  locals: bind list;
  body: stmt list;
}


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

let rec string_of_typ = function
  PrimitiveType(t) -> string_of_prim t
  | ArrayType(t) -> "Array <" ^ string_of_typ t ^ ">"

let rec string_of_expr = function
    Literal(l) -> string_of_int l
  | FloatLit(f) -> string_of_float f
  | BoolLit(true) -> "true"
  | BoolLit(false) -> "false"
  | ChrLit(l) -> "'" ^ Char.escaped l ^ "'"
  | StrLit(l) -> l
  | Id(s) -> s
  | Not(e) -> "not " ^ string_of_expr e
  | Binop(e1, o, e2) ->
    string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | Assign(v, e) -> v ^ " = " ^ string_of_expr e
  | ArrAssign(s, e1, e2) -> s ^ "[" ^ string_of_expr e1 ^ "]" ^
                            " = " ^ string_of_expr e2
  | ArrAccess(s,e) -> s ^ "[" ^ string_of_expr e ^ "]"

let rec string_of_stmt = function
    Block(stmts) ->
    "{\n" ^ String.concat "" (List.map string_of_stmt stmts) ^ "}\n"
  | Expr(expr) -> string_of_expr expr ^ ";\n";
  | If(e, s, el) ->  "if (" ^ string_of_expr e ^ ") {\n" ^
                        string_of_stmt s ^ "}" ^ string_of_else el
  | While(e, s) -> "while (" ^ string_of_expr e ^ ") " ^ string_of_stmt s
  | ForMeasure(i1, i2, e, s) -> "for (measure " ^ string_of_int i1 ^ " through " ^ string_of_int i2 ^ " in " ^ string_of_expr e ^ ") " ^ string_of_stmt s
  | For(e1, e2, e3, s) -> "for (" ^ string_of_expr e1 ^ "; " ^ string_of_expr e2 ^ "; " ^ string_of_expr e3 ^ "; " ^ string_of_stmt s
and string_of_else = function
    NoElse -> ""
    | Else(s) -> "\nelse {\n" ^ string_of_stmt s ^ "}"
    | ElseIf(e,s,el) -> "\nelse if (" ^ string_of_expr e ^ ") { \n" ^
                       string_of_stmt s ^ "}" ^ string_of_else el

let string_of_vdecl (t, id) = string_of_typ t ^ " " ^ id ^ ";\n"

let string_of_program fdecl =
  "\n\nParsed program: \n\n" ^
  String.concat "" (List.map string_of_vdecl fdecl.locals) ^
  String.concat "" (List.map string_of_stmt fdecl.body) ^
  "\n"
