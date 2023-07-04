#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define MAX_NUMBERS 10

extern double average(int *, int);

int main() {
    int numbers_count, digit_counts, n, current_number;
    int numbers[10];
    char* input = (char *) malloc(10000 * sizeof(char));
    int is_negative;

    while (1) {
        scanf("%[^\n]%*c", input);
        numbers_count = 0;
        digit_counts = 0;
        n = strlen(input) + 1;
        is_negative = 0;
        current_number = 0;

        for (int i = 0; i < n; i++) {
            if (numbers_count == MAX_NUMBERS)
                break;

            char character = input[i];

            if (character < '0' || character > '9') {
                printf("%c", character);
                if (digit_counts != 0) {
                    digit_counts = 0;

                    if (is_negative)
                        current_number *= -1;

                    numbers[numbers_count++] = current_number;
                }
                if (character == '-')
                    is_negative = 1;
                else
                    is_negative = 0;
                current_number = 0;
            } else {
                current_number = current_number * 10 + character - '0';
                digit_counts++;
            }
        }
        printf("\n");
        for (int j = 0; j < numbers_count; j++)
            printf("%d\n", numbers[j]);

        double avg = average(numbers, numbers_count);
    
        printf("\nnumbers_count: %d\naverage: %f\n-------\n", numbers_count, avg);
    }
    
    return 0;
}