test:
	py.test -v -l -s --nbval --current-env .


book.pdf: notebooks/*.ipynb latex_template.tplx
	@echo "Attempting to create book.pdf from notebooks"
	python3 -m bookbook.latex --pdf --template latex_template.tplx
