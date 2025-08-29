#!/bin/bash
read -p "Enter the number of processes-- " n

for ((i=0;i<n;i++))
do
    read -p "Enter Burst Time for Process$i-- " bt[$i]
    P_id[$i]=$i
done

# Print INPUT line
echo ""
echo "INPUT"
echo "Number of Processes: $n"
for ((i=0;i<n;i++))
do
    echo "Process $i Burst Time: ${bt[$i]}"
done

# --- SJF Scheduling (Non-preemptive) ---

# Sort processes by Burst Time (ascending)
for ((i=0;i<n;i++))
do
    for ((j=i+1;j<n;j++))
    do
        if (( bt[i] > bt[j] )); then
            # Swap Burst Time
            temp=${bt[i]}
            bt[$i]=${bt[j]}
            bt[$j]=$temp
            # Swap Process ID
            temp=${P_id[i]}
            P_id[$i]=${P_id[$j]}
            P_id[$j]=$temp
        fi
    done
done

# Waiting Time calculation
wt[0]=0
for ((i=1;i<n;i++))
do
    wt[$i]=$((wt[$i-1] + bt[$i-1]))
done

# Turnaround Time calculation
for ((i=0;i<n;i++))
do
    tat[$i]=$((wt[$i] + bt[$i]))
done

# Average calculation
total_wt=0
total_tat=0
for ((i=0;i<n;i++))
do
    total_wt=$((total_wt + wt[$i]))
    total_tat=$((total_tat + tat[$i]))
done

avg_wt=$(echo "scale=2; $total_wt / $n" | bc)
avg_tat=$(echo "scale=2; $total_tat / $n" | bc)

# Print OUTPUT line
echo ""
echo "OUTPUT"
echo "Process    BurstTime    WaitingTime    TurnAroundTime"
for ((i=0;i<n;i++))
do
    # Row sequence = execution sequence
    echo "   P${P_id[$i]}          ${bt[$i]}            ${wt[$i]}              ${tat[$i]}"
done

echo ""
echo "Average Waiting Time-- $avg_wt"
echo "Average TurnAround Time-- $avg_tat"
