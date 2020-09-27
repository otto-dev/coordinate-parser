.PHONY: build test-once test

build:
	@coffee --bare --output ./ --compile src/

test:
	@nodemon --exec "make test-once --quiet" --ext "coffee,js" --quiet

test-once:
	@mocha ---require coffeescript/register --ext "coffee,js"

