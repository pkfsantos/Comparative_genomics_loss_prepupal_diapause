#!/bin/bash

# Check if a folder path is provided as a command-line argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <folder_path>"
    exit 1
fi

folder_path="$1"

# Print header for the output table
echo -e "File\tColumn13_Info"

# Loop through each TSV file in the folder
for file in "$folder_path"/*.tsv; do
    # Extract file name without extension
    file_name=$(basename "$file" .tsv)

    # Extract information from column 13 and print lines in the output table
    awk -v file_name="$file_name" -F'\t' '{print file_name "\t" $13}' "$file"
done

