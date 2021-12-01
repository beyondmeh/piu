#!/bin/bash

#Cross-platform package manager wrapper
#https://github.com/keithieopia/piu
#Copyright (c) 2017-2021 Timothy Keith
#Licensed under the ISC license.

__piutmp() {
	# Piu Temp Directory Manager
	case ${1} in
		[sS][tT][aA][rR][tT])
			[[ -d "/tmp/${0}" ]] || mkdir -p "/tmp/${0}" 2> /dev/null 
		;;
		[sS][tT][oO][pP])
			[[ -d "/tmp/${0}" ]] && rm -rf "/tmp/${0}" 2> /dev/null
		;;
		[rR][eE][sS][tT][aA][rR][tT])
			[[ -d "/tmp/${0}" ]] && { rm -rf "/tmp/${0}" 2> /dev/null && mkdir -p "/tmp/${0}" 2> /dev/null ; } 
		;;
	esac
}

__piuplm () {
	# Piu PID Lock Manager
	case ${1} in
		[sS][tT][aA][rR][tT])
			__piutmp start
			echo "piu_pid='${BASHPID}'" > "/tmp/${0}/piu.pid"
		;;
		[sS][tT][oO][pP])
			__piutmp stop
		;;
		[rR][eE][sS][tT][aA][rR][tT])
			__piutmp restart
		;;
	esac
}

bye() {
	__piuplm stop
	exit
}

if [[ -f "/tmp/${0}/piu.pid" ]] ; then
	. "/tmp/${0}/piu.pid"
	echo -e "$(basename ${0}) says: i'm already running on another proccess (${piu_pid}).\nIf you think this is a mistake you can delete my lock file:\n/tmp/${0}/piu.pid"
	exit 1
else
	__piuplm start
fi

trap bye INT

UPDATE_AFTER=43200 # 12 hours

usage() {
cat <<HELP
Cross-platform package manager wrapper

usage: $(basename "$0") OPTION [--cask] [PACKAGE]

   SINGLE PACKAGE ACTIONS
   (i)nstall : install a given package
   (r)emove  : remove a given package
   (p)urge   : remove a given package and any related config files
   (s)earch  : search for a package
   (m)anual  : install a locally downloaded package (e.g.: a .deb file)
   (f)iles   : list files provided by a given package

   UPDATING
   (u)pdate  : update all installed packages
   (c)ache   : update the package cache / repository

               NOTE: update, install, and num-updates will automatically
               update the cache if it is old

   MISC
   (l)ist            : list installed packages
   (nu) num-updates  : number of packages with updates
   (np) num-packages : number of installed packages

https://github.com/keithieopia/piu

Copyright (c) 2017-2021 Timothy Keith
Licensed under the ISC license.
HELP
}

# Utils
########################################################################
not_implemented() { echo "'${FUNCNAME[1]}' not implemented yet!" && exit 1; }

# Abstraction
########################################################################
repo_update_if_needed() {
	CURRENT_TIME=$(date '+%s')
	LAST_UPDATE=$(eval "${PKGMAN}"_repo_age)

	if ((CURRENT_TIME-LAST_UPDATE > UPDATE_AFTER)); then
		eval "${PKGMAN}"_repo_update
	fi
}

# INSERT PKGMAN
# INSERT DISTRO-DETECT


# find what we're doing
########################################################################

case "$action" in
# search
	[sS]|[sS][eE][aA][rR][cC][hH])
		shift 1
		eval ${PKGMAN}_search "$@"
		bye
	;;
# remove
	[rR]|[rR][eE][mM][oO][vV][eE])
		shift 1
		eval ${PKGMAN}_remove "$@"
		bye
	;;
# purge
	[pP]|[pP][uU][rR][gG][eE])
		shift 1
		eval ${PKGMAN}_purge "$@"
		bye
	;;
# list
	[lL]|[lL][iI][sS][tT])
		eval ${PKGMAN}_list
		bye
	;;
# list files
	[fF]|[fF][iI][lL][eE][sS])
		shift 1
		eval ${PKGMAN}_list_files "$@"
		bye
	;;
# install
	[iI]|[iI][nN][sS][tT][aA][lL][lL])
		shift 1
		repo_update_if_needed
		eval ${PKGMAN}_install "$@"
		bye
	;;
# update
	[uU]|[uU][pP][dD][aA][tT][eE])
		repo_update_if_needed
		eval ${PKGMAN}_update
		bye
	;;
# num updates
	[nN][uU]|[nN][uU][mM]-[uU][pP][dD][aA][tT][eE][sS])
		eval ${PKGMAN}_num_updates
		bye
	;;
# num packages
	[nN][pP]|[nN][uU][mM]-[pP][aA][cC][kK][aA][gG][eE][sS])
		eval ${PKGMAN}_num_pkgs
		bye
	;;
# cache
	[cC]|[cC][aA][cC][hH][eE])
		eval ${PKGMAN}_repo_update
		bye
	;;
# manual
	[mM]|[mM][aA][nN][uU][aA][lL])
		shift 1
		eval ${PKGMAN}_manual "$@"
		bye
	;;

	*)
		usage
		bye
	;;
esac
