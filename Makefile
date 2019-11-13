NAME = human-factory.zip
MANIFEST = manifest.json
SOURCES = dist/background.js dist/content.js
ASSETS = dist/icon-128.png dist/icon-48.png dist/icon-16.png
DIRT = lib dist
ZIP_CONTENTS = $(MANIFEST) $(SOURCES) $(ASSETS)

$(NAME): $(ZIP_CONTENTS)
	zip $(NAME) $(ZIP_CONTENTS)

js:
	npm run bsb:make

bundle: js
	npm run webpack:production

clean:
	rm -fr $(DIRT)

fclean: clean
	rm -f $(NAME)

dist/%: assets/%
	cp --reflink=auto $< $@

.PHONY: js bundle clean fclean
