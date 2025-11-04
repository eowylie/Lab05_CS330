/*
 * CS330 - HW #5
 * Ethan Wylie - eowylie
 * 
 * This program functions by:
 * 1. Declaring an integer array
 * 2. Using pointers to visit each element
 * 3. Replacing each element with its square
 * 4. Printing the modified array
 */

#include <stdio.h>

int main() {
    // Step 1: Declare an integer array with hardcoded values
    int myarr[] = {2, 3, 5, 7, 11, 13};  // Example values
    int size = sizeof(myarr) / sizeof(myarr[0]);  // Calculate array size
    
    printf("Original array: ");
    for (int i = 0; i < size; i++) {
        printf("%d ", *(myarr + i)); // Print each element
    }
    printf("\n");
    
    // Step 2 & 3: Use pointers to visit each element and replace with its square
    for (int i = 0; i < size; i++) {
        // *(myarr + i) to access elements
        int current_value = *(myarr + i);
        *(myarr + i) = current_value * current_value;  // Square the element
    }
    
    // Step 4: Print the array after modification
    printf("Modified array (squared): ");
    for (int i = 0; i < size; i++) {
        printf("%d ", *(myarr + i));  // Print each
    }
    printf("\n");
    
    return 0;
}
