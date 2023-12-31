.PHONY: help build zip clean

help:
	@echo "Commands:"
	@echo "  make build - Mix project build"
	@echo "  make zip <cmd> <args> - Runs commands based on this:"
	@echo "   >> directory_size <path> -- [<flags>]"
	@echo "      |> --allow-empty - Includes empty directories"
	@echo "   >> fetch_wikipedia_page <uri>"
	@echo "  make help - Display this message"

build:
	@echo "Building"
	@mix escript.build

zip: build
	@./ewbscp $(filter-out $@,$(MAKECMDGOALS))

clean:
	@rm -rf _build/
	@rm -rf ewbscp

%:
	@:
