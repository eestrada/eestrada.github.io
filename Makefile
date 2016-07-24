.PHONY: all build safe-build serve preview setup clean

all: clean build

build:
	source _venv/bin/activate; raco frog --build

safe-build: setup build

serve:
	raco frog --serve

preview:
	raco frog --preview

setup:
	virtualenv _venv
	source _venv/bin/activate; pip install --upgrade pygments
	# Multiple authors will eventually get into mainline frog, but for now, use this fork.
	- raco pkg install "https://github.com/LeifAndersen/frog.git#authors"

clean:
	raco frog --clean
