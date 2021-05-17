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

$(key).pdf: $(key).bcf $(key).tex
	lualatex --halt-on-error -draftmode "\PassOptionsToClass{normalwarnings}{bmtreport}\input{$(key)}"
	lualatex --halt-on-error $(key).tex

$(key).bcf: $(key).tex
	# https://tex.stackexchange.com/a/22525/9945
	lualatex --halt-on-error -draftmode "\PassOptionsToClass{normalwarnings}{bmtreport}\input{$(key)}"
	biber $(key) --validate-datamodel --fixinits --isbn13 --isbn-normalise

.PHONY: clean
clean:
	-rm -rvf *.blg *.bcf *.log *.blg *.lot *.toc *.idx *.aux *.bbl *.lof *.out *.run.xml /tmp/par* *.abstract abstract.tex title.tex *.tmp $(key).txt

.PHONY: check
check: $(key).tex
	aspell -t -c $(key).tex
	chktex -q -I0 -n1 -n2 -n44 -n25 $(key).tex
	detex -n $(key).tex > $(key).txt
	test -f $(key).diction && diction -sn -f $(key).diction $(key).txt || true
	#diction -s -L bmt $(key).txt
	
	# Put whether to run on additional diction files in $(key).sh.
	test -f $(key).sh && ./$(key).sh $(key).tex || true

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
