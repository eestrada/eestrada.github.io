.PHONY: all build clean

all: clean build

build:
	yozuch build ./_source
	mv ./_source/output/* .
	rm -rf ./_source/output

clean:
	find . \! -path './.git*'  \! -path './_source*' \! -name 'Makefile' \! -name 'README.md' -delete
