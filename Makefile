.PHONY: all build setup clean

all: clean build

build: setup
	yozuch build ./_source
	mv ./_source/output/* .
	rm -rf ./_source/output

setup:
	@ if [ ! `which yozuch` ]; then pip3 install --user yozuch; fi;

clean:
	find . \! -path './.git*'  \! -path './_source*' \! -name 'Makefile' \! -name 'README.md' -delete
