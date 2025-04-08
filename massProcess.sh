#!/bin/bash

# Define directories
data_dir="./data"
results_dir="./results"
script="./brainageR"

# Check if brainageR exists and is executable
if [[ ! -x "$script" ]]; then
    echo "Error: brainageR script not found or not executable."
    exit 1
fi

# Process each .nii file in the data directory
for file in "$data_dir"/*.nii; do
    # Check if there are any .nii files
    if [[ ! -e "$file" ]]; then
        echo "No .nii files found in $data_dir."
        exit 1
    fi
    
    # Extract filename without extension
    filename=$(basename -- "$file")
    filename_noext="${filename%.nii}"
    
    # Define output file path
    output_file="$results_dir/${filename_noext}_results.csv"
    
    # Run brainageR
    "$script" -f "$file" -o "$output_file"
    
    echo "Processed: $file -> $output_file"
done

echo "All .nii files processed successfully."
