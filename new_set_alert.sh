#!/bin/bash

# TODO
# Send email even if there are no sets. May turn this off later, but confirmation for now would be good.
# Change pull to fetch and test.


# Get the set directory and email address.
IFS=$'\n' read -d '' -r -a lines < constants.txt
set_dir=${lines[0]}
email=${lines[1]}

# Get the number of sets.
before_no_sets=$(ls $set_dir | wc -l)

# Fetch
cd $set_dir
git pull > /dev/null

# Get the number of sets after the fetch.
after_no_sets=$(ls $set_dir | wc -l)

# DEV: Make it think there's a new set.
# after_no_sets=$((before_no_sets+1))

# If there are more sets after the fetch email me.
if [ $after_no_sets -gt $before_no_sets ]
then
	new_set=$(ls -tr ${set_dir} | tail -n1)
	body="
$((after_no_sets-before_no_sets)) more set(s) after fetch.
The most recent is ${new_set}.
"

	mail -s "New Set! ${new_set}" $email <<< $body
fi
