#!/bin/bash

# Loop through each CSV file
for file in *.csv; do
    # Update the filename by replacing "one" with "four"
    new_file="${file/one/eight}"

    # Change 'overlay' column (first column) to 4 in the CSV file
    awk -F, 'BEGIN {OFS=","} 
    NR==1 {print $0; next}  # Print the header
    { $1=8; print $0 }      # Change the first column to 4 for all subsequent rows' "$file" > "tmp_$new_file"
    
    # Rename the temporary file to the new filename
    mv "tmp_$new_file" "$new_file"
done
