.PHONY: help build run

ifeq (run,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif

ifeq (zip,$(firstword $(MAKECMDGOALS)))
  ZIP_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(ZIP_ARGS):;@:)
endif

help:
	@echo "Usage:"
	@echo "  make build                   - Builds project with Mix"
	@echo "  make run <path> -- [<flags>] - Execute the compiled file and <path> doesn't have quotes"
	@echo "  make zip <path> -- [<flags>] - Same as run, but it builds before running"
	@echo "   || possible flags:"
	@echo "   ||   --allow-empty :: Includes empty directories"
	@echo ""
	@echo "  make help                    - Shows this help"

build:
	@echo "Building"
	@mix escript.build

run:
	@./ewbscp $(RUN_ARGS)

zip: build
	@./ewbscp $(ZIP_ARGS)

%:
	@$(MAKE) help
