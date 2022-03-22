### Build the HANDL parser

```
ocamlbuild test.native
```

### Run the HANDL parser
```
./test.native
```

### Compiler files
-  `ast.ml`: abstract syntax tree (AST)
-  `scanner.mll`: scanner
-  `nanocparse.mly`: parser

### Other files

- `test.ml`: top-level file to test and run the scanner
