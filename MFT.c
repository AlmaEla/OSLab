#include <stdio.h>

int main() {
    int ms, bs, nob, ef;
    int n, mp[10], tif = 0;
    int i;

    printf("Enter the total memory available (in Bytes): ");
    scanf("%d", &ms);

    printf("Enter the block size (in Bytes): ");
    scanf("%d", &bs);

    nob = ms / bs;
    ef = ms - (nob * bs);

    printf("Enter the number of processes: ");
    scanf("%d", &n);

    for (i = 0; i < n; i++) {
        printf("Enter memory required for process %d (in Bytes): ", i + 1);
        scanf("%d", &mp[i]);
    }

    printf("\nNo. of Blocks available in memory = %d\n", nob);
    printf("\nPROCESS\tMEMORY REQUIRED\tALLOCATED\tINTERNAL FRAGMENTATION\n");

    int allocatedBlocks = 0;
    for (i = 0; i < n; i++) {
        if (allocatedBlocks < nob) {
            if (mp[i] > bs) {
                printf("%d\t%d\t\tNO\t\t-----\n", i + 1, mp[i]);
            } else {
                printf("%d\t%d\t\tYES\t\t%d\n", i + 1, mp[i], bs - mp[i]);
                tif += (bs - mp[i]);
                allocatedBlocks++;
            }
        } else {
            printf("%d\t%d\t\tNO\t\t-----\n", i + 1, mp[i]);
        }
    }

    printf("\nMemory is Full, Remaining Processes cannot be accommodated\n");
    printf("Total Internal Fragmentation = %d\n", tif);
    printf("Total External Fragmentation = %d\n", ef);

    return 0;
