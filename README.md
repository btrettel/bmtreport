# bmtreport and related classes for LaTeX, along with related writing scripts and databases

## Installation

Modify depending on where you keep this repository. The following works for me.

```
sudo ln -s ~/repos/bmtreport/diction/errors.diction /usr/share/diction/errors
sudo ln -s ~/repos/bmtreport/diction/fluids.diction /usr/share/diction/fluids
sudo ln -s ~/repos/bmtreport/diction/patents.diction /usr/share/diction/patents
sudo ln -s ~/repos/bmtreport/diction/titles.diction /usr/share/diction/titles
sudo ln -s ~/repos/bmtreport/diction/translations.diction /usr/share/diction/translations
sudo ln -s ~/repos/bmtreport/diction/warnings.diction /usr/share/diction/warnings
sudo ln -s ~/repos/bmtreport/bmt.mk /usr/local/include/
ln -s ~/repos/bmtreport/asserts.sty ~/texmf/tex/latex/
ln -s ~/repos/bmtreport/bmtreport.cls ~/texmf/tex/latex/
ln -s ~/repos/bmtreport/bmtmacros.sty ~/texmf/tex/latex/
ln -s ~/repos/bmtreport/bmtslides.cls ~/texmf/tex/latex/
texhash
```

### Details for diction

While the `-f` flag allows specification of a diction database, the databases in the `/usr/share/diction/` directory seem to be selected with the `-L` flag. While intended for languages, I want the command to be global, so I am using the `-L` flag in the Makefile.

It is more convenient for me to keep the diction databases as CSV files, which I convert to diction datbases with `csv_to_diction.py`. This allows me to edit the database with a spreadsheet program.

#### Details for make

The Make include files should be symlinked in a [place that Make checks](https://www.gnu.org/software/make/manual/html_node/Include.html):

> the following directories (if they exist) are searched, in this order: `prefix/include` (normally `/usr/local/include`) `/usr/gnu/include`, `/usr/local/include`, `/usr/include`. 
