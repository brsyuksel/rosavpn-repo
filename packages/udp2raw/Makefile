VERSION =
ARCH = 

ifeq ($(VERSION),)
    $(error VERSION is required.)
endif

ifeq ($(ARCH),)
    $(error ARCH is required.)
endif

TARBALL_NAME=udp2raw-$(ARCH).tar.gz

get_binaries:
	@wget https://github.com/wangyu-/udp2raw/releases/download/$(VERSION)/udp2raw_binaries.tar.gz
	@tar -xvzf udp2raw_binaries.tar.gz

run_test:
	@./udp2raw_amd64 -h

dist:
	@mkdir -v dist
	@cp -v udp2raw_amd64 dist/udp2raw
	@echo $(VERSION) >> dist/version
	@tar -czvf $(TARBALL_NAME) -C dist .

clean:
	@rm -Rfv dist
	@rm -Rfv udp2raw_binaries.tar.gz
	@rm -Rfv udp2raw_*
	@rm -Rfv version.txt

test: get_binaries run_test clean
package: get_binaries dist clean
