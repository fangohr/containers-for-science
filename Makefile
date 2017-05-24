test:
	py.test -v -l -s --nbval-lax --current-env .

install-dependencies:
	pip install -r requirements.txt

.PHONY: pdf
pdf: notebooks/*.ipynb latex_template.tplx
	@echo "Attempting to create book.pdf from notebooks"
	mkdir -p pdf
	python3 -m bookbook.latex notebooks --pdf --template latex_template.tplx \
			--output-file pdf/containers-for-science.pdf
	date > pdf/last-updated.txt

.PHONY: html
html: notebooks/*.ipynb
	python3 -m bookbook.html notebooks
	date > html/last-updated.txt

all: html pdf

test-pdf:
	make pdf

test-html:
	make html

test-all:
	@# test execution of notebooks and examples
	make test
	@# test building of html output
	make test-html
	@# test building of pdf output
	make test-pdf


# to run builds and tests in Container

docker-build:
	docker build -t containers-for-science .

run-test-in-container:
	@# build container first - null operation if already done
	make docker-build
	@# run actual tests in container
	docker run -v `pwd`:/io containers-for-science make test-html
	docker run -v `pwd`:/io containers-for-science make test-pdf
	docker run -v `pwd`:/io containers-for-science make test
