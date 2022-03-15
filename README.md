# Qutebrowser Bitwarden rbw Userscript

## Requirements
1. [rbw](https://github.com/doy/rbw)
2. [dmenu](https://tools.suckless.org/dmenu/)

This has been tested on Arch Linux.

## To use:
1. [Place in your userscripts folder](https://qutebrowser.org/doc/userscripts.html)
2. Bind a key to `spawn --userscript get_rbw_pass.sh`

When run, the password for the current url will be copied to clipboard, and then cleared or replaced with the TOTP after 4 seconds. If there are multiple options, a dmenu will appear in order to select the one you want.

It's a very simple script just read it!


