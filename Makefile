.PHONY: help build zip

ifeq (zip,$(firstword $(MAKECMDGOALS)))
  ZIP_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(ZIP_ARGS):;@:)
endif

help:
	@echo "Commands:"
	@echo "  make build - Mix project build"
	@echo "  make run <cmd> <args> - Execute command with arguments"
	@echo "  make zip <cmd> <args> - Zip using:"
	@echo "   >> directory_size <path> -- [<flags>]"
	@echo "      --allow-empty - Includes empty directories"
	@echo "  make help - Display this message"

build:
	@echo "Building"
	@mix escript.build

zip: build
	@./ewbscp $(ZIP_ARGS)

%:
	@$(MAKE) help
