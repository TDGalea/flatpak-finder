# flatpak-finder
Super simple Bash script to save you typing out the entire application ID any time you want to use Flatpak via the commandline.

Symlink (or rename, if you're weird) the script to contain "fpr" or "fpo" (two symlinks to the same file is the idea here) so the script knows whether you're running or overriding the specified Flatpak.
For example:

```
sudo ln -s /scripts/flatpak-finder.sh /usr/bin/fpr
sudo ln -s /scripts/flatpak-finder.sh /usr/bin/fpo
```

Let's say we want to launch Moonlight. `fpr` stands for "FlatPak Run" so that's the command we'll use.
If we find this via `flatpak list`, we see:
```
Name             Application ID                    Version  Branch    Origin     Installation
Moonlight        com.moonlight_stream.Moonlight    6.1.0    stable    flathub    system
```

This script allows you to find the Flatpak you want by searching for any part of its Name or Application ID. It is _not_ case sensitive.
So you could try any of the following:
```
fpr Moonlight
fpr moon
fpr stream
fpr light
fpr mo
```

If your given name matches multiple results, the script will go interactive if it can, and allow you to select from a list of found Flatpaks.
If $TERM is "dumb" (i.e. you're calling this from outside a terminal) the script will try to send a notification to inform you that there are too many results.

For example, if I try `fpr mo`, I receive the following results in a list:
![image](https://github.com/user-attachments/assets/1350c11e-dc51-4fbd-ae6c-8e8ecc3fe166)

However if I try to do this in KRunner (or outside of a terminal in general) then I receive the following notification via notify-send:
![image](https://github.com/user-attachments/assets/fd0a41dc-9646-463b-8f74-c640d3752276)



In the case of wanting to override settings for a Flatpak, use `fpo` in the same manner, adding your override arguments to the end. For example:
```
fpo Moonlight --filesystem=~/Pictures
```
