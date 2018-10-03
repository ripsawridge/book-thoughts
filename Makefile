
SOURCE_CHAPTERS := header.yml book.md

PANDOC := pandoc

PANDOC_OPTS_ALL :=  --toc -f markdown+smart --variable secnumdepth=0 \
					--top-level-division=chapter \
					--filter pandoc-crossref

PANDOC_PDF_OPTS := $(PANDOC_OPTS_ALL) \
					--default-image-extension=pdf \
					--metadata documentclass=scrbook \
					--metadata geometry=b5paper

PANDOC_EPUB_OPTS := $(PANDOC_OPTS_ALL) \
					--default-image-extension=png \
					-t epub3 --toc-depth=1 \
					--css=Medium-Style.css \
					--epub-cover-image=cover.png

#					--epub-stylesheet=Medium-Style.css \


all: book.pdf book.epub

book.pdf: $(SOURCE_CHAPTERS) Makefile
	$(PANDOC) $(PANDOC_PDF_OPTS) -o $@ $(SOURCE_CHAPTERS)

book.epub: $(SOURCE_CHAPTERS) Makefile Medium-Style.css
	$(PANDOC) $(PANDOC_EPUB_OPTS) -o $@ $(SOURCE_CHAPTERS)

clean:
	rm book.pdf book.epub
