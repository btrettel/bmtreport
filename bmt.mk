# Copyright 2021 Ben Trettel.
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

# This will detect the word git on the documentclass line. If git is used then the appropriate files will be generated.
ifeq ($(shell grep {bmtreport} $(key).tex | grep git),)
git_file=
else
git_file=git.tex
# https://stackoverflow.com/q/957928/1124489
git_root:=$(shell git rev-parse --show-toplevel)
endif

$(key).pdf: $(key).bcf $(key).tex
	lualatex --halt-on-error -draftmode "\PassOptionsToClass{normalwarnings}{bmtreport}\input{$(key)}"
	lualatex --halt-on-error $(key).tex

# https://tex.stackexchange.com/a/22525/9945
$(key).bcf title.tex abstract.tex: $(key).tex $(key).bib $(git_file)
	lualatex --halt-on-error -draftmode "\PassOptionsToClass{normalwarnings}{bmtreport}\input{$(key)}"
	biber $(key) --validate-datamodel --fixinits --isbn13 --isbn-normalise
ifdef extra_runs
	lualatex --halt-on-error -draftmode "\PassOptionsToClass{normalwarnings}{bmtreport}\input{$(key)}"
	biber $(key) --validate-datamodel --fixinits --isbn13 --isbn-normalise
endif

# https://thorehusfeldt.com/2011/05/13/including-git-revision-identifiers-in-latex/
# https://tex.stackexchange.com/q/455396/9945
# This'll return the latest for the entire repository, not the particular file.
# Can get for a series of file like this: git log -1 -- asserts.sty LICENSE
git.tex: $(git_root)/.git/logs/HEAD
	git log -1 --format="format:\\gdef\\GitHash{%h}" > $(git_file)

.PHONY: clean
clean:
	-rm -rvf *.blg *.bcf *.log *.blg *.lot *.toc *.idx *.aux *.bbl *.lof *.out *.run.xml /tmp/par* *.abstract abstract.tex title.tex *.tmp $(key).txt title.txt abstract.txt git.tex

# https://stackoverflow.com/a/60639947/1124489
#  | less -r -F --no-init
# TODO: Add abstract diction file and checking.
.PHONY: check
check: $(key).tex title.tex abstract.tex
	aspell -t -c $(key).tex
	chktex -q -I0 -n1 -n2 -n44 -n25 $(key).tex | less
	detex -n $(key).tex > $(key).txt
	detex -n title.tex > title.txt
	detex -n abstract.tex > abstract.txt
	test -f $(key).diction && diction -sn -f $(key).diction $(key).txt | grep --color=always '\[[^][]*]' | less -r || true
	diction -s -L errors $(key).txt | grep --color=always '\[[^][]*]' | less -r
	diction -s -L title title.txt | grep --color=always '\[[^][]*]' | less -r
	test -f $(key).sh && ./$(key).sh $(key).tex | less -r || true
	test -f $(key)-eqcheck.ini && eqcheck.py $(key)-eqcheck.ini | less -r || true
	-rm -rvf $(key).txt title.txt abstract.txt

.PHONY: again
again: $(key).tex
	lualatex --halt-on-error -draftmode "\PassOptionsToClass{normalwarnings}{bmtreport}\input{$(key)}"
	biber $(key) --validate-datamodel --fixinits --isbn13 --isbn-normalise
	lualatex --halt-on-error -draftmode "\PassOptionsToClass{normalwarnings}{bmtreport}\input{$(key)}"
	lualatex --halt-on-error $(key).tex

.PHONY: once
once: $(key).tex
	lualatex --halt-on-error $(key).tex

.PHONY: todo
todo: $(key).tex
	grep -in TODO $(key).tex

.PHONY: pdflatex
pdflatex: $(key).tex
	pdflatex --halt-on-error -draftmode "\PassOptionsToClass{normalwarnings}{bmtreport}\input{$(key)}"
	biber $(key) --validate-datamodel --fixinits --isbn13 --isbn-normalise
	pdflatex --halt-on-error -draftmode "\PassOptionsToClass{normalwarnings}{bmtreport}\input{$(key)}"
	pdflatex --halt-on-error $(key).tex
