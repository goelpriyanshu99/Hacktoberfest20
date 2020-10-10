#!/bin/bash

# this bash script is for simplifying the interface for GuessWord game.
# please run 'bash start-game.sh' for starting the script
echo "Please Wait..The Game Will Start Shortly"

cd src_files       # navigating to source files
pip install -r requirements.txt # installing python dependencies
python guessword_full.py   #executing python game script
