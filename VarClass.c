#include "VarClass.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>


// char* getVar(int varInd){
//     char* newVar = (char *)malloc(100 * sizeof(char));
//     sprintf(newVar , "t%d" , varInd++);
//     return newVar;
// } 



// void reverseString(char* str) {
//     int length = strlen(str);
//     for (int i = 0; i < length / 2; i++) {
//         char temp = str[i];
//         str[i] = str[length - i - 1];
//         str[length - i - 1] = temp;
//     }
// }

// struct Digits getDigits(int val){
//     struct Digits digits;
//     digits.value = val;
//     int i = 0;
//     digits.arrSize = 0;
//     while (val != 0){
//         digits.arr[i++] = (val  % 10) + '0';
//         val /= 10;
//     };
//     digits.arr[i] = '\0';
//     digits.arrSize = i;
//     reverseString(digits.arr);
//     strcpy(digits.tmp , digits.arr);
//     return digits;
// }