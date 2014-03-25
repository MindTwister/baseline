COFFEE = $(shell find src/coffee/ -type f -name '*.coffee')
JS = $(patsubst src/coffee/%.coffee, js/%.js, $(COFFEE))
JADE = $(shell find src/jade/ -type f -name '*.jade')
HTML = $(patsubst src/jade/%.jade, %.html, $(JADE))
STYLUS = $(shell find src/stylus/ -type f -name '*.styl')
CSS = $(patsubst src/stylus/%.styl, css/%.css, $(STYLUS))

.PHONY: all clean assets

all: $(JS) $(HTML) $(CSS)

assets: $(JS) $(HTML) $(CSS)

js/%.js: src/coffee/%.coffee
	@mkdir -p "$(@D)"
	@echo Compiling "$<"
	coffee -c -o $(@D) $<

%.html: src/jade/%.jade
	@mkdir -p "$(@D)"
	@echo Compiling "$<"
	jade -P < $< --path $< > $@

css/%.css: src/stylus/%.styl
	@mkdir -p "$(@D)"
	@echo Compiling "$<"
	stylus --compress < $< > $@

clean:
	rm -rf $(JS) $(HTML) $(CSS)

