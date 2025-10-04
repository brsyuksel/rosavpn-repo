# rosavpn-repo

serves as a couple of pipeline for testing and releasing statically compiled variations within a date based tags. 

see releases and binaries: [releases](https://github.com/brsyuksel/rosavpn-repo/releases)

## development

### requirements

ubuntu:
```
sudo apt install -y build-essentail
```

install act: [act repository](https://github.com/nektos/act)

### events

trigger the release workflow by `act push`, for pr workflow run `act pull_request`
