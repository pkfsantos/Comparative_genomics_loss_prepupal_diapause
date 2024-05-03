#!/bin/bash

# Input file name
input_file="Base_count_all_Halictidae.txt"

# Output file names
expanded_output="expanded_count_halictidae.csv"
contracted_output="contracted_count_halictidae.csv"

# Filter rows where at least 2 columns out of 2 are <= 0 (columns 2 to 3)
# and at least 4 columns out of 6 are > 0 (columns 4 to 8)
awk -F'\t' 'NR==1; NR>1{
    count1=0; count2=0;
    for (i=2; i<=3; i++) {
        if ($i <= 0) count1++;
    }
    for (i=4; i<=8; i++) {
        if ($i > 0) count2++;
    }
    if (count1 >= 2 && count2 >= 4) print
}' "$input_file" > "$expanded_output"

# Filter rows where at least 2 columns out of 2 are > 0 (columns 2 to 3)
# and at least 4 columns out of 6 are <= 0 (columns 4 to 8)
awk -F'\t' 'NR==1; NR>1{
    count1=0; count2=0;
    for (i=2; i<=3; i++) {
        if ($i > 0) count1++;
    }
    for (i=4; i<=8; i++) {
        if ($i <= 0) count2++;
    }
    if (count1 >= 2 && count2 >= 4) print
}' "$input_file" > "$contracted_output"

