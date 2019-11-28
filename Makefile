NAME = human-factory.zip
MANIFEST = manifest.json
ASSETS = dist/icon-128.png dist/icon-48.png dist/icon-16.png
BUNDLES = dist/content.js dist/background.js
DIRT = dist
ZIP_CONTENTS = $(MANIFEST) $(BUNDLES) $(ASSETS)
TRACKED = $(shell git ls-tree -r master --name-only)

all: $(NAME)

js:
	npm run bsb:make

bundle: js
	npm run webpack:production

dist/%: assets/%
	cp $< $@

$(NAME): bundle $(ZIP_CONTENTS)
	zip $(NAME) $(ZIP_CONTENTS)

clean:
	rm -fr $(DIRT)
	npm run bsb:clean

review.zip: $(TRACKED)
	zip review.zip $(TRACKED)

fclean: clean
	rm -f $(NAME)

.PHONY: js bundle clean fclean
