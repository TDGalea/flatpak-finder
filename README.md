# flatpak-finder
Super simple Bash script to save you typing out the entire application ID any time you want to use Flatpak via the commandline.

Symlink (or rename, if you're weird) the script to contain "fpr" or "fpo" (two symlinks to the same file is the idea here) so the script knows whether you're running or overriding the specified Flatpak.
For example:

```
sudo ln -s /scripts/flatpak-finder.sh /usr/bin/fpr
sudo ln -s /scripts/flatpak-finder.sh /usr/bin/fpo
```

Let's say we want to launch Minecraft Bedrock Launcher. `fpr` stands for "FlatPak Run" so that's the command we'll use.
If we find this via `flatpak list`, we see:
```
Name                          Application ID           Version   Branch    Installation
Minecraft Bedrock Launcher    io.mrarm.mcpelauncher    v1.1.1    stable    system
```

This script allows you to find the Flatpak you want by searching for any part of its line. So you could try any of the following:
```
fpr Minecraft
fpr Bedrock
fpr Bed
fpr mcpe
fpr mrarm
```
If you're extra weird, even `fpr v1.1.1` will work.
The important thing is that whatever you type must be detailed enough to find only one result. If you give it something that matches multiple Flatpaks, it'll tell you and show you the list:
```
$ fpr com.
Too many results found. Please be a bit more specific:
Moonlight                         com.moonlight_stream.Moonlight    6.0.1        stable    system                                
OBS Studio                        com.obsproject.Studio             30.2.3       stable    system           
Thincast Remote Desktop Client    com.thincast.client               1.1.560      stable    system
Bottles                           com.usebottles.bottles            51.13        stable    system                                
Steam Link                        com.valvesoftware.SteamLink       1.3.9.258    stable    system
```


In the case of wanting to override settings for a Flatpak, use `fpo` in the same manner, adding your override arguments to the end. For example:
```
fpo Minecraft --filesystem=~/Pictures
```
fpr moonlight
