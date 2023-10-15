ARCH ?= $(shell uname -m)

ifeq ($(ARCH), x86_64)
override ARCH = amd64
endif

ifneq ($(ARCH), amd64)
ifneq ($(ARCH), arm64)
all:
	@echo "Error: ARCH is not 'amd64' or 'arm64'"
	exit 1
else
all: pass_rank_$(ARCH).alfredworkflow
endif
endif

pass_rank_$(ARCH).alfredworkflow: info.plist icon.png scripts/generate_password.sh scripts/get_otp.sh scripts/get_password.sh pass_rank/pass_rank
	zip $@ $^

pass_rank/pass_rank:
	GOOS=darwin GOARCH=$(ARCH) go build -C pass_rank

.PHONY: clean
clean:
	rm -f pass_rank/pass_rank

.PHONY: distclean
distclean: clean
	rm -f pass_rank_$(ARCH).alfredworkflow
