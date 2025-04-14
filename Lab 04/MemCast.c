#include <stdio.h>
int main() {
    int i;
    int four_ints[4];
    char* four_c;

    for(i = 0; i < 4; i++)
        four_ints[i] = 2;

    printf("%x\n", four_ints[0]);

    four_c = (char*)four_ints;

    for(i = 0; i < 4; i++)
        four_c[i] = 'A' + i; // ASCII value of 'A' is 65 or 0x41 in Hex.

    // Add your code for the exercises here:

    printf("%x\n", four_ints[0]);
    printf("%x\n", four_ints[1]);

    for(i = 0; i < 4; i++){
        printf("four_ints: \n");
        printf("%d\n", four_ints[i]);
    }

    for(i = 0; i < 4; i++){
        printf("four_c: \n");
        printf("%s\n", &four_c[i]);
    }

    for(i = 0; i < 4; i++){
        printf("four_ints hex: \n");
        printf("%x\n", four_ints[i]);
    }

    for(i = 0; i < 4; i++){
        printf("four_ints address: \n");
        printf("%p\n", (void *)&four_ints[i]);
    }

    for(i = 0; i < 4; i++){
        printf("four_c hex: \n");
        printf("%x\n", four_c[i]);
    }

    for(i = 0; i < 4; i++){
        printf("four_c address: \n");
        printf("%p\n", &four_c[i]);
    }



    return 0;
}
