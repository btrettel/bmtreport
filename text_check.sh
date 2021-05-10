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
