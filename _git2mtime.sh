#!/bin/bash

# this script checks the most recent git commit date for every file in
# the repo and changes it's modification date to match the date of that
# file's most recent authoring date (commit dates are more likely to be
# incorrect for our needs, so we don't use them for this purpose).

if [ -n "$1" ]
then
    scandirs="$@"
else
    scandirs="."
fi

for file in $(find $scandirs \! -type d -print)
do
    # We don't want to mess with modification times of files not
    # tracked by git.
    #
    # Conveniently enough, gitdate is the empty string for anything
    # not tracked by git. :)
    gitdate=$(git log --max-count=1 --pretty=format:%aI -- $file)

    if [ -n  "$gitdate" ]
    then
        echo $file
        stat --printf="\tBefore: %y\n" $file
        touch --date="$gitdate" "$file"
        stat --printf="\tAfter:  %y\n" $file
        echo
    fi
done
