#include <stdio.h>
#include <stdlib.h>

#define SIZE 5
int buffer[SIZE];
int count = 0;

void producer() {
    if (count < SIZE) {
        int item;
        printf("Enter the value: ");
        scanf("%d", &item);
        buffer[count++] = item;
        printf("Item Produced!\n");
    } else {
        printf("Buffer is Full!\n");
    }
}

void consumer() {
    if (count > 0) {
        int item = buffer[--count];
        printf("The consumed value is %d\n", item);
    } else {
        printf("Buffer is Empty!\n");
    }
}

int main() {
    int choice;
    while (1) {
        printf("\n1. Produce\t2. Consume\t3. Exit\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                producer();
                break;
            case 2:
                consumer();
                break;
            case 3:
                exit(0);
            default:
                printf("Invalid choice!\n");
        }
    }

    return 0;
}
