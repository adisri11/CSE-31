#include <stdio.h>
int main() {
    int i;
    int* four_ints;
    char four_c[4];

    four_c[0] = 'A';
    four_c[1] = 'B';
    four_c[2] = 'C';
    four_c[3] = 'D';

        printf("%c\n", four_c[0]);

    four_ints = (int*) four_c;    
  
    // for(i = 0; i < 4; i++)
    //     four_ints[i] = 2;
    // //printf("%x\n", four_ints[0]);
    // four_c = (char*)four_ints;

    // for(i = 0; i < 4; i++)
    //     four_c[i] = 'A' + i; // ASCII value of 'A' is 65 or 0x41 in Hex.

    // // Add your code for the exercises here:

    for(i = 0; i < 4; i++)
        printf("%x\n", four_ints[i]);

    for(i = 0; i < 4; i++)
        printf("%x\n", four_c[i]);

    for(i = 0; i < 4; i++){
        printf("%d\n", four_ints[i]);
    }

    for(i = 0; i < 4; i++){
        printf("%c\n", four_c[i]);
    }

    for(i = 0; i < 4; i++){
        printf("%p\n", &four_ints[i]);
    }

    for(i = 0; i < 4; i++){
        printf("%p\n", &four_c[i]);
    }

    return 0;
}
