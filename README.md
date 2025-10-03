# steps

- versions.csv
- workflows
- readme
- gitignore
- packages
	+ dnsmasq
	+ tor
	+ udp2raw
	+ wghttp

## package

- scripts
	- get source for given version [getsrc.sh]
	- install dependencies (debian only) [deps.sh]
	- compile as static [compile.sh]
	- tests [tests.sh]
	- ready to package [dist.sh]

## workflows

- get version for packages
- run scripts for each arch: amd64, arm64
	- get source
	- install deps
	- compile as static
	- tests
    - dist
- package it
- version and release, add assets.
- index it in gh-pages
