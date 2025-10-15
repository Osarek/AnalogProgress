#!/bin/bash

# Set source directory
SRC_DIR="resources/drawables/images"
SUB_DIR="drawables/images"
PATTERNS=("hour_*.png" "minute_*.png")

# Loop through each destination folder
for dest_folder in resources-*; do
    [[ -d "$dest_folder" ]] || continue

    # Extract dimension string (e.g., 260x260 or 320x360)
    dimension=$(echo "$dest_folder" | grep -oE '[0-9]+x[0-9]+')

    # Extract width only and use it for both width and height
    width=$(echo "$dimension" | cut -d'x' -f1)
    RESIZE_DIM="${width}x${width}"

    DEST_PATH="$dest_folder/$SUB_DIR"
    mkdir -p "$DEST_PATH"

    # Copy and resize images
    for pattern in "${PATTERNS[@]}"; do
        for src_file in "$SRC_DIR"/$pattern; do
            [[ -e "$src_file" ]] || continue
            filename=$(basename "$src_file")
            convert "$src_file" -resize "$RESIZE_DIM" "$DEST_PATH/$filename"
            echo "✔ Resized $filename → $RESIZE_DIM in $DEST_PATH"
        done
    done
done

echo "✅ All images processed."
