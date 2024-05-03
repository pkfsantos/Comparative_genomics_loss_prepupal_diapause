#!/bin/bash

# Input file name
input_file="Base_count_all.txt"

# Output file names
expanded_output="expanded_all.csv"
contracted_output="contracted_all.csv"

# Filter rows where at least 6 columns out of 9 are <= 0 (columns 2 to 11)
# and at least 12 columns out of 17 are > 0 (columns 12 to 28)
awk -F'\t' 'NR==1; NR>1{
    count1=0; count2=0;
    for (i=2; i<=11; i++) {
        if ($i <= 0) count1++;
    }
    for (i=12; i<=28; i++) {
        if ($i > 0) count2++;
    }
    if (count1 >= 6 && count2 >= 12) print
}' "$input_file" > "$expanded_output"

# Filter rows where at least 6 columns out of 9 are > 0 (columns 2 to 11)
# and at least 12 columns out of 17 are <= 0 (columns 12 to 28)
awk -F'\t' 'NR==1; NR>1{
    count1=0; count2=0;
    for (i=2; i<=11; i++) {
        if ($i > 0) count1++;
    }
    for (i=12; i<=28; i++) {
        if ($i <= 0) count2++;
    }
    if (count1 >= 6 && count2 >= 12) print
}' "$input_file" > "$contracted_output"

