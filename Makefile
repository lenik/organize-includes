# Version from debian/changelog first line, or override: make release VERSION=0.0.2
VERSION := $(shell awk -F'[()]' '{print $$2; exit}' debian/changelog)
TARBALL := organize-includes-$(VERSION).tar.gz
TAG     := v$(VERSION)

.PHONY: dist release release-force tag clean

dist: $(TARBALL)

$(TARBALL):
	git archive --format=tar.gz --prefix=organize-includes-$(VERSION)/ -o $(TARBALL) HEAD

tag: $(TARBALL)
	@git rev-parse $(TAG) >/dev/null 2>&1 || git tag $(TAG)

# Extract release notes from debian/changelog (first block's bullet points)
RELEASE_NOTES = .release-notes
define release_notes
	printf '%s\n\n' "Release $(VERSION)" > $(RELEASE_NOTES); \
	awk '/^  \* / { sub(/^  \* /, "- "); print } /^  -- / { exit }' debian/changelog >> $(RELEASE_NOTES); \
	printf '\nSee README.md and debian/changelog.\n' >> $(RELEASE_NOTES)
endef

release: $(TARBALL)
	@git rev-parse $(TAG) >/dev/null 2>&1 || git tag $(TAG)
	git push -f origin $(TAG)
	@$(release_notes)
	gh release create $(TAG) $(TARBALL) --title "$(TAG)" --notes-file $(RELEASE_NOTES)
	@rm -f $(RELEASE_NOTES)

release-force: $(TARBALL)
	-@gh release delete $(TAG) --cleanup-tag -y 2>/dev/null || true
	-@git tag -d $(TAG) 2>/dev/null || true
	@git tag $(TAG)
	git push -f origin $(TAG)
	@$(release_notes)
	gh release create $(TAG) $(TARBALL) --title "$(TAG)" --notes-file $(RELEASE_NOTES)
	@rm -f $(RELEASE_NOTES)

clean:
	rm -f $(TARBALL) $(RELEASE_NOTES)
