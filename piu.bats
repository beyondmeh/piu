#!/usr/bin/env bats

# brew stub
function brew () { echo $@; }

load ./piu

setup() {
  export -f brew
}

@test "pacman_extract_date_from_log_line works on 'Linux 5.4.17-1-MANJARO'" {

	log_line="[2020-02-06T21:24:46+0000] [PACMAN] synchronizing package lists"

	date_string=`pacman_extract_date_from_log_line "$log_line"`

	[ "$date_string" == "1581024286" ]
}

@test "pacman_extract_date_from_log_line works on 'Linux 5.2.11-arch1-ARCH'" {

	log_line="[2020-02-06 21:24] [PACMAN] synchronizing package lists"

	date_string=`pacman_extract_date_from_log_line "$log_line"`

	[ "$date_string" == "1581024240" ]
}

@test "[OSX] proxies the 'cask' argument to brew" {

	run ./piu install aPackage
	[ "$output" == "install aPackage" ]

	run ./piu cask install aPackage
	[ "$output" == "cask install aPackage" ]
}

teardown() {
  unset -f brew
}
