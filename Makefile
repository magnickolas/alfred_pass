all: pass.alfredworkflow

pass.alfredworkflow: info.plist icon.png scripts/generate_password.sh scripts/get_otp.sh scripts/get_password.sh pass_rank/pass_rank
	zip $@ $^

pass_rank/pass_rank: pass_rank/pass_rank_amd64 pass_rank/pass_rank_arm64
	lipo -create -output $@ $^

define get_binary_from_path
$(notdir $1)
endef

define get_target_from_binary
$(lastword $(subst _, ,$1))
endef

pass_rank/pass_rank_%: pass_rank/**/*.go
	$(eval BINARY := $(call get_binary_from_path,$@))
	$(eval ARCH := $(call get_target_from_binary,$(BINARY)))
	GOOS=darwin GOARCH=$(ARCH) go build -C pass_rank -o $(BINARY)

.PHONY: clean
clean:
	rm -f pass_rank/pass_rank*

.PHONY: distclean
distclean: clean
	rm -f pass.alfredworkflow
