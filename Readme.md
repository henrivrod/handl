# HANDL Intro
HANDL is a high-level language inspired by the paradigms of GO. Our interest in creating HANDL was to build a language that would not be too complex for novel users to pick up. The specific group we are focusing on is musicians, and so we picked syntax that is similar to what musicians use: notes, phrases, songs, measures, etc.  We want musicians to see in HANDL something similar to what they see in their performance and compositional work. This way, they can be most comfortable learning about the syntax and norms of a programming language and also can create something truly interesting with it. They will be able to easily create guitar tabs (notation for playing guitar) using our code. Using HANDL, musicians could come up with some exciting algorithmically-generated tabs and delve into the world of computer-generated music, or even just use it for the creation of simple guitar tabs. Code will be converted by HANDL from syntax into human-readable Guitar tabs. In this way, HANDL will function somewhat as a DSL but will also be able to handle the average functions of most programming languages.

## File Structure
-  `scanner.mll`: scanner
            |
-  `handlparse.mly`: parser
            |
-  `ast.ml`: abstract syntax tree (AST)
            |
-  `semant.ml`: semantic checking
            |
-  `sast.ml`: semantically-checked AST
            |
-  `handlirgen.ml`: IR generator

-   tests folder: has all our tests

-   demo.sh : script for compiling a test
-   tests.sh : script for compiling all tests in tests folder
```
.add(), .timeSignature, .bars, .tempo, .measure(), .play(), and .save()
```
We will also need to work further on our semantic checker and sast file. We have the barebones of them but still need to work on fixing them up so they actually work.

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
-  `sast.ml`: definition of the semantically-checked AST (IN PROGRESS)
-  `semant.ml`: semantic checking (IN PROGRESS)

### Other files

- `test.ml`: top-level file to test and run the scanner/parser
- `test2.ml`: the file to test the semantic checker
- 'helloWorld.hdl': example text to input to parser


