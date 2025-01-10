#!/bin/bash
# Script to create several files and folders in the current file system.

# number of folders to create
TOTAL_FOLDERS=1200

# creates the base dir if it does not exist
BASE_DIR="$HOME/assign6_output"
mkdir -p "$BASE_DIR"
rm -rf "${BASE_DIR:?}/*"

# creates a file with server and user info
echo "Host: $(hostname)" >"$BASE_DIR/about.txt"
echo "User: $(whoami)" >>"$BASE_DIR/about.txt"
echo "Start: $(date)" >>"$BASE_DIR/about.txt"

# function to display a progress bar
show_pbar() {
  local progress=$1
  local total=$2
  local width=50 # width of the progress bar

  # percentage and number of characters in the progress bar
  local percent=$((progress * 100 / total))
  local completed=$((percent * width / 100))
  local remaining=$((width - completed))

  # displays the progress bar
  printf "\rGenerating data: ["
  printf "█%.0s" $(seq 0 $completed)
  printf ".%.0s" $(seq 0 $remaining)
  printf "] %d%%" "$percent"
}

# loop to create folders and files, showing progress
for i in $(seq 1 $TOTAL_FOLDERS); do
  # creates a folder with a unique name
  FOLDER_NAME="$BASE_DIR/folder_$(printf "%05d" "$i")"
  mkdir -p "$FOLDER_NAME"

  # generates random numbers for two files
  FILE1_RANDOM_NUM=$((RANDOM % 10000))
  FILE2_RANDOM_NUM=$((RANDOM % 10000))

  # creates two files with random numbers
  echo $FILE1_RANDOM_NUM >"$FOLDER_NAME/file_${FILE1_RANDOM_NUM}.txt"
  echo $FILE2_RANDOM_NUM >"$FOLDER_NAME/file_${FILE2_RANDOM_NUM}.txt"

  # Update the progress bar
  show_pbar "$i" "$TOTAL_FOLDERS"
  sleep 0.01
done

# completes the progress bar and prints end of program
show_pbar "$TOTAL_FOLDERS" "$TOTAL_FOLDERS"
echo -e "\nData generated at $BASE_DIR."
echo -e "*** End of program ***"
echo "End: $(date)" >>"$BASE_DIR/about.txt"
