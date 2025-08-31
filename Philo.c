#include <stdio.h>

void one_can_eat(int hungry[], int n) {
    printf("\nAllow one philosopher to eat at any time\n");
    for (int i = 0; i < n; i++) {
        printf("P %d is granted to eat\n", hungry[i]);
        for (int j = 0; j < n; j++) {
            if (j != i) {
                printf("P %d is waiting\n", hungry[j]);
            }
        }
    }
}

void two_can_eat(int hungry[], int n) {
    printf("\nAllow two philosophers to eat at any time\n");
    int i = 0;
    while (i < n) {
        if (i + 1 < n) {
            printf("P %d and P %d are granted to eat\n", hungry[i], hungry[i + 1]);
            for (int j = 0; j < n; j++) {
                if (j != i && j != i + 1) {
                    printf("P %d is waiting\n", hungry[j]);
                }
            }
            i += 2;
        } else {
            printf("P %d is granted to eat\n", hungry[i]);
            for (int j = 0; j < n; j++) {
                if (j != i) {
                    printf("P %d is waiting\n", hungry[j]);
                }
            }
            i++;
        }
    }
}

int main() {
    int philosophers, hungry_count, hungry[10], choice;
    printf("DINING PHILOSOPHER PROBLEM\n");
    printf("Enter the total no. of philosophers: ");
    scanf("%d", &philosophers);
    printf("How many are hungry: ");
    scanf("%d", &hungry_count);

    for (int i = 0; i < hungry_count; i++) {
        printf("Enter philosopher %d position: ", i + 1);
        scanf("%d", &hungry[i]);
    }

    do {
        printf("\n1.One can eat at a time\t2.Two can eat at a time\t3.Exit\nEnter your choice: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                one_can_eat(hungry, hungry_count);
                break;
            case 2:
                two_can_eat(hungry, hungry_count);
                break;
            case 3:
                printf("Exiting...\n");
                break;
            default:
                printf("Invalid choice. Try again.\n");
        }
    } while (choice != 3);

    return 0;
}
