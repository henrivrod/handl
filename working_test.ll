; ModuleID = 'Handl'
source_filename = "Handl"

@fmt = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@fmt.1 = private unnamed_addr constant [4 x i8] c"%B\0A\00", align 1
@fmt.2 = private unnamed_addr constant [4 x i8] c"%g\0A\00", align 1
@fmt.3 = private unnamed_addr constant [4 x i8] c"%c\0A\00", align 1
@fmt.4 = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@fmt.5 = private unnamed_addr constant [11 x i8] c"/%s/ /%g/\0A\00", align 1
@str_ptr = private unnamed_addr constant [3 x i8] c"A1\00", align 1
@str_ptr.6 = private unnamed_addr constant [3 x i8] c"A2\00", align 1
@str_ptr.7 = private unnamed_addr constant [3 x i8] c"B1\00", align 1

declare i32 @printf(i8*, ...)

define i32 @main() {
entry:
  %x = alloca i8**, align 8
  %n = alloca i8*, align 8
  %n1 = alloca i8*, align 8
  %n2 = alloca i8*, align 8
  %s = alloca i8***, align 8
  %make_array = tail call i8* @malloc(i32 mul (i32 add (i32 mul (i32 ptrtoint (i8*** getelementptr (i8**, i8*** null, i32 1) to i32), i32 8), i32 12), i32 ptrtoint (i8* getelementptr (i8, i8* null, i32 1) to i32)))
  %body_ptr = getelementptr i8, i8* %make_array, i8 12
  %i32_ptr_t = bitcast i8* %body_ptr to i32*
  %meta_ptr = getelementptr i32, i32* %i32_ptr_t, i32 -3
  store i32 ptrtoint (i8*** getelementptr (i8**, i8*** null, i32 1) to i32), i32* %meta_ptr, align 4
  %i32_ptr_t1 = bitcast i8* %body_ptr to i32*
  %meta_ptr2 = getelementptr i32, i32* %i32_ptr_t1, i32 -2
  store i32 add (i32 mul (i32 ptrtoint (i8*** getelementptr (i8**, i8*** null, i32 1) to i32), i32 8), i32 12), i32* %meta_ptr2, align 4
  %i32_ptr_t3 = bitcast i8* %body_ptr to i32*
  %meta_ptr4 = getelementptr i32, i32* %i32_ptr_t3, i32 -1
  store i32 8, i32* %meta_ptr4, align 4
  %make_array_ptr = bitcast i8* %body_ptr to i8***
  store i8*** %make_array_ptr, i8**** %s, align 8
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @str_ptr, i32 0, i32 0), i8** %n, align 8
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @str_ptr.6, i32 0, i32 0), i8** %n1, align 8
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @str_ptr.7, i32 0, i32 0), i8** %n2, align 8
  %make_array5 = tail call i8* @malloc(i32 mul (i32 add (i32 mul (i32 ptrtoint (i8** getelementptr (i8*, i8** null, i32 1) to i32), i32 8), i32 12), i32 ptrtoint (i8* getelementptr (i8, i8* null, i32 1) to i32)))
  %body_ptr6 = getelementptr i8, i8* %make_array5, i8 12
  %i32_ptr_t7 = bitcast i8* %body_ptr6 to i32*
  %meta_ptr8 = getelementptr i32, i32* %i32_ptr_t7, i32 -3
  store i32 ptrtoint (i8** getelementptr (i8*, i8** null, i32 1) to i32), i32* %meta_ptr8, align 4
  %i32_ptr_t9 = bitcast i8* %body_ptr6 to i32*
  %meta_ptr10 = getelementptr i32, i32* %i32_ptr_t9, i32 -2
  store i32 add (i32 mul (i32 ptrtoint (i8** getelementptr (i8*, i8** null, i32 1) to i32), i32 8), i32 12), i32* %meta_ptr10, align 4
  %i32_ptr_t11 = bitcast i8* %body_ptr6 to i32*
  %meta_ptr12 = getelementptr i32, i32* %i32_ptr_t11, i32 -1
  store i32 8, i32* %meta_ptr12, align 4
  %make_array_ptr13 = bitcast i8* %body_ptr6 to i8**
  store i8** %make_array_ptr13, i8*** %x, align 8
  %n14 = load i8*, i8** %n, align 8
  %x15 = load i8**, i8*** %x, align 8
  %"x[i32 0]" = getelementptr inbounds i8*, i8** %x15, i32 0
  store i8* %n14, i8** %"x[i32 0]", align 8
  %n116 = load i8*, i8** %n1, align 8
  %x17 = load i8**, i8*** %x, align 8
  %"x[i32 1]" = getelementptr inbounds i8*, i8** %x17, i32 1
  store i8* %n116, i8** %"x[i32 1]", align 8
  %n218 = load i8*, i8** %n2, align 8
  %x19 = load i8**, i8*** %x, align 8
  %"x[i32 2]" = getelementptr inbounds i8*, i8** %x19, i32 2
  store i8* %n218, i8** %"x[i32 2]", align 8
  %n20 = load i8*, i8** %n, align 8
  %x21 = load i8**, i8*** %x, align 8
  %"x[i32 3]" = getelementptr inbounds i8*, i8** %x21, i32 3
  store i8* %n20, i8** %"x[i32 3]", align 8
  %n22 = load i8*, i8** %n, align 8
  %x23 = load i8**, i8*** %x, align 8
  %"x[i32 4]" = getelementptr inbounds i8*, i8** %x23, i32 4
  store i8* %n22, i8** %"x[i32 4]", align 8
  %n24 = load i8*, i8** %n, align 8
  %x25 = load i8**, i8*** %x, align 8
  %"x[i32 5]" = getelementptr inbounds i8*, i8** %x25, i32 5
  store i8* %n24, i8** %"x[i32 5]", align 8
  %n26 = load i8*, i8** %n, align 8
  %x27 = load i8**, i8*** %x, align 8
  %"x[i32 6]" = getelementptr inbounds i8*, i8** %x27, i32 6
  store i8* %n26, i8** %"x[i32 6]", align 8
  %n128 = load i8*, i8** %n1, align 8
  %x29 = load i8**, i8*** %x, align 8
  %"x[i32 7]" = getelementptr inbounds i8*, i8** %x29, i32 7
  store i8* %n128, i8** %"x[i32 7]", align 8
  %x30 = load i8**, i8*** %x, align 8
  %s31 = load i8***, i8**** %s, align 8
  %"s[i32 0]" = getelementptr inbounds i8**, i8*** %s31, i32 0
  store i8** %x30, i8*** %"s[i32 0]", align 8
  %x32 = load i8**, i8*** %x, align 8
  %s33 = load i8***, i8**** %s, align 8
  %"s[i32 1]" = getelementptr inbounds i8**, i8*** %s33, i32 1
  store i8** %x32, i8*** %"s[i32 1]", align 8
  %x34 = load i8**, i8*** %x, align 8
  %s35 = load i8***, i8**** %s, align 8
  %"s[i32 2]" = getelementptr inbounds i8**, i8*** %s35, i32 2
  store i8** %x34, i8*** %"s[i32 2]", align 8
  %x36 = load i8**, i8*** %x, align 8
  %s37 = load i8***, i8**** %s, align 8
  %"s[i32 3]" = getelementptr inbounds i8**, i8*** %s37, i32 3
  store i8** %x36, i8*** %"s[i32 3]", align 8
  %x38 = load i8**, i8*** %x, align 8
  %s39 = load i8***, i8**** %s, align 8
  %"s[i32 4]" = getelementptr inbounds i8**, i8*** %s39, i32 4
  store i8** %x38, i8*** %"s[i32 4]", align 8
  %x40 = load i8**, i8*** %x, align 8
  %s41 = load i8***, i8**** %s, align 8
  %"s[i32 5]" = getelementptr inbounds i8**, i8*** %s41, i32 5
  store i8** %x40, i8*** %"s[i32 5]", align 8
  %x42 = load i8**, i8*** %x, align 8
  %s43 = load i8***, i8**** %s, align 8
  %"s[i32 6]" = getelementptr inbounds i8**, i8*** %s43, i32 6
  store i8** %x42, i8*** %"s[i32 6]", align 8
  %x44 = load i8**, i8*** %x, align 8
  %s45 = load i8***, i8**** %s, align 8
  %"s[i32 7]" = getelementptr inbounds i8**, i8*** %s45, i32 7
  store i8** %x44, i8*** %"s[i32 7]", align 8
  %s46 = load i8***, i8**** %s, align 8
  %play_song = call i32 (i8***, ...) @play_song(i8*** %s46)
  ret i32 0
}

declare i32 @play_song(i8***, ...)

declare noalias i8* @malloc(i32)
