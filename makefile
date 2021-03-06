all: update helptags

update:
	git submodule foreach git pull origin master
	git commit --quiet --message "fix: updated bundles" bundle
	cd bundle/coc.nvim && yarn && cd -

helptags:
	nvim -c 'call pathogen#helptags()|q'

bundle: _bundle helptags

_bundle:
	@basename="$(notdir $(basename $(url)))"; \
	if test $$basename; then \
		git submodule add $(url) bundle/$$basename; \
		git commit bundle/$$basename .gitmodules --message \
			"feat: $$basename as a submodule"; \
	else \
		echo "usage: make bundle url=..."; \
	fi

.PHONY: all update helptags bundle
