#include "VarClass.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>


void reverseString(char* str) {
    int length = strlen(str);
    for (int i = 0; i < length / 2; i++) {
        char temp = str[i];
        str[i] = str[length - i - 1];
        str[length - i - 1] = temp;
    }
}


struct Digits getDigits(int val){ // saving number as struct
    struct Digits digits;
    int i = 0;
    digits.arrSize = 0;
    while (val != 0){
        digits.arr[i++] = (val  % 10) + '0';
        val /= 10;
    };
    digits.arr[i] = '\0';
    digits.arrSize = i;
    reverseString(digits.arr);
    strcpy(digits.tmp , digits.arr);
    return digits;
}