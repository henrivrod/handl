#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Note{
    char* pitch;
    float duration;
};

struct Phrase{
    Note* notes
};

struct Song{
    Phrase* measures;
    char* timeSignature;
    int bars;
};

void phraseAdd(Note n){

}

void generateSong(Song s){

}
