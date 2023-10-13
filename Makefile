all: binaries .WAIT workflows

.PHONY: binaries
workflows: pass_rank_amd64.alfredworkflow .WAIT pass_rank_arm64.alfredworkflow

pass_rank_amd64.alfredworkflow:
	cp info_amd64.plist info.plist
	zip $@ scripts/generate_password.sh scripts/get_otp.sh scripts/get_password.sh pass_rank/pass_rank_amd64 info.plist icon.png
	rm -f info.plist

pass_rank_arm64.alfredworkflow:
	cp info_arm64.plist info.plist
	zip $@ scripts/generate_password.sh scripts/get_otp.sh scripts/get_password.sh pass_rank/pass_rank_arm64 info.plist icon.png
	rm -f info.plist

.PHONY: binaries
binaries: pass_rank/pass_rank_amd64 pass_rank/pass_rank_arm64

pass_rank/pass_rank_amd64:
	GOOS=darwin GOARCH=amd64 go build -C pass_rank -o pass_rank_amd64

pass_rank/pass_rank_arm64:
	GOOS=darwin GOARCH=arm64 go build -C pass_rank -o pass_rank_arm64

.PHONY: clean
clean:
	rm -f pass_rank_amd64.alfredworkflow pass_rank_arm64.alfredworkflow pass_rank/pass_rank_amd64 pass_rank/pass_rank_arm64 info.plist
