# bmtreport and bmtslides classes for LaTeX, along with some Makefiles

## Installation

### Summary

Modify depending on where you keep this repository. The following works for me.

```
ln -s ~/repos/bmtreport/diction/titles.diction /usr/share/diction/titles
ln -s ~/repos/bmtreport/diction/bmt.diction /usr/share/diction/bmt
sudo ln -s ~/repos/bmtreport/bmt.mk /usr/local/include/
ln -s ~/repos/bmtreport/bmtreport.cls ~/texmf/tex/latex/
```

###

The Make include files should be symlinked in a [place that Make checks](https://www.gnu.org/software/make/manual/html_node/Include.html):

> the following directories (if they exist) are searched, in this order: `prefix/include` (normally `/usr/local/include`) `/usr/gnu/include`, `/usr/local/include`, `/usr/include`. 

TODO: How to install the class files locally.
