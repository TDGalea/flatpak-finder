#!/bin/bash

# Figure out what we're doing by how we were called. This script should be symlinked/renamed to "fpr" to run, "fpo" to override.
case $0 in
	*fpr*) mode=run;;
	*fpo*) mode=override;;
	    *) printf 'Unrecognised call name! Symlink this script as "fpr" and/or "fpo" for run/override respectively, then run via those symlinks.\n' >&2 && exit 1;;
esac

# No app specified.
[[ -z $1 ]]&& printf "Specify an app to $mode.\n" >&2 && exit 2

# Search for the specified flatpak and ensure we have only one result.
found="$(flatpak list | sed "s/\t/\n/g" | grep \.$1)"
count="$(echo "$found" | wc -w)"
[[ $count -lt 1 ]] && printf "No results found. Check spelling and case, and remember we're looking for the \e[1mApplication ID\e[0m, not the \e[1mName\e[0m.\n" >&2 && exit 1
[[ $count -gt 1 ]] && printf "Too many results found. Please be a bit more specific:\n" >&2 && printf "$found\n" >&2 && exit 2
shift
printf "Found '$found'"

# Complain if overriding and no instructions provided.
[[ "$mode" == "override" ]] && [[ -z "$@" ]] && printf " - what do you want to do with it?\n" && exit 2

# Run or override the found flatpak.
printf ".\n"
flatpak $mode "$found" $@
exit $?