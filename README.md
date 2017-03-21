# piuw (Platform Independant Updates Warner)

<img align="right" alt="Skunk Logo" src="https://raw.githubusercontent.com/keithieopia/piuw/master/.readme-assets/skunk-logo.png">

> Making the simple complicated is commonplace; making the complicated 
> simple, awesomely simple, that's creativity. 
>
> &mdash; Charles Mingus 

`piuw` will sync the package manager's cache and displays the number of 
updates across different Linux distributions. This makes it particularly 
useful in status bars such as [i3bar](https://i3wm.org/i3bar/), 
[lemonbar](https://github.com/LemonBoy/bar), or even [Conky](https://github.com/brndnmtthws/conky).


## Currently Supported
* [Arch Linux](https://www.archlinux.org/)
* [Void Linux](http://www.voidlinux.eu/)


## Installation
While not required, if you will be using `piuw` in a status bar script 
you should setup `sudo` to allow the package manager to sync its cache 
without prompting for a password. 

This will allow `piuw` to automatically refresh the package manager's 
cache periodically. Otherwise, `piuw` will simply state the cache is 
out-of-date.

Add the following to `/etc/sudoers`, depending on your distribution:

### pacman (Arch Linux)
```console
%wheel ALL=(ALL) NOPASSWD: pacman -Sy
```

### xbps (Void Linux)
```console
%wheel ALL=(ALL) NOPASSWD:  xbps-install -S
```

**NOTE**: updating the package cache does not install or update any 
programs. It is relatively innocuous and safe to perform automatically 
without password; most package managers need additional permissions 
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
