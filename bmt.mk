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
	lualatex --halt-on-error -draftmode $(key).tex
	lualatex --halt-on-error $(key).tex

$(key).bcf: $(key).tex
	lualatex --halt-on-error -draftmode "\PassOptionsToClass{normalwarnings}{bmtreport}\input{$(key)}"
	biber $(key) --validate-datamodel --fixinits --isbn13 --isbn-normalise

.PHONY: clean
clean:
	-rm -rvf *.blg *.bcf *.log *.blg *.lot *.toc *.idx *.aux *.bbl *.lof *.out *.run.xml /tmp/par* *.abstract abstract.tex title.tex *.tmp

.PHONY: check
check: $(key).tex
	aspell -t -c $(key).tex
	chktex -q -I0 -n1 -n2 -n44 -n25 $(key).tex
