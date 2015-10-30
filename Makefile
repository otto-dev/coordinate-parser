.PHONY: test-once test

test:
	@nodemon --exec "make test-once --quiet" --ext "coffee,js" --quiet

test-once:
	@mocha --compilers coffee:coffee-script/register

