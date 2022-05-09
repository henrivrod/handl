#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define LEN(arr) ((int) (sizeof (arr) / sizeof (arr)[0]))

 
struct Note
{
    char pitch[4];
};
 
struct Phrase
{

    struct Note notes[5];
};

struct Song
{
    struct Phrase measures[6];
    char timeSignature[4];
    int bars;
};
 
int main() 
{
    struct Note n1 = {"E3"};
    struct Note n2 = {"A2"};
    struct Note n3 = {"A3"};
    struct Note n4 = {"A1"};
    
    struct Note n5 = {"B1"};
    struct Note n6 = {"B2"};
    struct Note n7 = {"A#2"};
    struct Note n8 = {"D2"};
    
    struct Phrase p1 = {{n1,n2,n3,n4}};
    struct Phrase p2 = {{n5,n6,n7,n8}};
    struct Phrase p3 = {{n1,n2,n3,n4}};
    struct Phrase p4 = {{n5,n6,n7,n8}};
    struct Phrase p5 = {{n1,n2,n3,n4}};
    struct Song s1 = {{p1,p2,p3,p4,p5},"4/4",5};
    
    for(int i=0; i < LEN(s1.measures)-1; i++){
        
            char E[] = "------------";
            char A[] = "------------";
            char D[] = "------------";
            char G[] = "------------";
            char B[] = "------------";
            char e[] = "------------";
       
        for(int j=0; j < 4; j++){
            // printf("%s", s1.measures[i].notes[j].pitch);
            // printf("\n");

            char* cur = s1.measures[i].notes[j].pitch;
            //High e string
            if(strcmp(cur,"E3")==0){
                e[3*j + 1] = '0';
                
            }
            else if(strcmp(cur,"F3")==0){
                e[3*j + 1] = '1';
            }
            else if(strcmp(cur,"F#3")==0 || strcmp(cur,"Gb3")==0){
                e[3*j + 1] = '2';
            }
            else if(strcmp(cur,"G3")==0){
                e[3*j + 1] = '3';
            }
            else if(strcmp(cur,"G#3")==0 || strcmp(cur,"Ab3")==0){
                e[3*j + 1] = '4';
            }
            
            //B String
            else if(strcmp(cur,"B2")==0){
                B[3*j + 1] = '0';
            }
            else if(strcmp(cur,"C2")==0){
                B[3*j + 1] = '1';
            }
            else if(strcmp(cur,"C#2")==0 || strcmp(cur,"Db2")==0){
                B[3*j + 1] = '2';
            }
            else if(strcmp(cur,"D2")==0){
                B[3*j + 1] = '3';
            }
            else if(strcmp(cur,"D#2")==0 || strcmp(cur,"Eb2")==0){
                B[3*j + 1] = '4';
            }
            //G String
            else if(strcmp(cur,"G2")==0){
                G[3*j + 1] = '0';
            }
            else if(strcmp(cur,"G#2")==0 || strcmp(cur,"Ab2")==0){
                G[3*j + 1] = '1';
            }
            else if(strcmp(cur,"A2")==0 ){
                G[3*j + 1] = '2';
            }
            else if(strcmp(cur,"A#2")==0 || strcmp(cur,"Bb2")==0){
                G[3*j + 1] = '3';
            }
            else if(strcmp(cur,"B2")==0){
                G[3*j + 1] = '4';
            }
            //D string
            else if(strcmp(cur,"D1")==0){
                D[3*j + 1] = '0';
            }
            else if(strcmp(cur,"D#1")==0 || strcmp(cur,"Eb1")==0){
                D[3*j + 1] = '1';
            }
            else if(strcmp(cur,"E2")==0 ){
                D[3*j + 1] = '2';
            }
            else if(strcmp(cur,"F2")==0){
                D[3*j + 1] = '3';
            }
            else if(strcmp(cur,"F#2")==0 || strcmp(cur,"Gb2")==0){
                D[3*j + 1] = '4';
            }
            //A string
            else if(strcmp(cur,"A1")==0){
                A[3*j + 1] = '0';
            }
            else if(strcmp(cur,"A#1")==0 || strcmp(cur,"Bb1")==0){
                A[3*j + 1] = '1';
            }
            else if(strcmp(cur,"B1")==0 ){
                A[3*j + 1] = '2';
            }
            else if(strcmp(cur,"C1")==0){
                A[3*j + 1] = '3';
            }
            else if(strcmp(cur,"C#1")==0 || strcmp(cur,"Db1")==0){
                A[3*j + 1] = '4';
            }
            //Low E string
            else if(strcmp(cur,"E1")==0){
                E[3*j + 1] = '0';
                
            }
            else if(strcmp(cur,"F1")==0){
                E[3*j + 1] = '1';
            }
            else if(strcmp(cur,"F#1")==0 || strcmp(cur,"Gb1")==0){
                E[3*j + 1] = '2';
            }
            else if(strcmp(cur,"G1")==0){
                E[3*j + 1] = '3';
            }
            else if(strcmp(cur,"G#1")==0 || strcmp(cur,"Ab1")==0){
                E[3*j + 1] = '4';
            }
            
        }
        printf("%s\n",e);
        printf("%s\n",B);
        printf("%s\n",G);
        printf("%s\n",D);
        printf("%s\n",A);
        printf("%s\n",E);
        printf("/////////////\n");
       
    }
 
    

    return 0;
}


