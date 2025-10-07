VERSION =
ARCH = 

ifeq ($(VERSION),)
	$(error VERSION is required.)
endif

ifeq ($(ARCH),)
	$(error ARCH is required.)
endif

PACKAGE_NAME=dnsmasq-$(ARCH)
TARBALL_NAME=$(PACKAGE_NAME).tar.gz

get_source:
	@git clone git://thekelleys.org.uk/dnsmasq.git
	@cd dnsmasq && git checkout $(VERSION)

dependencies:
	@sudo apt update
	@sudo apt install -y build-essential

compile:
	make -C dnsmasq all CFLAGS="-Wall -W -O3" LDFLAGS="-static"

run_test:
	cd dnsmasq && ./src/dnsmasq --help

dist:
	@mkdir -pv dist
	@cp -v dnsmasq.conf dist/dnsmasq.conf
	@cp -v dnsmasq/src/dnsmasq dist/dnsmasq
	@echo $(VERSION) >> dist/version
	@tar -czvf $(TARBALL_NAME) -C dist .

	@TARBALL_SUM=$$(sha256sum $(TARBALL_NAME) | awk '{print $$1}'); \
	DNSMASQ_BIN_SHA256=$$(sha256sum dist/dnsmasq | awk '{print $$1}'); \
	DNSMASQ_CONF_SHA256=$$(sha256sum dist/dnsmasq.conf | awk '{print $$1}'); \
	printf '{"name": "dnsmasq", "archive_file": "$(TARBALL_NAME)", "archive_sum": "%s", "version": "$(VERSION)", "arch": "$(ARCH)", "file_sums": {"dnsmasq": "%s", "dnsmasq.conf": "%s"}}\n' \
	"$$TARBALL_SUM" "$$DNSMASQ_BIN_SHA256" "$$DNSMASQ_CONF_SHA256" > $(PACKAGE_NAME).metadata.json

clean:
	@rm -Rfv dnsmasq
	@rm -Rfv dist

test: get_source dependencies compile run_test clean
package: get_source dependencies compile dist clean

.PHONY: dist
