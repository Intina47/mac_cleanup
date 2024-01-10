#!/bin/bash

# Set the search path to the user's desktop directory
search_path="$HOME/desktop"

loading_animation(){
	local pid = $1
	local spin = '-\|/'
	local i=0
	while kill -0 "$pid" 2>/dev/null; do
		i=$(((i+1)%4))
		printf "\rDeleting node_modules... [%c]" "${spin:$i:1}"
		sleep 0.1
	done
	printf "\rDeleting node_modules... [Done]     \n"
	}

# Find and remove all node_modules directories within the specified path
find "$search_path" -name "node_modules" -type d -print0 | 
	while IFS= read -r -d '' dir; do
		echo "Deleting node_modules in $dir..."
		(rm -rf "$dir") &
		loading_animation $!
		echo "Node_mosules deleted in $dir"
	done

echo "Node modules cleanup complete!"

