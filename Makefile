# ivoatex Makefile.  The ivoatex/README for the targets available.

# short name of your document (edit $DOCNAME.tex; would be like RegTAP)
DOCNAME = VODataService

# count up; you probably do not want to bother with versions <1.0
DOCVERSION = 1.3

# Publication date, ISO format; update manually for "releases"
DOCDATE = 2026-04-15

# What is it you're writing: NOTE, WD, PR, REC, PEN, or EN
DOCTYPE = PR

# Source files for the TeX document (but the main file must always
# be called $(DOCNAME).tex
SOURCES = $(DOCNAME).tex role_diagram.pdf ipac-resource.xml

# List of image files to be included in submitted package (anything that
# can be rendered directly by common web browsers)
FIGURES = role_diagram.svg

# List of PDF figures (figures that must be converted to pixel images to
# work in web browsers).
VECTORFIGURES = resclasses.tikz.svg

SCHEMA_FILE=VODataService-v1.3.xsd

# Additional files to distribute (e.g., CSS, schema files, examples...)
AUX_FILES = $(SCHEMA_FILE)

AUTHOR_EMAIL=msdemlei@ari.uni-heidelberg.de


%.pdf: %.texfig
	pdflatex $<

-include ivoatex/Makefile

ivoatex/Makefile:
	@echo "*** ivoatex submodule not found.  Initialising submodules."
	@echo
	git submodule update --init

STILTS ?= stilts
SCHEMA_FILE=VODataService-v1.3.xsd

test:
	sh test-assertions.sh
	@$(STILTS) xsdvalidate $(SCHEMA_FILE)
	@$(STILTS) xsdvalidate $(SCHEMA_FILE)
	@ls samples/*.xml | xargs -n1 $(STILTS) xsdvalidate \
		schemaloc="http://www.ivoa.net/xml/VODataService/v1.1=$(SCHEMA_FILE)"
