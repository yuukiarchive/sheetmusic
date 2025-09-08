#!/bin/bash
soundfont="$HOME/Library/Audio/Sounds/Banks/FluidR3_GM.sf2"
input="${1%.ly}"

set -e

lilypond --svg -dcrop -dmidi-extension=mid "$input.ly"
mv "$input.cropped.svg" "$input.svg"

rsvg-convert -b white -f svg -o "$input.svg" "$input.svg"

fluidsynth -ni "$soundfont" "$input.mid" -F "$input.wav"

ffmpeg -y -i "$input.wav" -c:a libopus "$input.webm"

rm "$input.wav"

python3 -c 'import re, sys; print(re.search(r"\\relative.*?{.*?}", open(sys.argv[1]).read(), re.DOTALL).group(0))' "$input.ly" | ly musicxml > "$input.musicxml"
