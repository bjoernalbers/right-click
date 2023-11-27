PROJECT_NAME := right-click
IDENTIFIER := de.bjoernalbers.$(PROJECT_NAME)
PKG_SIGNING_IDENTITY := Developer ID Installer: Bjoern Albers (2M83WXV6U8)
# Regex to capture Semantic Version string taken from: https://semver.org
VERSION := $(shell git describe --tags | grep -Eo '^v?(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?$$' | tr -d v)
BUILD_DIR := build
SCRIPTS_DIR := scripts
DIST_DIR := dist
COMPONENT_PKG := $(BUILD_DIR)/$(PROJECT_NAME).pkg
DISTRIBUTION_PKG := $(DIST_DIR)/$(PROJECT_NAME)-$(VERSION).pkg

$(DISTRIBUTION_PKG): $(COMPONENT_PKG)
ifndef VERSION
	$(error No Semantic Version found in git tag)
endif
	productbuild \
		--package "$<" \
		--sign "$(PKG_SIGNING_IDENTITY)" \
		--quiet \
		"$@"

$(COMPONENT_PKG): $(shell find "$(SCRIPTS_DIR)" -type f)
ifndef VERSION
	$(error No Semantic Version found in git tag)
endif
	mkdir -p "$(BUILD_DIR)"
	pkgbuild \
		--nopayload \
		--scripts "$(SCRIPTS_DIR)" \
		--identifier "$(IDENTIFIER)" \
		--version "$(VERSION)" \
		--sign "$(PKG_SIGNING_IDENTITY)" \
		--quiet \
		"$@"

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)
