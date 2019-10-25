#!/bin/bash

# Read the textfile which holds the arguments and then parse those arguments 
# into the run file for an algorithm


#it reads the file per line, IFS leaves in the whitespacing
#[[ -n "$Line" ]] -> this prevents the last line from being ignored"


#I set the IFS to tab spaces that splits based on tabs per line
while IFS=$'\t' read -r line || [[ -n "$line" ]];
#loop
	do 
	#Echo is used to print so , printing the line
	words=($line)

	#print the array of words
	
	sleep 1s
	
	#Word values work as follows (1 - On Policy Algorithm 2- Off Policy Algorithm 3- Environment 4- 	#Transition instance
		
	echo "-------------------------------------------------"
	echo "The On - Policy Algorithm Chosen: ${words[0]}"
	echo "The Off Policy Algoirthm Chosen: ${words[1]}"
	echo "The Environment is: ${words[2]}"
	echo "The Transition Instance: ${words[3]}"
	echo "-------------------------------------------------"
	echo "Inputting argument parameters"

	sleep 1s
	
	if [[ "${words[0]}" == "NPG" && "${words[1]}" == "DQN" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 NPG/npg.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 run_main.py -alg ${words[1]} -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 NPG/npg.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 run_main.py -alg ${words[1]} -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi	
	
	if [[ "${words[0]}" == "NPG" && "${words[1]}" == "DoubleDQN" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 NPG/npg.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 run_main.py -alg ${words[1]} -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 NPG/npg.py ${words[2]} 1,000,000
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 run_main.py -alg ${words[1]} -env ${words[2]} -eps 1,000,000
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi

	if [[ "${words[0]}" == "NPG" && "${words[1]}" == "DoubleDuelingDQN" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 NPG/npg.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 NPG/npg.py ${words[2]} 1,000,000
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi

	if [[ "${words[0]}" == "NPG" && "${words[1]}" == "DDDQN-PER" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 NPG/npg.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 NPG/npg.py ${words[2]} 1,000,000
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi

	if [[ "${words[0]}" == "NPG" && "${words[1]}" == "DQN-PER" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 NPG/npg.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 NPG/npg.py ${words[2]} 1,000,000
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi

	if [[ "${words[0]}" == "NPG" && "${words[1]}" == "OPG" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 NPG/npg.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 OPG/OPG.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 NPG/npg.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 OPG/OPG.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi

	if [[ "${words[0]}" == "A3C" && "${words[1]}" == "DQN" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 A3C/A3C.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 run_main.py -alg ${words[1]} -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 A3C/A3C.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 run_main.py -alg ${words[1]} -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi

	if [[ "${words[0]}" == "A3C" && "${words[1]}" == "DoubleDQN" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 A3C/A3C.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 run_main.py -alg ${words[1]} -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 A3C/A3C.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 run_main.py -alg ${words[1]} -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi
	
	if [[ "${words[0]}" == "A3C" && "${words[1]}" == "DoubleDuelingDQN" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 A3C/A3C.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 A3C/A3C.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi

	if [[ "${words[0]}" == "A3C" && "${words[1]}" == "DDDQN-PER" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 A3C/A3C.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 A3C/A3C.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi

	if [[ "${words[0]}" == "A3C" && "${words[1]}" == "DQN-PER" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 A3C/A3C.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 A3C/A3C.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi

	if [[ "${words[0]}" == "A3C" && "${words[1]}" == "OPG" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 A3C/A3C.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 OPG/OPG.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 A3C/A3C.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 OPG/OPG.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi

	if [[ "${words[0]}" == "TRPO" && "${words[1]}" == "DQN" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 TRPO/TRPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 run_main.py -alg ${words[1]} -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 TRPO/TRPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 run_main.py -alg ${words[1]} -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi

	if [[ "${words[0]}" == "TRPO" && "${words[1]}" == "DoubleDQN" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 TRPO/TRPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 run_main.py -alg ${words[1]} -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 TRPO/TRPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 run_main.py -alg ${words[1]} -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi
	
	if [[ "${words[0]}" == "TRPO" && "${words[1]}" == "DoubleDuelingDQN" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 TRPO/TRPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 TRPO/TRPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi

	if [[ "${words[0]}" == "TRPO" && "${words[1]}" == "DDDQN-PER" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 TRPO/TRPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 TRPO/TRPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi

	if [[ "${words[0]}" == "TRPO" && "${words[1]}" == "DQN-PER" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 TRPO/TRPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 TRPO/TRPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi

	if [[ "${words[0]}" == "TRPO" && "${words[1]}" == "OPG" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 TRPO/TRPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 OPG/OPG.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 TRPO/TRPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 OPG/OPG.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi

	if [[ "${words[0]}" == "PPO" && "${words[1]}" == "DQN" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 PPO/PPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 run_main.py -alg ${words[1]} -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 PPO/PPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 run_main.py -alg ${words[1]} -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi

	if [[ "${words[0]}" == "PPO" && "${words[1]}" == "DoubleDQN" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 PPO/PPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 run_main.py -alg ${words[1]} -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 PPO/PPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 run_main.py -alg ${words[1]} -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi
	
	if [[ "${words[0]}" == "PPO" && "${words[1]}" == "DoubleDuelingDQN" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 PPO/PPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 PPO/PPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi

	if [[ "${words[0]}" == "PPO" && "${words[1]}" == "DDDQN-PER" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 PPO/PPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 PPO/PPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi

	if [[ "${words[0]}" == "PPO" && "${words[1]}" == "DQN-PER" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 PPO/PPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 PPO/PPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 run_main.py -alg DoubleDQN -env ${words[2]} -eps 1,000,000
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi

	if [[ "${words[0]}" == "PPO" && "${words[1]}" == "OPG" ]]; then
		echo "-------------------------------------------------"
		echo "Benchmark On - Policy Algorithm: ${words[0]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[0]}"
		python3 PPO/PPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Benchmark Off - Policy Algorithm: ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning ${words[1]}"
		python3 OPG/OPG.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "Hybrid On and Off Policy Algorithm: ${words[0]} & ${words[1]}"
		echo "-------------------------------------------------"
		echo "Beginning Hybrid"
		python3 PPO/PPO.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "${words[0]} is completed now saving Memory Model"
		sleep 1s
		echo "Parsing memory model into ${words[1]}"
		echo "-------------------------------------------------"
		python3 OPG/OPG.py ${words[2]} 1,000,000 &
		echo "-------------------------------------------------"
		echo "HOOPA: ${words[0]} & ${words[1]} memory data now is now saved"
		echo "-------------------------------------------------"
		
	fi


	
	#python3 run_main.py -alg ${words[1]} -env ${words[2]} -eps 3
	#Running the python script
	#hard code the link 


	

	#python3 run_main.py -alg DQN -env Pong-v0 -eps 3
	#python3 run_main.py -alg DQN -env SpaceInvaders-v0 -eps 3
	#python3 run_main.py -alg DoubleDQN -env Pong-v0 -eps 3
	#python3 run_main.py -alg DoubleDQN -env SpaceInvaders-v0 -eps 3


# checking if the entire file has been readb
done < "$1"


#Run the bash file ./NAME_OF_BASH_FILE
#if you cant run this just go chmod +x the_file_name
