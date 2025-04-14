#include <stdio.h>

int main(){
    int reps; //stores how many reps
    int typo; //stores where to put typo sentence

    printf("Enter the repetiton count for the punishment phrase: ");
    scanf("%d", &reps); //take input of how many reps

    //check if number or reps is more than 0, if isn't then asks for new number, until there is a valid number
    while(reps <= 0){
        printf("You entered an invalid value for the repetition count! Please re-enter: ");
        scanf("%d", &reps); //take input of how many reps
    }

    printf("\n");// prints empty line

    printf("Enter the line where you want to insert the typo: ");
    scanf("%d", &typo); //take input of which line to put the typo
    
    //checks is typo is greater than number of repetitions or if typo is less than 0, if true then asks for new number until a valid answer is given
    while(typo > reps || typo <= 0){
        printf("You entered an invalid value for the typo placement! Please re-enter: ");
        scanf("%d", &typo); //take input of which line to put the typo
    }

    printf("\n"); // prints empty line

    //prints out the lines
    for(int i = 1; i <= reps; i++){ //starts at 1 cause first line would be 1
        if(i != typo){ //if i is not the same line number as typo then print the proper line
            printf("Coding with C is awesome!\n");
        }
        else if (i == typo) //if i is the same line number as typo then print the typo line
        {
            printf("Cading wiht is C avesone!\n");
        }
        
    }

}