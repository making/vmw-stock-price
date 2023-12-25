#!/bin/bash

# Specify the path to the CSV file (e.g., data.csv)
CSV_FILE="./vmw.csv"

# Start processing from the second line of the CSV file
tail -n +2 "$CSV_FILE" | while IFS=, read -r date price open high low vol change
do
  # Change the date format from mm/dd/yyyy to yyyy/mm/dd
  year=$(echo $date | cut -d'/' -f3 | tr -d '"')
  month=$(echo $date | cut -d'/' -f1 | tr -d '"')
  day=$(echo $date | cut -d'/' -f2 | tr -d '"')
  formatted_date="${year}/${month}/${day}"
  echo $formatted_date
  # Create directories (no error if they already exist)
  mkdir -p "$formatted_date"

  # Write values to files, removing double quotes and newline characters
  echo ${price//\"/} | tr -d '\n' > "${formatted_date}/Price"
  echo ${open//\"/} | tr -d '\n' > "${formatted_date}/Open"
  echo ${high//\"/} | tr -d '\n' > "${formatted_date}/High"
  echo ${low//\"/} | tr -d '\n' > "${formatted_date}/Low"
done

