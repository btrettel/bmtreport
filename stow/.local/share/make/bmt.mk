# Copyright 2021-2022 Ben Trettel.
# This file is part of bmtreport <https://github.com/btrettel/bmtreport>.
# 
# bmtreport is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# bmtreport is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with bmtreport.  If not, see <https://www.gnu.org/licenses/>.

# Include some things from my own std.mk rather than putting std.mk in this repository:

# Warn when variables are undefined. There appears to be no way to get an error when variables are undefined. <https://stackoverflow.com/a/14391872/1124489>
MAKEFLAGS += --warn-undefined-variables

.DELETE_ON_ERROR:

# <https://www.oreilly.com/library/view/managing-projects-with/0596006101/ch12.html>
# <https://www.oreilly.com/library/view/managing-projects-with/0596006101/ch04.html#flow_control>
# $(call assert,condition,message)
define assert
    $(if $1,,$(error Assertion failed: $2))
endef
# $(call assert-file-exists,wildcard-pattern)
define assert-file-exists
    $(call assert,$(wildcard $1),$1 does not exist)
endef
# $(call assert-not-null,make-variable)
define assert-not-null
    $(call assert,$($1),The variable "$1" is null)
endef

# This will detect the word git on the documentclass line. If git is used then the appropriate files will be generated.
ifeq ($(shell grep {bmtreport} $(key).tex | grep git),)
git_file:=
else
git_file:=git.tex
# https://stackoverflow.com/q/957928/1124489
git_root:=$(shell git rev-parse --show-toplevel)
endif

# If I do it this way rather than having multiple copies of the target, then there is less duplicate code that needs to be kept consistent.
ifeq (,$(wildcard $(key).csv))
diction_file:=
else
diction_file:=$(key).diction
endif

$(key).pdf: $(key).bcf $(key).tex
	lualatex --halt-on-error -draftmode "\PassOptionsToClass{normalwarnings}{bmtreport}\input{$(key)}"
	lualatex --halt-on-error $(key).tex

# https://tex.stackexchange.com/a/22525/9945
$(key).bcf title.tex abstract.tex subjclass.txt: $(key).tex $(key).bib $(git_file)
	lualatex --halt-on-error -draftmode "\PassOptionsToClass{normalwarnings}{bmtreport}\input{$(key)}"
	biber $(key) --validate-datamodel --fixinits --isbn13 --isbn-normalise
ifdef extra_runs
	lualatex --halt-on-error -draftmode "\PassOptionsToClass{normalwarnings}{bmtreport}\input{$(key)}"
	biber $(key) --validate-datamodel --fixinits --isbn13 --isbn-normalise
endif
	# Alert you to warnings.
	#! grep 'WARN - No data sources defined!' $(key).blg
	! grep 'WARN' $(key).blg

# https://thorehusfeldt.com/2011/05/13/including-git-revision-identifiers-in-latex/
# https://tex.stackexchange.com/q/455396/9945
# This'll return the latest for the entire repository, not the particular file.
# Can get for a series of files like this: git log -1 -- asserts.sty LICENSE
git.tex: $(git_root)/.git/logs/HEAD
	git log -1 --format="format:\\gdef\\GitHash{%h}" > $(git_file)

.PHONY: clean
clean: ## Clean up the document's folder
	-rm -rvf *.blg *.bcf *.log *.blg *.lot *.toc *.idx *.aux *.bbl *.lof *.out *.run.xml *.nav *.snm /tmp/par* abstract.tex title.tex *.tmp $(key).txt title.txt abstract.txt git.tex $(key).diction subjclass.txt

# old: detex -n $(key).tex > $(key).txt
# old version of Pandoc: pandoc --lua-filter=remove-math-and-images.lua --bibliography trettel_turbulent_2021.bib trettel_turbulent_2021.tex -s -t plain -o trettel_turbulent_2021.txt
# old version of Pandoc: echo '\nocite{*}' | pandoc -f latex --bibliography trettel_turbulent_2021.bib -s -t plain -o bibliography.txt
# TODO: Figure out how to make this file work if the bmtreport repo is located elsewhere such that a user does not need to modify this code and instead (e.g.) sets a variable or PATH elsewhere.
# https://tex.stackexchange.com/a/599425/9945
$(key).txt title.txt abstract.txt: $(key).tex $(key).bib title.tex abstract.tex
	pandoc --lua-filter=$$BMTPATH/remove-math-and-images.lua --bibliography $(key).bib $(key).tex -s --citeproc -t plain -o $(key).txt
	detex -n title.tex > title.txt
	detex -n abstract.tex > abstract.txt

$(key).diction: $(key).csv
	csv_to_diction.py $(key).csv
	aspell -c $(key).diction

# https://stackoverflow.com/a/60639947/1124489
#  | less -r -F --no-init
# TODO: Add abstract diction file and checking.
.PHONY: check
check: $(key).tex $(key).pdf $(key).txt title.tex abstract.tex subjclass.txt $(diction_file) ## Run spell check and other checkers
	aspell -t -c $(key).tex
	aspell -c $(key).txt
	grep -n '^%' trettel_turbulent_2021.bib | grep -v '% =' | grep -v '% ?' | less -r
	-bib_check.sh $(key).bib | less -r
	pdfgrep '\?' $(key).pdf | less -r
	chktex -q -I0 -n1 -n2 -n44 -n25 $(key).tex | less
	test -f $(key).diction && diction -sn -f $(key).diction $(key).txt | grep --color=always '\[[^][]*]' | less -r || true
	diction --suggest --file $$BMTPATH/diction/errors.diction $(key).txt | grep --color=always '\[[^][]*]' | less -r
	diction --suggest --file $$BMTPATH/diction/titles.diction title.txt | grep --color=always '\[[^][]*]' | less -r
	test -f $(key).sh && ./$(key).sh $(key).tex | less -r || true
	#test -f $(key)-eqcheck.ini && eqcheck.py $(key)-eqcheck.ini | less -r || true
	validate_subjclasses.py

.PHONY: todo
todo: $(key).tex ## List tasks to do
	grep -in TODO $(key).tex

# old: espeak -s 155 -v en-us --ipa -f $(key).txt
# <https://www.linuxlinks.com/speechtools/>
# <https://askubuntu.com/q/53896/39992>
# <https://news.ycombinator.com/item?id=28651588>
.PHONY: speak
speak: $(key).txt abstract.txt ## Read the document out loud
	$(eval tempdir:=$(shell mktemp -d))
	echo $(tempdir)
	cat abstract.txt | pico2wave -w $(tempdir)/abstract.wav
	mplayer $(tempdir)/abstract.wav
	cat $(key).txt | pico2wave -w $(tempdir)/$(key).wav
	mplayer $(tempdir)/$(key).wav
	rm -rv $(tempdir)/

.PHONY: pdflatex
pdflatex: $(key).tex ## Compile the document with pdflatex
	pdflatex --halt-on-error -draftmode "\PassOptionsToClass{normalwarnings}{bmtreport}\input{$(key)}"
	biber $(key) --validate-datamodel --fixinits --isbn13 --isbn-normalise
	pdflatex --halt-on-error -draftmode "\PassOptionsToClass{normalwarnings}{bmtreport}\input{$(key)}"
	pdflatex --halt-on-error $(key).tex

# <https://www.thapaliya.com/en/writings/well-documented-makefiles/>
.PHONY: help
help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
