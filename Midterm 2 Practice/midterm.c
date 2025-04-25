#include <stdio.h>

int func2(int a , int b){
    int d = a + b;
    return b*d;
}

int func1(int a, int b){
    int c = a % b;
    return func2(a, b+c) - b - c;
}

int main(){
    int a = 13;
    int b = 5;

    printf("%d", func1(a,b));
}
