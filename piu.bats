#!/usr/bin/env bats

# brew stub
function brew () { echo $@; }
function uname () { echo "Darwin"; }

load ./piu

setup() {
  export -f brew
  export -f uname
}

@test "'not_implemented' shows error message and exits" {

  # TODO: Test the exit code. Will require integration of the bats-support and
  # bats-assert libraries

  we_did_not_implement_this() {
    not_implemented;
  }

  run we_did_not_implement_this

	[ "$output" == "'we_did_not_implement_this' not implemented yet!" ]
}

@test "[OSX] proxies the 'cask' argument to brew" {

	run ./piu install aPackage
	[ "$output" == "install aPackage" ]

	run ./piu cask install aPackage
	[ "$output" == "cask install aPackage" ]

	run ./piu install --cask aPackage
	[ "$output" == "install --cask aPackage" ]
}

@test "[OSX] implements the manual command" {

	run ./piu manual aPackage
	[ "$output" == "'brew_manual' not implemented yet!" ]
}

teardown() {
  unset -f brew
  unset -f uname
}
