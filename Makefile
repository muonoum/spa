.PHONY: start
start:
	gleam run -m lustre/dev start

.PHONY: build
build:
	gleam run -m lustre/dev build spa

.PHONY: snapshot
snapshot:
	gleam run -m birdie

.PHONY: commit
commit: commit_message ?= $(shell git diff --name-only --cached | rev | cut -d/ -f 1,2 | rev | xargs)
commit:
	test -n "$(commit_message)"
	git commit -m "$(commit_message)"
