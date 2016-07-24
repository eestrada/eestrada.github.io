.PHONY: all build setup clean

all: clean build

build: setup
	source _venv/bin/activate; raco frog --build

setup:
	rm -rf _venv
	virtualenv _venv
	source _venv/bin/activate; pip install pygments

clean:
	raco frog --clean
