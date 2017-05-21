test:
	py.test -v -l -s --nbval-lax --current-env .

install-dependencies:
	pip install -r requirements.txt

pdf: notebooks/*.ipynb latex_template.tplx
	@echo "Attempting to create book.pdf from notebooks"
	mkdir -p pdf
	python3 -m bookbook.latex notebooks --pdf --template latex_template.tplx \
			--output-file pdf/containers-for-science.pdf
	date > pdf/last-updated.txt

html: notebooks/*.ipynb
	python3 -m bookbook.html notebooks
	date > html/last-updated.txt

all: html pdf

test-pdf:
	make pdf

test-html:
	make html

test-all:
	make test
	make html
	make pdf
	