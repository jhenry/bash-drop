# Bash Drop

A bash script to provide dropbox-like functionality with your own url.  Many screenshot tools do not provide syncing via SFTP, or if they do the implementation often doesn't quite work.  

The script monitors a directory a directory for changes.  When a file is added to that folder it uploads the file to the site specified in config.txt, and puts the URL on the clipboard.  

This way, you can configure your screenshot tool so that a keystroke can be used to save the image to this directory, and you'll get a working url to paste into email, slack, etc.

## Install

Since there doesn't appear to be a ``watch`` or ``inotifywatch`` equivelant utility by default on MacOS, this tool uses [fswatch](https://github.com/emcrisostomo/fswatch) for directory monitoring.  

You will also need to provide bash with Full Disk Access, since the script is managed by launchctl, and not launched directly by the user.

``installer.sh`` creates the LaunchAgent plist and loads the script into the launchctl/launchd service manager.  This allows the script to start at login.

1. Install [fswatch](https://github.com/emcrisostomo/fswatch), i.e. ``brew install fswatch``
1. [Enable Full Disk Access for bash](https://apple.stackexchange.com/a/384314/409253).
1. Download or clone this repository to a location in your home directory (i.e. /Users/jdoe/bin, or /Users/jdoe/Library/Scripts). i.e. ``cd /Users/jdoe/bin`` followed by ``wget https://github.com/jhenry/bash-drop/archive/master.zip`` 
1. Set permissions on the scripts to be executable, i.e. ``chmod 755 bash-drop.sh install.sh``
1. Copy/rename ``config.txt.sample`` to ``config.txt``, and edit the information there as appropriate.
1. Run the installer, i.e. ``cd cd /Users/jdoe/bin/bash-drop``, then ``./installer.sh``  


