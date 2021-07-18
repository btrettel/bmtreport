grep --color -i '^on the\b' $tempdir/title.txt
grep --color -i '^on\b' $tempdir/title.txt
grep --color -i '\btaking \w* seriously\b' $tempdir/title.txt # https://www.currentaffairs.org/2015/07/taking-taking-seriously-seriously
grep --color -i '\btaking \w* \w* seriously\b' $tempdir/title.txt # https://www.currentaffairs.org/2015/07/taking-taking-seriously-seriously
grep --color -i '\bwhy \w* matters\b' $tempdir/title.txt # https://www.currentaffairs.org/2015/07/taking-taking-seriously-seriously
grep --color -i '\bwhy \w* \w* matters\b' $tempdir/title.txt # https://www.currentaffairs.org/2015/07/taking-taking-seriously-seriously
grep --color -i '"' $tempdir/title.txt # No quotes in titles.
grep --color -i "''" $tempdir/title.txt # No quotes in titles.
grep --color -i '``' $tempdir/title.txt # No quotes in titles.
#grep --color -i "\bwhat's in a name\b" $tempdir/title.txt
grep --color -i "\bwhat's in a\b" $tempdir/title.txt
grep --color -i '^towards\b' $tempdir/title.txt # https://academia.stackexchange.com/questions/55285/is-this-a-tired-phrase-journal-article-titles-that-start-with-towards-a-the
grep --color -i '^a proof\b' $tempdir/title.txt # https://www.youtube.com/watch?v=tJZpdXWm4Gg
grep --color -i '^A\b' $tempdir/title.txt # https://www.uspto.gov/web/offices/pac/mpep/s606.html
grep --color -i '^An\b' $tempdir/title.txt # https://www.uspto.gov/web/offices/pac/mpep/s606.html
grep --color -i '^The\b' $tempdir/title.txt # https://www.uspto.gov/web/offices/pac/mpep/s606.html
grep --color -i '^Improved\b' $tempdir/title.txt # https://www.uspto.gov/web/offices/pac/mpep/s606.html
grep --color -i '^Improvement\b' $tempdir/title.txt # https://www.uspto.gov/web/offices/pac/mpep/s606.html
grep --color -i '^Improvements\b' $tempdir/title.txt # https://www.uspto.gov/web/offices/pac/mpep/s606.html
grep --color -i '^Design\b' $tempdir/title.txt # https://www.uspto.gov/web/offices/pac/mpep/s606.html
grep --color -i '^Designs\b' $tempdir/title.txt # https://www.uspto.gov/web/offices/pac/mpep/s606.html
grep -H -n -i --color '\b,,\b' $1 # double
grep -H -n -i --color '\b\.\.\b' $1 # double
grep -H -n -i --color '\b??\b' $1 # double
grep -H -n -i --color '\b::\b' $1 # double
grep -H -n -i --color '\b;;\b' $1 # double
grep -H -n -i --color "\b''\b" $1 # double
grep -H -n -i --color '\b""\b' $1 # double
grep -H -n -i --color ' ~' $1 # change to just one whitespace?
grep -H -n -i --color ' ,' $1 # whitespace before comma seems wrong
grep -H -n -i --color ' \.' $1 # whitespace before period seems wrong
grep -H -n -i --color '~\.' $1 # whitespace before period seems wrong
grep -H -n -i --color ',\s*\w+(?:\s+\w+)*,\s*\w+(?:\s+\w+)* and\b' $1 # Oxford comma, https://stackoverflow.com/a/39979115
grep -H -n -i --color 'equation [0-9]+' $1 # use equation labels
grep -H -n -i --color 'equation~[0-9]+' $1 # use equation labels
grep -H -n -i --color 'equations [0-9]+' $1 # use equation labels
grep -H -n -i --color 'equations~[0-9]+' $1 # use equation labels
grep -H -n -i --color '\binsert \w* here\b' $1 # motivated by https://commons.wikimedia.org/wiki/File:Insert_statistical_method_here_-_BMC_Systems_Biology_2011_-_5(Suppl_3)_-_S4.png
grep -H -n -i --color '\binsert \w* \w* here\b' $1
grep -H -n -i --color '\binsert \w* \w* \w* here\b' $1
grep -H -n -i --color '\badd \w* here\b' $1
grep -H -n -i --color '\badd \w* \w* here\b' $1
grep -H -n -i --color '\badd \w* \w* \w* here\b' $1
#grep -H -n -i --color '\bpseudo-[a-z]\b' $1
#grep -H -n -i --color '\b[a-z]-gate\b' $1
grep -H -n -i --color '\bfall flat on \w* face\b' $1
grep -H -n -i --color '\bup to [1-9a-f%]\b' $1 # like "up to sixty percent"
grep -H -n -i --color '\bmore than [1-9a-f%]\b' $1
grep -H -n -i --color '\b[0-9]+ out of [0-9]+\b' $1 # [0-9]+ (out) of [0-9]+
# TODO: grep -H -n -i --color '\b$[0-9]+ USD+\b' $1 # https://news.ycombinator.com/item?id=11238603
#TODO \bwhere () is concerned/about
#TODO \bbiography of a person's life # biography (of a person's life) (verbose)
#TODO \bkill () dead # kill () (verbose)
#\bgreen [or blue or whatever] in color # green [or blue or whatever] (in color) (verbose)
#"#\bDr. () MD","Dr. (), () MD # what about PhDs? (verbose)",
#"\bin the past [0-9]+ days","before, earlier (verbose)",
#"\bin the past [0-9]+ months","before, earlier (verbose)",
#"\bin the past [0-9]+ weeks","before, earlier (verbose)",
#"\bin the past [0-9]+ years","before, earlier (verbose)",
#"#\bis said to [verb]","[verb]ies #(e.g., is said to vary (verbose)",
#"\bolder than [0-9]+ years of age","older than [0-9]+ years of age (verbose)",
#\byounger than [0-9]+ years of age,younger than [0-9]+ years of age (verbose),
#in an X manner;Xly, e.g., "hastily" instead of "in a hasty manner";volokh_how_2009
#accord (verb);give;volokh_how_2009
#attempt (verb);try;volokh_how_2009
#evidence (verb);show/demonstrate;volokh_how_2009
#exhibit (verb);show/demonstrate;volokh_how_2009
#exit (verb);leave;volokh_how_2009
#individual (noun);person;volokh_how_2009
#request (verb);ask;volokh_how_2009
#objective (noun);goal;volokh_how_2009
#said (adjective);the or this ("this contract" not "said contract");volokh_how_2009
#\b(^order of) magnitude;size (verbose);http://stevehanov.ca/blog/?id=52
