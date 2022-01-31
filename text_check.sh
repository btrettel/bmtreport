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

# https://books.google.com/ngrams/graph?content=contraction+ratio%2Carea+ratio%2Cdiameter+ratio%2Ccontraction+area+ratio%2Ccontraction+diameter+ratio%2Carea+contraction+ratio%2Cdiameter+contraction+ratio&year_start=1800&year_end=2008&corpus=15&smoothing=3&share=&direct_url=t1%3B%2Ccontraction%20ratio%3B%2Cc0%3B.t1%3B%2Carea%20ratio%3B%2Cc0%3B.t1%3B%2Cdiameter%20ratio%3B%2Cc0%3B.t1%3B%2Ccontraction%20area%20ratio%3B%2Cc0%3B.t1%3B%2Carea%20contraction%20ratio%3B%2Cc0
grep -n --color '\bcontraction ratio\b' $1 | grep -v '\barea contraction ratio\b' | grep -v '\bdiameter contraction ratio\b' | grep --color '\bcontraction ratio\b' # before more specific: area contraction ratio or diameter contraction ratio (or switch area and contraction, etc.)

# math
grep -H -n -i --color '\\mathrm{sin}' $1 # \sin
grep -H -n -i --color '\\mathrm{cos}' $1 # \cos
grep -H -n -i --color '\\mathrm{tan}' $1 # \tan
grep -H -n -i --color '\\mathrm{log}' $1 # \log
grep -H -n -i --color '\\log(' $1 # Require subscript for the base (e.g. "\log_{base}(") or use \ln as these are unambiguous
# TODO: Add check for \log without subscript without parentheses.
grep -H -n -i --color '\\sin_{-1}' $1 # \arcsin
grep -H -n -i --color '\\cos_{-1}' $1 # \arccos
grep -H -n -i --color '\\tan_{-1}' $1 # \arctan
grep -H -n -i --color '\bLambert W\b' $1 # Lambert~W

# typography
grep -H -n -i --color '\[p\. ' $1 # use non-breaking space after page range
grep -H -n -i --color '\[pp\. ' $1 # use non-breaking space after page range
grep -H -n -i --color '\[pp\.~[0-9]*-[0-9]*\]' $1 # Ranges use en dash.
grep -H -n -i --color '\[figs\.~[0-9]*-[0-9]*\]' $1 # Ranges use en dash.

# TeX
grep -H -n -i --color '\\cite{}' $1
grep -H -n -i --color '\\citet{}' $1
grep -H -n -i --color '\^{1}' $1 # probably should be ^{-1}
grep -H -n -i --color '\^{2}' $1 # probably should be ^{-2}
grep -H -n -i --color '\\cdots' $1 # use \dots instead with amsmath as this apparently automatically aligns itself; see https://nickhigham.wordpress.com/2015/09/29/top-tips-for-new-latex-users/#comment-2512

grep -H -n -i --color '\bBenjamin M.\ Trettel\b' $1 # Ben Trettel

