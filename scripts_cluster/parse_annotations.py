import os
import sys

def parse_files_in_folder(folder_path):
    output_data = {}
    for filename in os.listdir(folder_path):
        if filename.endswith("_blastp_output"):
            file_id = filename.split('_')[0]  # Extracting the file ID
            unique_annotations = set()

            with open(os.path.join(folder_path, filename), 'r') as file:
                for line in file:
                    columns = line.split('\t')
                    if len(columns) >= 7:
                        gene_info = columns[6].split(' [', 1)[0].split(maxsplit=1)[-1]
                        unique_annotations.add(gene_info)

            output_data[file_id] = unique_annotations

    # Writing all unique annotations to a single output file
    output_filename = 'consolidated_unique_annotations.txt'
    with open(output_filename, 'w') as output_file:
        for file_id, annotations in output_data.items():
            output_file.write(file_id + '\t' + '\t'.join(annotations) + '\n')

    print(f"Consolidated unique annotations written to {output_filename}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script_name.py /path/to/your/folder")
    else:
        folder_path = sys.argv[1]
        parse_files_in_folder(folder_path)

