include $(MAKE_FSPATH)/version.mk

# THE DOWNLOAD ADDRESS.
GITHUB_RELEASES_DOWNLOAD_ADDRESS := releases/download
GITHUB_BUF_REPO_ADDRESS := https://github.com/bufbuild/buf
GITHUB_PROTOBUF_REPO_ADDRESS := https://github.com/protocolbuffers/protobuf

BUF_DOWNLOAD_ADDRESS := $(GITHUB_BUF_REPO_ADDRESS)/$(GITHUB_RELEASES_DOWNLOAD_ADDRESS)
PROTOCOLBUFFERS_ADDRESS := $(GITHUB_PROTOBUF_REPO_ADDRESS)/$(GITHUB_RELEASES_DOWNLOAD_ADDRESS)

# BUF https://buf.build/
BUF_DOWNLOAD_LINK ?=
BUF_BINARY_NAME ?=
BUF_INSTALL_PATH := $(GOPATH)/bin

########################################################################
# SET PROTOC VERSION AND DOWNLOAD ADDRESS
#
########################################################################
PROTOC_URL ?=
PROTOC_ZIP := protoc.zip
TMP_DIR := $(shell mktemp -d)
PROTOC_DIR := $(TMP_DIR)/protoc
PROTOC_INSTALL_DIR := $(GOPATH)/bin

CFSSL := github.com/cloudflare/cfssl/cmd/cfssl
CFSSLJSON := github.com/cloudflare/cfssl/cmd/cfssljson

# The Makefile uses the previously mentioned method to detect whether the current operating system
# is Windows or a Windows-like system (such as Cygwin or MinGW).
# If it is, the OS_STRING variable is set to Windows,
# otherwise it is set to the operating system name.
ifeq ($(OS),Windows_NT)
    OS := Windows
else ifeq ($(findstring CYGWIN,$(OS)),CYGWIN)
    OS := Windows
else ifeq ($(findstring MINGW32,$(OS)),MINGW32)
    OS := Windows
else ifeq ($(findstring MINGW64,$(OS)),MINGW64)
    OS := Windows
endif

########################################################################
# WINDOWS
#
########################################################################
ifeq ($(OS),Windows)
#	WINDOWS GOPATH := $(subst \,/,${GOPATH})
	GOPATH := $(subst \,/,${GOPATH})

#	BUF DOWNLOAD LINK
	BUF_DOWNLOAD_LINK := $(BUF_DOWNLOAD_ADDRESS)/$(BUF_VERSION)/buf-Windows-$(ARCH).exe
	BUF_BINARY_NAME := buf.exe

#	PROTOC
	PROTOC_URL := $(PROTOCOLBUFFERS_ADDRESS)/v$(PROTOC_VERSION)/protoc-$(PROTOC_VERSION)-win64.zip

########################################################################
# LINUX
#
########################################################################
else
#	BUF DOWNLOAD
	BUF_DOWNLOAD_LINK := $(BUF_DOWNLOAD_ADDRESS)/$(BUF_VERSION)/buf-$(OS)-$(ARCH)
	BUF_BINARY_NAME := buf

#	PROTOC
	PROTOC_URL := $(PROTOCOLBUFFERS_ADDRESS)/v$(PROTOC_VERSION)/protoc-$(PROTOC_VERSION)-$(OS)-$(ARCH).zip
endif
