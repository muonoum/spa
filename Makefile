.PHONY: start
start:
	gleam run -m lustre/dev start

.PHONY: build
build:
	gleam run -m lustre/dev build app

.PHONY: test
test:
	gleam test

.PHONY: snapshot
snapshot:
	gleam run -m birdie

.PHONY: commit
commit_message = $(shell echo $(message) | xargs)
commit: message ?= $(shell git diff --name-only --cached | xargs basename)
commit:
	test -n "$(commit_message)"
	git commit -m "$(commit_message)"
