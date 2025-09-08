#!/bin/bash
input="${1%.ly}"
lilypond --svg -dcrop -dmidi-extension=mid "$input.ly" &&
mv "$input.cropped.svg" "$input.svg" &&
rsvg-convert -b white -f svg -o "$input.svg" "$input.svg" &&
fluidsynth -ni ../FluidR3_GM.sf2 -F "$input.wav" "$input.mid" &&
ffmpeg -y -i "$input.wav" -c:a libopus "$input.webm" &&
rm "$input.wav" &&
ly musicxml "$input.ly" > "$input.musicxml"
