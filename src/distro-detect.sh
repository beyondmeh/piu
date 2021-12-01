# Find the current distribution
if [ -f /etc/os-release ]; then
	if grep -q arch /etc/os-release; then
		PKGMAN='pacman'
	elif [[ -f /etc/debian_version ]]; then
		PKGMAN='apt'
	elif grep -q void /etc/os-release; then
		PKGMAN='xbps'
	elif grep -q alpine /etc/os-release; then
		PKGMAN='apk'
	elif grep -q fedora /etc/os-release; then
		PKGMAN='dnf'
	elif grep -q openSUSE /etc/os-release; then
		# openSUSE supports dnf, but the default is zypper
		if hash dnf 2>/dev/null; then
			PKGMAN='dnf'
		else
			PKGMAN='zypper'
		fi
	else
		echo "ERROR: I currently don't have support for your distro"
		exit 1
	fi

	action=$(echo "$1" | sed 's/^-*//g' --)
else
	if uname -a | grep Darwin > /dev/null; then
		PKGMAN='brew'
		if [ "$1" == "cask" ]; then
			BREW_CASK="cask"
   			shift 1
  		fi
		# make leading dashes optional, out of tradition
  		action=$(echo "$1" | sed 's/^-*//g')
	else
		echo "Error: cannot detect platform"
		exit 1
	fi
fi
