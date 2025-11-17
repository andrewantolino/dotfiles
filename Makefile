# Name of the Brewfile
BREWFILE := Brewfile

# ----------------------------------------
# Phony targets (commands, not files)
# ----------------------------------------
.PHONY: bootstrap update cleanup vscode-cli go-tools all

# -----------------------------
# Install all Brewfile items
# -----------------------------
bootstrap:
	@echo "Installing all Brewfile packages..."
	brew bundle --file $(BREWFILE)

# -----------------------------
# Update Homebrew, upgrade packages, then bundle
# -----------------------------
update:
	@echo "Updating Homebrew and packages..."
	brew update
	brew upgrade
	brew bundle --file $(BREWFILE)

# -----------------------------
# Remove anything installed but not in Brewfile
# -----------------------------
cleanup:
	@echo "Cleaning up unused Homebrew packages..."
	brew bundle cleanup --file $(BREWFILE) --force

# -----------------------------
# Ensure VS Code 'code' CLI is in PATH
# -----------------------------
vscode-cli:
	@echo "Setting up VS Code 'code' CLI..."
	if [ ! -f /opt/homebrew/bin/code ]; then \
		ln -sf "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" /opt/homebrew/bin/code; \
	fi

# -----------------------------
# Ensure Go tools binaries are in PATH
# -----------------------------
go-tools:
	@echo "Ensuring Go binaries are in PATH..."
	export PATH=$$PATH:$$HOME/go/bin

# -----------------------------
# Run everything in order
# -----------------------------
all: bootstrap vscode-cli go-tools
	@echo "Setup complete!"
