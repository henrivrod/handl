(* Top-level of the Handl compiler: scan & parse the input,
   check the resulting AST and generate an SAST from it, generate LLVM IR,
   and dump the module *)

   type action = Ast | Sast | LLVM_IR | Compile

   let () =
     let action = ref LLVM_IR in (*NEEDS TO BE CHANGED TO COMPILE ONCE WE'RE READY*)
     let set_action a () = action := a in
     let speclist = [
       ("-a", Arg.Unit (set_action Ast), "Print the AST");
       ("-s", Arg.Unit (set_action Sast), "Print the SAST");
       ("-l", Arg.Unit (set_action LLVM_IR), "Print the generated LLVM IR");
       (*("-c", Arg.Unit (set_action Compile),
         "Check and print the generated LLVM IR (default)");*)
     ] in  
     let usage_msg = "usage: ./handl.native [-a|-s|-l|-c] [file.hdl]" in
     let channel = ref stdin in
     Arg.parse speclist (fun filename -> channel := open_in filename) usage_msg;
     
     let lexbuf = Lexing.from_channel !channel in
     let ast = Handlparse.program Scanner.token lexbuf in
     match !action with
       Ast -> print_string (Ast.string_of_program ast)
     | _ -> let sast = Semant.check ast in
       match !action with
         Ast     -> ()
       | Sast    -> print_string (Sast.string_of_sprogram sast)
       | LLVM_IR -> print_string (Llvm.string_of_llmodule (Handlirgen.translate sast))
     (*  | Compile -> let m = Handlirgen.translate sast in
     Llvm_analysis.assert_valid_module m;
     print_string (Llvm.string_of_llmodule m)*)