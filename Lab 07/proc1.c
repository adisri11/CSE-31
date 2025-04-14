#include <stdio.h>
int sum(int n, int m){
    return m + n;
}

int main() {
    int m = 10;
    int n = 5;

    int result = sum(n, m);

    printf("%d\n", result);

}
