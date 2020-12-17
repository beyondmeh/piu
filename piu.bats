#!/usr/bin/env bats

FUNC_NAMES="search remove purge list list_files install update num_updates \
num_pkgs repo_update manual"

# brew stub
function brew () { echo $@; }

# uname stub
function uname () { echo "Darwin"; }

load ./piu

setup() {
  export -f brew
  export -f uname
}

@test "[UTIL] 'not_implemented' shows error message and exits" {

  # TODO: Test the exit code. Will require integration of the bats-support and
  # bats-assert libraries

  we_did_not_implement_this() {
    not_implemented;
  }

  run we_did_not_implement_this

  [ "$output" == "'we_did_not_implement_this' not implemented yet!" ]
}


# Brew
########################################################################

@test "[BREW] implements the interface" {

 for func in ${FUNC_NAMES[@]};
 do
  declare -f -F "brew_$func";

  [ "$?" == "0" ];
 done
}

@test "[BREW] proxies the 'cask' argument to brew" {

  run ./piu install aPackage
  [ "$output" == "install aPackage" ]

  run ./piu cask install aPackage
  [ "$output" == "cask install aPackage" ]

  run ./piu install --cask aPackage
  [ "$output" == "install --cask aPackage" ]
}

# Apt
########################################################################

@test "[APT] implements the interface" {

 for func in ${FUNC_NAMES[@]};
 do
  declare -f -F "apt_$func";

  [ "$?" == "0" ];
 done
}

teardown() {
  unset -f brew
  unset -f uname
}
