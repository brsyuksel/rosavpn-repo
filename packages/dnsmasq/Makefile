VERSION =
ARCH = 

ifeq ($(VERSION),)
	$(error VERSION is required.)
endif

ifeq ($(ARCH),)
	$(error ARCH is required.)
endif

TARBALL_NAME=dnsmasq-$(ARCH).tar.gz

get_source:
	@git clone git://thekelleys.org.uk/dnsmasq.git
	@cd dnsmasq && git checkout $(VERSION)

dependencies:
	@apt update
	@apt install -y build-essential

compile:
	make -C dnsmasq all CFLAGS="-Wall -W -O3" LDFLAGS="-static"

run_test:
	cd dnsmasq && ./src/dnsmasq --help

dist:
	@echo "packaging..."
	@mkdir -v dist
	@cp -v dnsmasq.conf dist/dnsmasq.conf
	@cp -v dnsmasq/src/dnsmasq dist/dnsmasq
	@echo $(VERSION) >> dist/version
	@tar -czvf $(TARBALL_NAME) -C dist .

clean:
	@rm -Rfv dnsmasq
	@rm -Rfv dist

test: get_source dependencies compile run_test clean
package: get_source dependencies compile dist clean
