# piu (Platform Independant Updater)

<img align="right" alt="Skunk Logo" src="https://raw.githubusercontent.com/keithieopia/piuw/master/.readme-assets/skunk-logo.png">

> Making cross-platform package management stink less

`piu` is a all-in-one wrapper for different package managers. It was 
born out of frustration over constantly typing the wrong command or 
passing the wrong flags when on different Linux distros.

### Features
* `piu` works the same across distros, no more memorising each package 
  manager and its quirks
* Auto-update package repositories if they're old when installing or 
  upgrading the system (no need for additional flags).
* `sudo` automatically if additional permissions are needed. No more: 
```
E: Could not open lock file /var/lib/dpkg/lock - open (13: Permission denied)
E: Unable to lock the administration directory (/var/lib/dpkg/), are you root?
```
* Includes a built-in option to install locally downloaded packages, 
  even when the standard package manager doesn't support that; such as 
  `dpkg` vs. `apt`
* Print the number of updates available, suitable for use in a status 
  bar or shell scripts

### Less Typing
Typing `piu` is fast! It uses one hand on a standard QWERTY keyboard and 
all the letters are all on the same row. Let's compare other package 
managers:

* Update installed packages: `piu u`
  * Debian & Ubuntu: `apt update && apt upgrade` *80% reduction*  
  * Arch Linux: `pacman -Syu` *55% reduction*
  * Void Linux: `xbps-install -Su` *69% reduction*

* Install a package: `piu i foo`
  * Debian & Ubuntu: `apt install foo` *40% reduction*  
  * Arch Linux: `pacman -S foo` *31% reduction*
  * Void Linux: `xbps-install -S foo` *53% reduction*

If `piu` needs more permissions, it will automatically call `sudo`.
Since package managers typically don't do this, you'll see an even 
greater reduction if you use a standard user account for installation 
and not root.


### Currently Supported
* [Arch Linux](https://www.archlinux.org/)-based: [Manjaro](https://manjaro.org/)
* [Debian](https://www.debian.org/)-based: [Ubuntu](https://www.ubuntu.com/), [Linux Mint](https://www.linuxmint.com/), [elementary OS](https://elementary.io/), [SteamOS](http://store.steampowered.com/steamos/)
* [Void Linux](http://www.voidlinux.eu/)


## Installation
While not required, if you will be using `piu` in a status bar script 
you should setup `sudo` to allow the package manager to sync its cache 
without prompting for a password. 

This will allow `piu` to automatically refresh the package manager's 
cache periodically. Otherwise, `piu` will simply state the cache is 
out-of-date.

Add the following to `/etc/sudoers`, depending on your distribution:

### apt (Debian & Ubuntu)
```console
%wheel ALL=(ALL) NOPASSWD: /usr/bin/apt update
```

### pacman (Arch Linux)
```console
%wheel ALL=(ALL) NOPASSWD: /usr/bin/pacman -Sy
```

### xbps (Void Linux)
```console
%wheel ALL=(ALL) NOPASSWD: /usr/bin/xbps-install -S
```

**NOTE**: updating the package cache is relatively innocuous and safe to 
perform automatically without password; it does not install, update, or 
replace any programs. Most package managers need additional permissions 
simply because the cache is usually in `/var`, where most users don't 
have write permission.


## Project Icon
This project's icon is *"Pepé Le Pew"*, originally created by Chuck 
Jones and featured in several  Warner Bros. series like [Looney Toons](https://en.wikipedia.org/wiki/Looney_Tunes) 
and [Merrie Melodies](https://en.wikipedia.org/wiki/Merrie_Melodies).
episodes. 

I cropped, stylized, and optimized the logo for the web using 
[GIMP](https://www.gimp.org/) and [OptiPNG](http://optipng.sourceforge.net/). 
The logo can be located in the `.readme-assets` folder, if I have any 
rights to it, I hereby wave them and dedicate them into the public 
domain. Warner Bros. Entertainment Inc. retains the rights to the 
*Pepé Le Pew* character.

You should support Warner Bros. if you like their works.


## Feedback
I would love your feedback! If you use `piuw` in your status bar send me
[an email](mailto:timothykeith@gmail.com) with a screenshot. For the 
privacy conscious, feel free to encrypt any messages using my 
[PGP key](http://pgp.mit.edu/pks/lookup?op=vindex&fingerprint=on&search=0xF4F4A135C022EE12):

> 4135 C593 1D89 368E 7F32 C8ED F4F4 A135 C022 EE12

To import it into your keyring:
```console
$  gpg --keyserver pgp.mit.edu --recv-key 4135C5931D89368E7F32C8EDF4F4A135C022EE12
```

Submit bug reports via GitHub's [Issue Tracker](https://github.com/keithieopia/piuw/issues)


## Author
Copyright &copy; 2017 Timothy Keith, except where otherwise noted.

Licensed under the [MIT license](https://github.com/keithieopia/piuw/blob/master/LICENSE).

*This is free software: you are free to change and redistribute it. 
There is NO WARRANTY, to the extent permitted by law.*
