test:
	py.test -v -l -s --nbval --current-env .

install-dependencies:
	pip install -r requirements.txt
