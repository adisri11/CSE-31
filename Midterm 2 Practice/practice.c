#include <stdio.h>

int main(){
    int j = 5;
    int k = 10;
    int l = 15;
    int m = 25;
    int x;

    if (j <= 10 && k > 20 || l >= m) {
        x = 5;
    } else {
        x = 10;
    }

    printf("%d\n", x);
}