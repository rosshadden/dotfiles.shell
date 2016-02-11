#!/usr/bin/env bats

testDir=/tmp/test-dotfiles

setup() {
	mkdir $testDir
	cd $testDir
	mkdir foo bar baz qux
	touch a b c d
}

teardown() {
	rm -rf $testDir
}

@test 'loops over nodes in dir' {
	run for-in 'echo foo'
	[[ ${#lines[@]} == 8 ]]
}

@test 'exposes $name' {
	run for-in 'echo $name'
	[[ ${lines[0]} == "a" ]]
	[[ ${lines[1]} == "b" ]]
}

@test 'handles pipes' {
	local blah=$(echo foo bar | for-in 'echo $name')
	local lines=( $blah )
	[[ ${#lines[@]} == 2 ]]
	[[ ${lines[0]} == "foo" ]]
	[[ ${lines[1]} == "bar" ]]
}
