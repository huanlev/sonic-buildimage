# Clang Static Analyzer targets
.PHONY: clang-sa clang-sa-clean

clang-sa:
	@if [ "$(ENABLE_CLANG_SA)" = "y" ]; then \
		echo "Running Clang Static Analyzer..."; \
		mkdir -p $(CLANG_SA_OUTPUT_DIR); \
		cd src/sonic-swss && \
		scan-build --use-cc=clang --use-c++=clang++ \
			-o $(CLANG_SA_OUTPUT_DIR) \
			-enable-checker $(CLANG_SA_CHECKERS) \
			make -j$(SONIC_CONFIG_MAKE_JOBS) || true; \
		cd src/sonic-utilities && \
		scan-build --use-cc=clang --use-c++=clang++ \
			-o $(CLANG_SA_OUTPUT_DIR) \
			-enable-checker $(CLANG_SA_CHECKERS) \
			make -j$(SONIC_CONFIG_MAKE_JOBS) || true; \
	else \
		echo "ClangSA disabled, skipping..."; \
	fi

clang-sa-clean:
	rm -rf $(CLANG_SA_OUTPUT_DIR)
