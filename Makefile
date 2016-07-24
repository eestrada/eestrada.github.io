.PHONY: all build serve preview setup clean

all: clean build

build: setup
	source _venv/bin/activate; raco frog --build

serve:
	raco frog --serve

preview:
	raco frog --preview

setup:
	virtualenv _venv
	source _venv/bin/activate; pip install --upgrade pygments

clean:
	raco frog --clean
