#!/bin/bash

# Check if the directory is provided as an argument
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <directory> <output_file>"
    exit 1
fi

input_dir="$1"
output_file="$2"

# Clear the output file if it already exists
> "$output_file"

# Loop through each CSV file in the specified directory
for csv_file in "$input_dir"/*.csv; do
    # Check if the file exists
    if [ -f "$csv_file" ]; then
	skip_first_line=true
        {
            read # This reads the first line and discards it
            while IFS=',' read -r overlay _ _ _ channel _ _ _ rate _ _ _ loss; do
                # Build the string using the extracted variables
		if $skip_first_line; then
			skip_first_line=false
			continue
		fi
                result="$overlay overlays $channel in and $channel out channel, with channel rate ${rate}mbps and added loss ${loss}%"
                
                # Append the result to the output file
                echo "$result" >> "$output_file"
            done < <(tr -d '\r' < "$csv_file")
        } < <(tr -d '\r' < "$csv_file")
    else
        echo "No CSV files found in the directory."
    fi
done

echo "Processing complete! Results saved to $output_file."
