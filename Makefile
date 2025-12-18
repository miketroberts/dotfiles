# 1. Detect the Operating System
UNAME_S := $(shell uname -s)

# 2. OS-Specific Configuration
ifeq ($(UNAME_S), Linux)
    PKGS_FILE    := linux-packages.txt
    INSTALL_CMD  := sudo apt-get update && sudo apt-get install -y
    PRE_INSTALL  := 
else ifeq ($(UNAME_S), Darwin)
    PKGS_FILE    := osx-packages.txt
    INSTALL_CMD  := brew install
    PRE_INSTALL  := install-homebrew
endif

# 3. General Commands Config
OTHER_FILE := other-packages.txt

# 4. Targets
.PHONY: all install install-homebrew run-other help

all: install

# macOS Only: Ensure Homebrew exists
install-homebrew:
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "Homebrew not found. Installing now..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	else \
		echo "Homebrew already installed."; \
	fi

# Updated: Error-Resistant Command Execution
run-other:
	@if [ -f $(OTHER_FILE) ]; then \
		echo "--- Running custom commands from $(OTHER_FILE) ---"; \
		ERRORS=0; \
		while IFS= read -r line || [ -n "$$line" ]; do \
			case "$$line" in \
				\#*) ;; \
				"") ;; \
				*) \
					echo "Executing: $$line"; \
					if ! eval "$$line"; then \
						echo "  >> ERROR: Command failed: $$line"; \
						ERRORS=$$((ERRORS + 1)); \
					fi \
					;; \
				esac; \
			done < $(OTHER_FILE); \
			if [ $$ERRORS -ne 0 ]; then \
				echo "--- Finished with $$ERRORS error(s). ---"; \
				exit 1; \
			fi; \
			echo "--- All custom commands finished successfully. ---"; \
		else \
			echo "No $(OTHER_FILE) found, skipping."; \
		fi

# Universal: Execute commands from other-packages.txt
run-other:
	@if [ -f $(OTHER_FILE) ]; then \
		echo "--- Running custom commands from $(OTHER_FILE) ---"; \
		while IFS= read -r line || [ -n "$$line" ]; do \
			case "$$line" in \
				\#*) ;; \
				"") ;; \
				*) \
					echo "Executing: $$line"; \
					eval $$line || exit 1; \
					;; \
			esac; \
		done < $(OTHER_FILE); \
	else \
		echo "No $(OTHER_FILE) found, skipping."; \
	fi

# Main Setup Target
install: $(PRE_INSTALL)
	@echo "--- Installing System Packages ($(UNAME_S)) ---"
	@PACKAGES=$$(grep -v '^\#' $(PKGS_FILE) 2>/dev/null | xargs); \
	if [ -n "$$PACKAGES" ]; then \
		$(INSTALL_CMD) $$PACKAGES; \
	else \
		echo "No packages to install for $(UNAME_S)."; \
	fi
	@$(MAKE) run-other

help:
	@echo "Usage: make [install]"
	@echo "Detected OS: $(UNAME_S)"
