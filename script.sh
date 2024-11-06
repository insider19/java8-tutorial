#!/bin/bash

# Initial data the output of command 'sudo du -sk  /*'
#          8       /Docker
#          0       /bin
#          4       /boot
#          0       /dev
#          4124    /etc
#          152     /home
#          2080    /init
#          0       /lib
#          16      /lost+found
#          4       /media
#          0       /proc
#          1372    /run
#          0       /sys


# Get the output of the 'sudo du -sk /*' command
du_output=$(sudo du -sk /*)

# Parse the output into an array, splitting by newlines
IFS='\n' read -ra directories <<< "$du_output"

# Sort the directories by size in descending order
sorted_directories=($(for directory in "${directories[@]}"; do
    size=$(echo "$directory" | awk '{print $1}')
    echo "$size $directory"
done | sort -nr))

# Extract the top three largest directories and their sizes
top3_directories=()
top3_sizes=()
for i in {0..2}; do
    directory_and_size=(${sorted_directories[$i]})
    top3_directories+=("${directory_and_size[1]}")
    top3_sizes+=("${directory_and_size[0]}")
done

# Print the top three directories in a formatted table
printf "%s %s %s\n" "${top3_directories[@]}" 
printf "%s %s %s" "${top3_sizes[@]}"
