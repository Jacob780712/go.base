
########################################################################
# GRPC PLUGIN PROTOBUF TOOLS
#
########################################################################
PROTOC_GEN_GO := google.golang.org/protobuf/cmd/protoc-gen-go
GRPC_PROTOC_GEN_GO := google.golang.org/grpc/cmd/protoc-gen-go-grpc
GRPC_GATEWAY_GO := github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway
GRPC_GEN_VALIDATE := github.com/envoyproxy/protoc-gen-validate

plugin-buf:
	@echo "********************* buf ********************************"
	@echo "version: $(BUF_VERSION)"
	# curl -k -sSLf https://github.com/bufbuild/buf/releases/download/<VERSION>/buf -o buf
	curl -k -sSLf $(BUF_DOWNLOAD_LINK) -o $(BUF_BINARY_NAME)
	chmod +x $(BUF_BINARY_NAME)
	mv $(BUF_BINARY_NAME) $(BUF_INSTALL_PATH)
	@echo
	@echo "ok!"

plugin-cfssl:
	go install $(CFSSL)@$(CFSSL_VERSION)
	go install $(CFSSLJSON)@$(CFSSLJSON_VERSION)
	@echo
	@echo "ok!"
	@echo

plugin-protoc:
	@echo ""
	@echo "********************* protoc *****************************"
	@echo "version: $(PROTOC_VERSION)"
	curl -k -sSL "$(PROTOC_URL)" -o "$(PROTOC_ZIP)" && unzip -qq "$(PROTOC_ZIP)" -d "$(PROTOC_DIR)"
	mv "$(PROTOC_DIR)/bin/protoc" "$(PROTOC_INSTALL_DIR)/" && rm -rf "$(TMP_DIR)" "$(PROTOC_ZIP)"
	@echo ""
	@echo "********************* go grpc plugin *********************"
	@echo "version: $(GRPC_VERSION)"
	go install $(PROTOC_GEN_GO)@$(PROTOC_GEN_GO_VERSION);
	go install $(GRPC_PROTOC_GEN_GO)@$(GRPC_PROTOC_GEN_GO_VERSION);
	go install $(GRPC_GATEWAY_GO)@$(GRPC_GATEWAY_GO_VERSION);
	go install $(GRPC_GEN_VALIDATE)@$(GRPC_GEN_VALIDATE_VERSION)
	@echo ""
	@echo "ok!"

plugin:
	@echo "********************* plugin install help ****************"
	@echo ""
	@echo "Usage: "
	@echo "  make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  plugin-buf         - Install the buf plugin."
	@echo "  plugin-cfssl       - Install the cfssl tool plugin."
	@echo "  plugin-protoc      - Install the protoc toolchain."
	@echo ""
	@echo "********************* plugin install refs ****************"
	@echo "ref: https://github.com/envoyproxy/protoc-gen-validate"
	@echo "ref: https://github.com/grpc-ecosystem/grpc-gateway/tree/master/protoc-gen-grpc-gateway"
	@echo "ref: https://github.com/bufbuild/buf/releases"
	@echo "ref: https://github.com/cloudflare/cfssl"
	@echo "ref: https://github.com/cloudflare/cfssljson"
