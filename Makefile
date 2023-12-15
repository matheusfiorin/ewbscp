.PHONY: help build zip clean

ifeq (zip,$(firstword $(MAKECMDGOALS)))
  ZIP_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(ZIP_ARGS):;@:)
endif

help:
	@echo "Commands:"
	@echo "  make build - Mix project build"
	@echo "  make zip <cmd> <args> - Runs commands based on this:"
	@echo "   >> directory_size <path> -- [<flags>]"
	@echo "      --allow-empty - Includes empty directories"
	@echo "  make help - Display this message"

build:
	@echo "Building"
	@mix escript.build

zip: build
	@./ewbscp $(ZIP_ARGS)
	@$(MAKE) clean

clean:
	@rm -rf _build/
	@rm -rf ewbscp

%:
	@$(MAKE) help
