#include <stdio.h>

int main() {
    int x, y, *px, *py;
    int arr[10];
    int *p = arr;
    px = &x;
    py = &y;
    
    printf("Value of x: %d \n", x);
    printf("Value of y: %d \n", y);
    printf("Value of arr[0]: %d \n", arr[0]);

    printf("Address of x: %d \n", &x);
    printf("Address of y: %d \n", &y);
    
    printf("Value of px: %d \n", px);
    printf("Value of py: %d \n", py);

    printf("Address of px: %d \n", &px);
    printf("Address of py: %d \n", &py);

    for (int i = 0; i < 10; i++) {
        printf("%d ", *(p + i));
        printf("\n");
    }

    printf("Address of arr[0]: %d \n", &arr[0]);
    printf("Value of arr: %d \n", arr);

     printf("Address of arr: %d \n", &arr);

    return 0;
}