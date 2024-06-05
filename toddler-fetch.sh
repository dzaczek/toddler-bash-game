#!/bin/bash

# Ensure required commands are installed
for cmd in mpg123 jq grep md5sum; do
    if ! command -v $cmd &> /dev/null; then
        echo "$cmd could not be found. Please install it and try again."
        exit
    fi
done

# Create cache directory if it doesn't exist
CACHE_DIR="./cache"
mkdir -p "$CACHE_DIR"

# Function to fetch pronunciation from Google Translate
fetch_pronunciation() {
    local text=$1
    local file_name=$2
    local file_path="$CACHE_DIR/$file_name.mp3"

    # Check if the file is already cached
    if [ -f "$file_path" ]; then
        echo "Playing cached pronunciation for $text"
        mpg123 "$file_path"
    else
        echo "Fetching pronunciation for $text from Google Translate"
        local encoded_text=$(echo "$text" | jq -s -R -r @uri)
        local url="https://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&q=$encoded_text&tl=pl"
        curl -s -o "$file_path" "$url"
        mpg123 "$file_path"
    fi
}

# Function to get a random phrase for a given letter
get_random_phrase() {
    local letter=$1
    local phrases=$(grep "^$letter " phrases.txt | awk '{$1=""; print $0}' | sed 's/^ //')
    local count=$(echo "$phrases" | wc -l)

    if [[ $count -gt 1 ]]; then
        # Randomly select one of the phrases
        local random_index=$(( RANDOM % count + 1 ))
        echo "$phrases" | sed -n "${random_index}p"
    elif [[ $count -eq 1 ]]; then
        echo "$phrases"
    else
        echo "$letter"
    fi
}

# Function to generate a cache file name based on the phrase
generate_cache_file_name() {
    local phrase=$1
    echo "$phrase" | md5sum | awk '{print $1}'
}

echo "Waiting for a single letter input (press 'Ctrl+C' to exit)..."

while true; do
    # Read a single character
    read -n 1 -s letter
    letter_upper=$(echo "$letter" | tr '[:lower:]' '[:upper:]')
    if [[ $letter_upper =~ [A-Z0-9] ]]; then
        echo "You pressed: $letter_upper"
        phrase=$(get_random_phrase "$letter_upper")
        if [ -z "$phrase" ]; then
            phrase="$letter_upper"
        fi
        cache_file_name=$(generate_cache_file_name "$phrase")
        fetch_pronunciation "$phrase" "$cache_file_name"
    else
        echo "Please press a valid letter key."
    fi
done

