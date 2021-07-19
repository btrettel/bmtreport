#!/usr/bin/env bash
# https://github.com/anordal/shellharden/blob/master/how_to_do_things_safely_in_bash.md
# https://lobste.rs/s/ajoaje/first_two_statements_your_bash_script
if test "$BASH" = "" || "$BASH" -uc "a=();true \"\${a[@]}\"" 2>/dev/null; then
   # Bash 4.4, Zsh
   set -euo pipefail
else
   # Bash 4.3 and older chokes on empty arrays with set -u.
   set -eo pipefail
fi
shopt -s nullglob globstar

for f in *.csv
do
   sort $f | uniq > temp.csv
   mv -f temp.csv $f
   python3 ../csv_to_diction.py $f
done

# spell check the diction files
for f in *.diction
do
   aspell --home-dir=../ -c $f
   # The home-dir option allows me to use a different dictionary for spell checking the diction files than is used for normal spell checking. This is desirable as I may want words that appear in the diction files to be marked as spelling errors in aspell. That'll mean that I have two opportunities to spot the error.
done
