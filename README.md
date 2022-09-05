# bmtreport and related classes for LaTeX, along with related writing scripts and databases

## Installation

Modify depending on where you keep this repository. The following works for me.

Add the following to your .bashrc file so that Make automatically recognizes files in `$HOME/.local/share/make/`, where stow will place the bmt.mk file:

    export MAKEFLAGS=--include-dir=$HOME/.local/share/make/
    export BMTPATH=$HOME/repos/bmtreport

cd to where you put your bmtreport repository. For me, that's `$HOME/repos/bmtreport/`. Then run the following to install bmtreport and make TeX aware of the installed TeX files:

    stow --target=../../ stow
    texhash

### diction notes

It is more convenient for me to keep the diction databases as CSV files, which I convert to diction databases with `csv_to_diction.py`. This allows me to edit the database with a spreadsheet program.

### Requirements

- lualatex
- pdflatex (optional)
- biber
- Pandoc
- Python 3 (for diction file generator script `csv_to_diction.py` and equation checking script `eqcheck`)
- bash (a [bash variable](https://stackoverflow.com/a/58233291/1124489) is used)
- pico2wave from libttspico-utils (for make speak)
- mplayer (for make speak)
- stow
