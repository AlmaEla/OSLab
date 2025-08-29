#!/bin/bash

echo "INPUT"
echo -n "Enter number of processes-- "
read n

for (( i=1; i<=n; i++ ))
do
    pid[$i]=$i
    echo -n "Enter Burst Time for Process ${pid[$i]}-- "
    read bt[$i]
    rem_bt[$i]=${bt[$i]}
    wt[$i]=0
done

echo -n "Enter the size of time slice--"
read tq

time=0
done=0

while (( done < n ))
do
    all_done=1
    for (( i=1; i<=n; i++ ))
    do
        if (( rem_bt[$i] > 0 )); then
            all_done=0
            if (( rem_bt[$i] > tq )); then
                rem_bt[$i]=$((rem_bt[$i] - tq))
                time=$((time + tq))
            else
                time=$((time + rem_bt[$i]))
                wt[$i]=$((time - bt[$i]))
                rem_bt[$i]=0
                ((done++))
            fi
        fi
    done
    if (( all_done == 1 )); then
        break
    fi
done

total_wt=0
total_tat=0
for (( i=1; i<=n; i++ ))
do
    tat[$i]=$((bt[$i] + wt[$i]))
    total_wt=$((total_wt + wt[$i]))
    total_tat=$((total_tat + tat[$i]))
done
echo "OUTPUT"
echo -e "\nProcess\tBurst Time\tWaiting Time\tTurnAround Time"
for (( i=1; i<=n; i++ ))
do
    echo -e "${pid[$i]}\t${bt[$i]}\t\t${wt[$i]}\t\t${tat[$i]}"
done

avg_wt=$(echo "scale=6 ; $total_wt / $n" | bc)
avg_tat=$(echo "scale=6 ; $total_tat / $n" | bc)
echo -e "Average Turnaround Time = $avg_tat"
echo  "\nAverage Waiting Time = $avg_wt"
