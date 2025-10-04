VERSION =
ARCH = 

ifeq ($(VERSION),)
    $(error VERSION is required.)
endif

ifeq ($(ARCH),)
    $(error ARCH is required.)
endif

TARBALL_NAME=tor-$(ARCH).tar.gz

get_source:
	@git clone https://gitlab.torproject.org/tpo/core/tor.git
	@cd tor && git checkout $(VERSION)

sys_deps:
	@sudo apt update
	@sudo apt install -y build-essential autotools-dev automake

dep_openssl:
	# openssl 1.1.1w
	@wget https://github.com/openssl/openssl/releases/download/OpenSSL_1_1_1w/openssl-1.1.1w.tar.gz
	@tar -xvzf openssl-1.1.1w.tar.gz
	@cd openssl-1.1.1w && mkdir -p /tmp/openssl && \
		./config --prefix=/tmp/openssl --openssldir=/tmp/openssl no-shared threads && \
		make depend && make && make install

dep_libevent:
	# libevent 2.1.12
	@wget https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz
	@tar -xvzf libevent-2.1.12-stable.tar.gz
	@cd libevent-2.1.12-stable && mkdir -p /tmp/libevent && \
		./configure --prefix=/tmp/libevent --disable-shared \
		--enable-static --with-pic --disable-samples \
		--disable-libevent-regress \
		CPPFLAGS=-I/tmp/openssl/include \
		LDFLAGS=-L/tmp/openssl/lib && \
		make && make install

dep_zlib:
	# zlib 1.3.1
	@wget https://zlib.net/zlib-1.3.1.tar.gz
	@tar -xvzf zlib-1.3.1.tar.gz
	@cd zlib-1.3.1 && mkdir -p /tmp/zlib && \
		./configure --prefix=/tmp/zlib --static && \
		make && make install
	
dependencies: sys_deps dep_openssl dep_libevent dep_zlib

compile:
	@cd tor && mkdir -p /tmp/tor && ./autogen.sh && \
		CPPFLAGS="-I/tmp/openssl/include -I/tmp/libevent/include -I/tmp/zlib/include" \
		LDFLAGS="-L/tmp/openssl/lib -L/tmp/libevent/lib -L/tmp/zlib/lib -static -ldl -lpthread" \
		./configure --prefix=/tmp/tor --disable-asciidoc \
		--enable-static-tor \
		--with-openssl-dir=/tmp/openssl \
		--with-libevent-dir=/tmp/libevent \
		--with-zlib-dir=/tmp/zlib && \
		make && make install

run_test:
	/tmp/tor/bin/tor --version

dist:
	@mkdir -v dist
	@cp -v torrc dist/torrc
	@cp -v /tmp/tor/bin/tor dist/tor
	@echo $(VERSION) >> dist/version
	@tar -czvf $(TARBALL_NAME) -C dist .

clean:
	@rm -Rfv dist
	@rm -Rfv tor
	@rm -Rfv openssl*
	@rm -Rfv libevent*
	@rm -Rfv zlib*
	@rm -Rfv /tmp/tor
	@rm -Rfv /tmp/openssl
	@rm -Rfv /tmp/libevent
	@rm -Rfv /tmp/zlib

test: get_source dependencies compile run_test clean
package: get_source dependencies compile dist clean