#at a \w+ rate # at/by/-(al)ly/delete, Fiske p. 55
#at the \w+ rate # at/by/-(al)ly/delete, Fiske p. 55
#solid [0-9]* seconds
#solid [0-9]* minutes
#solid [0-9]* hours
#solid [0-9]* days
#solid [0-9]* years
#[0-9]+ out of [0-9]+ # [0-9]+ (out) of [0-9]+
## TODO: $[0-9]+ USD+ # https://news.ycombinator.com/item?id=11238603
##TODO biography of a person's life # biography (of a person's life)
#a \w+ action # delete, Fiske p. 35R
#the \w+ action # delete, Fiske p. 35R
#\w+ activity # delete, Fiske p. 36L
#additional \w+ added # added, Fiske p. 36
#additional \w+ extra # extra, Fiske p. 36
#additional \w+ further # further, Fiske p. 36
#additional \w+ more # more, Fiske p. 36
#additional \w+ other # other, Fiske p. 36
#age \d+ # delete, Fiske p. 39L
#aged \d+ # delete, Fiske p. 39L
#aid in \wing # help, Fiske p. 39R
#all \w+ long # all, Fiske p. 40L
#allow \w+ to # let, Fiske p. 40R
#allow \w+ \w+ to # let, Fiske p. 40R
#and \w+ also;also/and;Fiske, To the point: a dictionary of concise writing p. 43L
#and \w+ \w+ also;also/and;Fiske, To the point: a dictionary of concise writing p. 43L
#and \w+ too;and/too;Fiske, To the point: a dictionary of concise writing p. 43R
#and \w, too;and/too;Fiske, To the point: a dictionary of concise writing p. 43R
#anywhere between \w+ and;between ... and;Fiske, To the point: a dictionary of concise writing p. 44R
#somewhere between \w+ and;between ... and;Fiske, To the point: a dictionary of concise writing p. 44R
#anywhere in the range of \w+ to;in the range of ... to;Fiske, To the point: a dictionary of concise writing p. 44R
#somewhere in the range of \w+ to;in the range of ... to;Fiske, To the point: a dictionary of concise writing p. 44R
#as a way for \w+ing;for (-ing)/so as to/to;Fiske, To the point: a dictionary of concise writing p. 49L
#as a way of \w+ing;for (-ing)/so as to/to;Fiske, To the point: a dictionary of concise writing p. 49L
#as a way to \w+ing;for (-ing)/so as to/to;Fiske, To the point: a dictionary of concise writing p. 49L
#ask \w+ the question;ask;Fiske, To the point: a dictionary of concise writing p. 51L
#assist in \w*ing;help;Fiske, To the point: a dictionary of concise writing
#as the basis for \w*ing;for (-ing)/so as to/to;Fiske, To the point: a dictionary of concise writing
#the most basic \w+ of all;the most basic \w+
#green [or blue or whatever] in color;green [or blue or whatever] (in color)
#in the past [0-9]+ days;before/earlier
#in the past [0-9]+ months;before/earlier
#in the past [0-9]+ weeks;before/earlier
#in the past [0-9]+ years;before/earlier
##is said to [verb];[verb]ies #(e.g., is said to vary;varies)
##TODO kill () dead;kill ()
#older than [0-9]+ years of age;older than [0-9]+ years of age
#soft in texture [or to the touch];soft (in texture) [or (to the touch)]
#younger than [0-9]+ years of age;younger than [0-9]+ years of age
#it is an aim of [[:blank:][:upper:][:lower:]]+ to;x aims to
#the intention of [[:blank:][:upper:][:lower:]]+ is to;X intends to
#used for [[:blank:][:upper:][:lower:]]+ purposes;used for xxx
#under [0-9]+ minutes or less;
#quick [0-9]+ minute;;Johnston, You can say that again: 750 redundant phrases to think twice about
#[0-9]+ different bridges;;Johnston, You can say that again: 750 redundant phrases to think twice about
#[0-9]+ separate buildings;;Johnston, You can say that again: 750 redundant phrases to think twice about
#top [0-9]+ most important criteria;;Johnston, You can say that again: 750 redundant phrases to think twice about
##TODO as far as I'm concerned;(as far as I'm concerned)
##TODO where () is concerned;about
## TODO: after ... first;Fiske, To the point: a dictionary of concise writing p. 38R
## TODO: after ... later/subsequently;Fiske, To the point: a dictionary of concise writing p. 38R
## TODO: after ... next;Fiske, To the point: a dictionary of concise writing p. 39L
## TODO: after ... then;Fiske, To the point: a dictionary of concise writing p. 39L
## TODO: again re;Fiske, To the point: a dictionary of concise writing p. 39L
## TODO: also ... as well;Fiske, To the point: a dictionary of concise writing p. 41R
## TODO: also ... too;Fiske, To the point: a dictionary of concise writing p. 41R
## TODO: -ance/-ence of;Fiske, To the point: a dictionary of concise writing p. 42R
## TODO: and ... as well;Fiske, To the point: a dictionary of concise writing p. 43L
## TODO: apart from ... also/as well;Fiske, To the point: a dictionary of concise writing p. 45L
## TODO: as/so far as ... (goes/is concerned);Fiske, To the point: a dictionary of concise writing p. 50L
## TODO: as ... for example/for instance;Fiske, To the point: a dictionary of concise writing p. 50R
#\b(an/the) area/locale/locality/location/place/point/position/region/site/spot where/whereever	Fiske, To the point: a dictionary of concise writing p. 45R	
#\b(an/the) area/locale/locality/location/place/point/position/region/site/spot	where/wherever	Fiske, To the point: a dictionary of concise writing p. 45R
#\bas of (date)	about/from/on
#\bas of (date)	about, from, on (verbose)
##\bas (the) days/decades/months/weeks/years go on	Fiske, To the point: a dictionary of concise writing p. 50L
##\bat (a/the) ... pace (of)	Fiske, To the point: a dictionary of concise writing p. 55
##\b(a/the) ... attitude (of)	Fiske, To the point: a dictionary of concise writing p. 58
##\b(a/the) ... being	Fiske, To the point: a dictionary of concise writing p. 62
##\bbear (a/the) ... resemblance/similarity to	Fiske, To the point: a dictionary of concise writing p. 61
##\bDr. () MD	Dr. ()/() MD	what about PhDs?
##\b(even) as I/we speak	Fiske, To the point: a dictionary of concise writing p. 51L
##\b(the) ... area (of)	Fiske, To the point: a dictionary of concise writing p. 45R
#\bas compared to/with ... relatively	Fiske, To the point: a dictionary of concise writing p. 49R
#\baside from ... also/as well	Fiske, To the point: a dictionary of concise writing p. 51L
#\bas opposed to ... relatively	Fiske, To the point: a dictionary of concise writing
#\bassure/ensure/insure	guarantee	Fiske, To the point: a dictionary of concise writing
#\battention ... focused on/upon	Fiske, To the point: a dictionary of concise writing p. 56
#\bat that moment, etc.	Fiske, To the point: a dictionary of concise writing p. 56
#\bat what/which...	Fiske, To the point: a dictionary of concise writing p. 58
#\bbefore ... First	(verbose)	Fiske, To the point: a dictionary of concise writing p. 61
#\bbegin ... first	Fiske, To the point: a dictionary of concise writing p. 61
#\bbegin/start at ... and end/finish at	Fiske, To the point: a dictionary of concise writing p. 61
#\bbesides ... also/as well	Fiske, To the point: a dictionary of concise writing p. 62
#\bbetween ... as compared to/as opposed to/compared to/versus	Fiske, To the point: a dictionary of concise writing p. 62
