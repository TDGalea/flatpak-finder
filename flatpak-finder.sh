#!/bin/bash

# Figure out what we're doing by how we were called. This script should be symlinked/renamed to "fpr" to run, "fpo" to override.
case $0 in
	*fpr*) mode=run;;
	*fpo*) mode=override;;
	    *) printf 'Unrecognised call name! Symlink this script as "fpr" and/or "fpo" for run/override respectively, then run via those symlinks.\n' >&2 && exit 1;;
esac

# No app specified.
[[ -z $1 ]]&& printf "Specify an app to $mode.\n" >&2 && exit 2

# Put the search string in $search, put the rest of the arguments in $args.
search=$1
shift
args="$@"

# Generate a list of all Flatpaks found by the given string, and then check how many results we have.
list="$(flatpak list | sed "s/\t/THIS_IS_A_TAB/g" | grep $search)"
count="$(printf "$list\n" | wc -l)"

# Make sure we have only one result.
[[ $count -gt 1 ]] && printf "Too many results found. Please be a bit more specific:\n" >&2 && printf "$list\n" | sed "s/THIS_IS_A_TAB/\t/g" | column -t >&2 && exit 2

# Annoyingly, WC is resulting in 1 even if we got ZERO results. So let's just try and fill appID and check that instead.
appID="$(echo $list | sed "s/THIS_IS_A_TAB/\n/g" | tail -4 | head -1)"

# Do we actually have an appID?
[[ "$appID" == "" ]] && printf "No results found. Please check spelling and case.\n" >&2 && exit 2
printf "Found '$appID'"

# Complain if overriding and no instructions provided.
[[ "$mode" == "override" ]] && [[ -z "$args" ]] && printf " - what do you want to do with it?\n" && exit 2

# Run or override the found flatpak.
printf ".\n"
flatpak $mode "$appID" $@
exit $?
