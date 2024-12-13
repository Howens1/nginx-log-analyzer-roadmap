#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi 

LOG_FILE="$1"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: Log file $LOG_FILE does not exist"
    exit 1
fi

print_section_header() {
    echo ""
    echo "$1:"
}

print_section_header "Top 5 IP addresses with the most requests."
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5 | awk '{print $2 " - " $1 " requests"}'

print_section_header "Top 5 most requested paths."
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5 | awk '{print $2 " - " $1 " requests"}'

print_section_header "Top 5 response codes."
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5 | awk '{print $2 " - " $1 " requests"}'

print_section_header "Top 5 User agents."
awk '{print $12}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5 | awk '{print $2 " - " $1 " requests"}'