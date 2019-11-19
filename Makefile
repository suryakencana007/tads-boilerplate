#:## Help
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help
	@awk 'BEGIN { \
		print "T.A.D.S. Makefile";\
	\
		FS = ":.*?## "} \
	/^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2} \
	/^#:## / {printf "\n\033[35m%s\033[0m\n", $$2} ' \
	$(MAKEFILE_LIST)

.DEFAULT_GOAL := help

#:## Lint tasks
lint: lint-bash lint-terraform lint-ansible ## Execute all lint tasks

lint-bash: ## Perform a shellcheck linting on all scripts
	shellcheck tads scripts/**/*.sh

lint-terraform: ## Perform a "terraform validate" linting
	./tads terraform production validate

lint-ansible: ## Perform an ansible-lint linting
	ansible-lint ansible/*.yml
