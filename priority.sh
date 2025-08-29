#!/bin/bash

echo "INPUT"
echo -n "Enter the number of processes-- "
read n

for (( i=0; i<n; i++ ))
do
    echo -n "Enter the Burst Time & Priority of Process $i -- "
    read bt[$i] pr[$i]
    pid[$i]=$i
done

for (( i=0; i<n; i++ ))
do
    for (( j=i+1; j<n; j++ ))
    do
        if (( ${pr[$i]} > ${pr[$j]} )); then
            temp=${pr[$i]}; pr[$i]=${pr[$j]}; pr[$j]=$temp
            temp=${bt[$i]}; bt[$i]=${bt[$j]}; bt[$j]=$temp
            temp=${pid[$i]}; pid[$i]=${pid[$j]}; pid[$j]=$temp
        fi
    done
done

wt[0]=0
tat[0]=${bt[0]}
total_wt=0
total_tat=${tat[0]}

for (( i=1; i<n; i++ ))
do
    wt[$i]=$(( wt[$i-1] + bt[$i-1] ))
    tat[$i]=$(( wt[$i] + bt[$i] ))
    total_wt=$(( total_wt + wt[$i] ))
    total_tat=$(( total_tat + tat[$i] ))
done

echo "OUTPUT"
echo -e "\nProcess\tPriority\tBurst Time\tWaiting Time\tTurnAround Time"
for (( i=0; i<n; i++ ))
do
    echo -e "${pid[$i]}\t${pr[$i]}\t\t${bt[$i]}\t\t${wt[$i]}\t\t${tat[$i]}"
done

avg_wt=$(echo "scale=2; $total_wt / $n" | bc)
avg_tat=$(echo "scale=2; $total_tat / $n" | bc)

echo -e "\nAverage Waiting Time = $avg_wt"
echo "Average TurnAround Time = $avg_tat"
