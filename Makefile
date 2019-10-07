NAME = human-factory.zip
MANIFEST = manifest.json
SOURCES = dist/background.js dist/content.js
DIRT = lib dist
ZIP_CONTENTS = $(MANIFEST) $(SOURCES)

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

.PHONY: js bundle clean fclean
