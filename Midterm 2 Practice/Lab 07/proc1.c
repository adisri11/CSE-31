#include <stdio.h>

int sum(int m, int n){
    int result = m + n;
    return result;
}


int main(){
    int m = 10;
    int n = 5;

    int result = sum(m, n);
    printf("%d\n", result);

}