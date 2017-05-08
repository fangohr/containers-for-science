test:
	py.test -v -l -s --nbval --current-env .

install-dependencies:
	pip install -r requirements.txt

book.pdf: notebooks/*.ipynb latex_template.tplx
	@echo "Attempting to create book.pdf from notebooks"
	python3 -m bookbook.latex notebooks --pdf --template latex_template.tplx \
			--output-file book.pdf
