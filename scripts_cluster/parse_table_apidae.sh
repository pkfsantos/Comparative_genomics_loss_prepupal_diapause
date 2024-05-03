#!/bin/bash

# Input file name
input_file="Base_count_all_Apidae.txt"

# Output file names
expanded_output="expanded_count_apidae.csv"
contracted_output="contracted_count_apidae.csv"

# Filter rows where at least 3 columns out of 4 are <= 0 (columns 2 to 5)
# and at least 6 columns out of 8 are > 0 (columns 6 to 13)
awk -F'\t' 'NR==1; NR>1{
    count1=0; count2=0;
    for (i=2; i<=5; i++) {
        if ($i <= 0) count1++;
    }
    for (i=6; i<=13; i++) {
        if ($i > 0) count2++;
    }
    if (count1 >= 3 && count2 >= 6) print
}' "$input_file" > "$expanded_output"

# Filter rows where at least 3 columns out of 4 are > 0 (columns 2 to 5)
# and at least 6 columns out of 8 are <= 0 (columns 5 to 13)
awk -F'\t' 'NR==1; NR>1{
    count1=0; count2=0;
    for (i=2; i<=5; i++) {
        if ($i > 0) count1++;
    }
    for (i=6; i<=13; i++) {
        if ($i <= 0) count2++;
    }
    if (count1 >= 3 && count2 >= 6) print
}' "$input_file" > "$contracted_output"

