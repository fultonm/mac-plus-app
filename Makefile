# Makefile for Macintosh Plus bootable image workflow

BASE_IMAGE ?= assets/base-bootable-400k.img
TARGET_IMAGE ?= mac-plus.img
APP_FILES ?=

all: $(TARGET_IMAGE)

$(TARGET_IMAGE): $(BASE_IMAGE)
	@mkdir -p assets
	cp "$(BASE_IMAGE)" "$(TARGET_IMAGE)"
	@size=$$(stat -c%s "$(TARGET_IMAGE)"); \
	if [ "$$size" -ne 409600 ]; then \
		echo "error: $(TARGET_IMAGE) is $$size bytes (expected 409600 for a 400K disk image)"; \
		rm -f "$(TARGET_IMAGE)"; \
		exit 1; \
	fi
	@echo "Created $(TARGET_IMAGE) from $(BASE_IMAGE)"

check-base:
	@test -f "$(BASE_IMAGE)" || ( \
		echo "error: missing $(BASE_IMAGE)"; \
		echo "Place your legally-owned Mac Plus bootable 400K image at $(BASE_IMAGE)."; \
		exit 1 \
	)
	@size=$$(stat -c%s "$(BASE_IMAGE)"); \
	if [ "$$size" -ne 409600 ]; then \
		echo "error: $(BASE_IMAGE) is $$size bytes (expected 409600)"; \
		exit 1; \
	fi
	@echo "Base image exists and is 400K."

add-apps: $(TARGET_IMAGE)
	@test -n "$(APP_FILES)" || ( \
		echo "error: APP_FILES is empty"; \
		echo "usage: make add-apps APP_FILES='path/to/App1 path/to/App2'"; \
		exit 1 \
	)
	@command -v hmount >/dev/null 2>&1 || ( \
		echo "error: hfsutils is required for add-apps target"; \
		echo "install: sudo apt-get update && sudo apt-get install -y hfsutils"; \
		exit 1 \
	)
	@command -v hcopy >/dev/null 2>&1 || ( \
		echo "error: hcopy not found (install hfsutils)"; \
		exit 1 \
	)
	hmount "$(TARGET_IMAGE)"
	@set -e; for f in $(APP_FILES); do \
		echo "Copying $$f to image..."; \
		hcopy -m "$$f" :; \
	done
	humount
	@echo "Added files to $(TARGET_IMAGE)."

clean:
	rm -f "$(TARGET_IMAGE)"

.PHONY: all check-base add-apps clean