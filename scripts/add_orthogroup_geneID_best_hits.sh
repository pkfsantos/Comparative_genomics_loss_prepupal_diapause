#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <csv_file> <search_folder> <fasta_file>"
    exit 1
fi

# Input CSV file, folder to search, and FASTA file
csv_file="$1"
search_folder="$2"
fasta_file="$3"

# Output CSV file
output_csv="output.csv"

# Create an empty output CSV file with headers
echo "queryHit,dbHit,Orthogroup,GeneID" > "$output_csv"

# Function to extract GeneID from FASTA header based on a match
extract_gene_id_from_match() {
    local term="$1"
    local fasta_file="$2"
    
    while IFS= read -r line; do
        if [[ $line =~ ^\> && $line =~ $term ]]; then
            # Extract GeneID from the matching header
            local gene_id=$(echo "$line" | grep -oP 'parent=\K[^;,]+')
            echo "$gene_id"
            return
        fi
    done < "$fasta_file"
}

# Loop through each line in the input CSV file
while IFS=',' read -r query_hit db_hit; do
    # Search for the term in all files in the specified folder
    matches=$(grep -lir "$query_hit" "$search_folder")

    # If matches are found, add them to the output CSV
    if [ -n "$matches" ]; then
        for match in $matches; do
            # Extract only the file name (excluding the folder and ".fa" extension)
            match_name=$(basename "$match" | sed 's/\.fa$//')

            # Extract GeneID from FASTA file based on the match
            gene_id=$(extract_gene_id_from_match "$db_hit" "$fasta_file")

            echo "$query_hit,$db_hit,$match_name,$gene_id" >> "$output_csv"
        done
    else
        # If no match is found, add an empty line to the output CSV
        echo "$query_hit,$db_hit,," >> "$output_csv"
    fi
done < "$csv_file"

echo "Script completed. Results saved in $output_csv"

