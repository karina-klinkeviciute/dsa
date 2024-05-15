# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS   ?= -c .
SPHINXBUILD  ?= env/bin/sphinx-build
SOURCEDIR     = dsa
BUILDDIR      = build

UMLDIR        = dsa/diagrams
MMDS         := $(wildcard $(DIAGRAMS)/*.mmd)
SVGS         := $(patsubst $(DIAGRAMS)/%.mmd,$(DIAGRAMS)/%.svg,$(MMDS))


export PATH := env/bin:$(PATH)

all: env/done requirements.txt node_modules/.bin/mmdc $(SVGS)


# Python
.PHONY: upgrade
upgrade: env/bin/pip-compile
	env/bin/pip-compile --upgrade requirements.in -o requirements.txt

env/done: env/bin/pip requirements.txt
	env/bin/pip install -r requirements.txt
	touch $@

env/bin/pip:
	python -m venv env
	env/bin/pip install --upgrade pip wheel setuptools

requirements.txt: env/bin/pip-compile requirements.in
	env/bin/pip-compile requirements.in -o requirements.txt

env/bin/pip-compile: env/bin/pip
	env/bin/pip install pip-tools

requirements.in:
	true


# Sphinx
%: Makefile
	@echo $@
	@echo $(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

auto: all
	env/bin/sphinx-autobuild -b html $(SOURCEDIR) $(BUILDDIR)/html $(SPHINXOPTS)

open:
	xdg-open http://127.0.0.1:8000



# Mermaid

node_modules/.bin/mmdc:
	npm install @mermaid-js/mermaid-cli


$(DIAGRAMS)/%.svg: $(DIAGRAMS)/%.mmd
	npx mmdc -i $< -o $@



.PHONY: all help Makefile
