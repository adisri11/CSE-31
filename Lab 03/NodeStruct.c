#include <stdio.h>
#include <stdlib.h>

struct Node {
    int iValue;
    float fValue;
    struct Node *next;
};

int main() {
    struct Node *head = (struct Node*) malloc(sizeof(struct Node));
    head->iValue = 5;
    head->fValue = 3.14;

    // Insert code here
    printf("head value: %p \n", head);
    printf("head address: %p \n", &head);
    printf("iValue address: %p \n", &(head -> iValue));
    printf("fValue address: %p \n", &(head -> fValue));
    printf("next address: %p \n", &(head -> next));

    return 0;
}
