#!/bin/bash

# TODO
# Change pull to fetch and test.

# Get the set directory and email address from constants.txt. Example content of constants.txt:
#     /path/to/repo/Star-Wars-LCG-OCTGN/o8g/Sets
#     user@email.com

IFS=$'\n' read -d '' -r -a lines < constants.txt
set_dir=${lines[0]}
email=${lines[1]}

# Get the number of sets. tr command strips whitespace.
before_no_sets=$(ls $set_dir | wc -l | tr -d '[[:space:]]')

# Fetch
cd $set_dir
git pull > /dev/null

# Get the number of sets after the fetch.
after_no_sets=$(ls $set_dir | wc -l | tr -d '[[:space:]]')

# DEV: Uncomment to make it think there's a new set.
# after_no_sets=$((before_no_sets+1))

# If there are more sets after the fetch email me.
if [ $after_no_sets -gt $before_no_sets ]
then
	new_set=$(ls -tr ${set_dir} | tail -n1)
	body="
$((after_no_sets-before_no_sets)) more set(s) after fetch.
Most recent: ${new_set}
"
	mail -s "New Set! ${new_set}" $email <<< $body
else
	mail -s "No new sets" $email <<< "Still ${after_no_sets}."

fi
