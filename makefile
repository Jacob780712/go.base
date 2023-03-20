# -*- coding: utf-8 -*-
# SET YOUR ORGANIZATION'S ADDRESS, WHICH IS ALSO USED AS THE GO PACKAGE URL.
ORG = "github.com/disism"

FSPATH=$(PWD)
GIT_REPO_URL = $(ORG)
REPO_NAME = $(shell basename `pwd`)
REPO_URL = "$(GIT_REPO_URL)/$(REPO_NAME)"

# OS
OS := $(shell uname -s)
ARCH := $(shell uname -m)
USER_HOME := $(shell echo ${HOME})

# VERSION
VERSION_FILE := VERSION
VERSION := $(shell cat ./$(VERSION_FILE))

# GO
GOPATH := $(shell go env GOPATH)

ifeq ($(VERSION),)
        VERSION := $(shell git describe --tags --abbrev=0)
endif

# MKDIR
MAKE_FSPATH=$(FSPATH)/make
include $(MAKE_FSPATH)/variables.mk

TOOLS := go protoc protoc-gen-go protoc-gen-grpc-gateway buf cobra-cli cloudflared cfssl cfssljson

# ---------------------------------------------------------------------------
print:
	@echo
	@echo "REPO NAME: $(REPO_NAME)"
	@echo "REPO URL: $(REPO_URL)"
	@echo "FSPATH: $(FSPATH)"
	@echo "MAKE_FSPATH: $(MAKE_FSPATH)"
	@echo "VERSION: $(VERSION)"
	@echo ""

	@echo "OS: $(OS)"
	@echo "ARCH: $(ARCH)"
	@echo "GO_PATH: $(GOPATH)"
	@echo "USER_HOME: $(USER_HOME)"
	@echo ""

	@echo "Usage: "
	@echo "  make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  print        - Print the dev environment and help."
	@echo "  mod          - Initialize the current project with go mod."
	@echo "  tidy         - Execute go mod tidy."
	@echo "  plugin       - Install plug-ins commonly used in the development process."
	@echo "  buf          - Use buf to generate grpc code."
	@echo ""
	@echo "************** dependencies and plugin *******************"
	@for tool in $(TOOLS); do \
		if ! command -v $$tool >/dev/null 2>&1; then \
			echo "* (×) [ $$tool ]"; \
		else \
			echo "(√) [ $$tool ]"; \
		fi \
	done
	@echo ""

mod:
	@echo "************** mod *******************"
	@rm -f go.mod go.sum
	@go mod init $(GIT_REPO_URL)/$(REPO_NAME)

tidy:
	@echo "********************* go mod tidy ************************"
	@echo "ref: https://go.dev/ref/mod#go-mod-tidy"
	@go mod tidy
	@echo ""


buf:
	@cd ./APIs && buf generate

# ---------------------------------------------------------------------------
include $(MAKE_FSPATH)/plugin.mk

