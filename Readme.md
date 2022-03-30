# HANDL
HANDL is a high-level language inspired by the paradigms of GO. Our interest in creating HANDL was to build a language with as much of the English language as possible, so English speakers with little coding experience can most easily learn. The specific group we are focusing on is musicians, hence the Note Declaring attribute. We want musicians to see in HANDL something similar to what they see in their performance and compositional work.


## Hello World Front-end
At this stage in our development of Handl, we have provided most of the Front-end functionality for the language. We have yet to include several language specific functions that we plan on implementing when we get a better grasp of the back end. Although subject to change, these functions should include: 

```
.add(), .timeSignature, .bars, .tempo, .measure(), .play(), and .save()
```

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
-  `handlparse.mly`: parser

### Other files

- `test.ml`: top-level file to test and run the scanner
