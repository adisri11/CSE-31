#include <stdio.h>
float evensum = 0;
float oddsum = 0;
float evencount= 0;
float oddcount= 0;
int value = 1;
int num = 1;
int valuesum;

int calcsum(int n){
    if(n != 0){ //checks to see if int isn't 0
        //if negative value multiply by -1
        if(n < 0){ 
            n *= -1;
        }            
        int temp = n;//makes temp = n so n value is still saved and wont change
        valuesum = 0; //is the current sum of the digit
        while(temp > 0){ // check to make sure there is still number
            valuesum += temp % 10; // divides by ten to get one digit and adds it to the digit sum
            temp /= 10; //divides temp by 10 to remove last digit (works cause is int value and not double)
        }

        if (valuesum %2 == 0){ //checks if the sum is divisible by 2
            evensum += value;
            evencount++;
        }
        else{
            oddsum += value;
            oddcount++;
        }
    } 
    
}

int main(){

    while(value != 0){ //make sure value isnt 0 (once 0 stops)
        if(num % 10 == 1 && num != 11){ //if line number ends in 1 and isnt 11 add st to end of number
            printf("Enter the %dst value: ",num);
        } else if(num % 10 == 2 && num != 12){ //if line number ends in 2 and isnt 12 add nd to end of number
            printf("Enter the %dnd value: ",num);
        } else if(num % 10 == 3 && num != 13){ //if line number ends in 3 and isnt 13 add rd to end of number
            printf("Enter the %drd value: ",num);
        } else { //any other line number add th to end of number
            printf("Enter the %dth value: ",num);
        }
        scanf("%d", &value); //take input into value
        calcsum(value); //use function to calculate the digit sum and add to even or odd sum for value
        num++; 
    }
    

    //if there is an even number, find the average and print it out to two decimals
    if(evencount > 0 && oddcount == 0){
        float evenavg = evensum / evencount;
        printf("Average of inputs whose digits sum up to an even number: %.2f \n",evenavg);
    } else if(evencount > 0){
        float evenavg = evensum / evencount;
        printf("Average of inputs values whose digits sum up to an even number: %.2f \n",evenavg);
    }

     //if there is an odd number, find the average and print it out to two decimals
    if(oddcount > 0 && evencount == 0){
        float oddavg = oddsum / oddcount;
        printf("Average of inputs whose digits sum up to an odd number: %.2f \n",oddavg);
    } else if(oddcount > 0){
        float oddavg = oddsum / oddcount;
        printf("Average of inputs values whose digits sum up to an odd number: %.2f \n",oddavg);
    }

    if(oddcount == 0 && evencount == 0){
        printf("There is no average to compute.\n");
    }

}

