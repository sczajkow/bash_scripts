#!/bin/bash

# Loop through each CSV file
for file in *.csv; do
    # Update the filename by replacing "one" with "four" Kind of link a sed command takes the file and replaces the word one in the file name with four. 
    new_file="${file/one/eight}"

    # Change 'overlay' column (first column) to 4 in the CSV file
    awk -F, 'BEGIN {OFS=","} 
    NR==1 {print $0; next}  # Print the header, checks to see if we are the first line, and if so prints the header and skips to the next line
    { $1=8; print $0 }      # Change the first column to 4 for all subsequent rows' "$file" > "tmp_$new_file"
    
    # Rename the temporary file to the new filename
    mv "tmp_$new_file" "$new_file" # Moves the file from the old file to the new file, over wrights the existing file with the new file with new data. 
done


#Information
#This file will take a directory of csv files and update the first column to change the value of each line in the csv. 
#Must be run in the directory you want to make the changes in. 
#For loop looks for all the files in the directory that has the extention of csv
