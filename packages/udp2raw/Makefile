VERSION =
ARCH = 

ifeq ($(VERSION),)
    $(error VERSION is required.)
endif

ifeq ($(ARCH),)
    $(error ARCH is required.)
endif

PACKAGE_NAME=udp2raw-$(ARCH)
TARBALL_NAME=$(PACKAGE_NAME).tar.gz

ifeq ($(ARCH), amd64)
	SOURCE_BINARY=udp2raw_amd64
else ifeq ($(ARCH), arm64)
	SOURCE_BINARY=udp2raw_arm
endif

get_binaries:
	@wget https://github.com/wangyu-/udp2raw/releases/download/$(VERSION)/udp2raw_binaries.tar.gz
	@tar -xvzf udp2raw_binaries.tar.gz

run_test:
	@./$(SOURCE_BINARY) -h

dist:
	@mkdir -pv dist
	@cp -v $(SOURCE_BINARY) dist/udp2raw
	@echo $(VERSION) >> dist/version
	@tar -czvf $(TARBALL_NAME) -C dist .

	@TARBALL_SUM=$$(sha256sum $(TARBALL_NAME) | awk '{print $$1}'); \
	UDP2RAW_BIN_SHA256=$$(sha256sum dist/udp2raw | awk '{print $$1}'); \
	printf '{"name": "udp2raw", "archive_file": "$(TARBALL_NAME)", "archive_sum": "%s", "version": "$(VERSION)", "arch": "$(ARCH)", "file_sums": {"udp2raw": "%s"}}\n' \
	"$$TARBALL_SUM" "$$UDP2RAW_BIN_SHA256" > $(PACKAGE_NAME).metadata.json

clean:
	@rm -Rfv dist
	@rm -Rfv udp2raw_binaries.tar.gz
	@rm -Rfv udp2raw_*
	@rm -Rfv version.txt

test: get_binaries run_test clean
package: get_binaries dist clean

.PHONY: dist
