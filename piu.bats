#!/usr/bin/env bats

# brew stub
function brew () { echo $@; }
function uname () { echo "Darwin"; }

load ./piu

setup() {
  export -f brew
  export -f uname
}

@test "[OSX] proxies the 'cask' argument to brew" {

	run ./piu install aPackage
	[ "$output" == "install aPackage" ]

	run ./piu cask install aPackage
	[ "$output" == "cask install aPackage" ]
}

teardown() {
  unset -f brew
  unset -f uname
}
