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

bibfile=$1

# Invalid ISSNs
# TODO: 0071-6251 ==> 0137-6462

if [ ! -f $bibfile ]
then
   echo -e "\033[1;31mFile does not exist. You might need to add .bib to the end of the addbibresource command.\033[0m"
   echo $bibfile
   echo
fi

# Check for papers with wrong page ranges.
if grep -n pages $bibfile | grep 'eoa\|--}' > /dev/null
then
   echo -e "\033[1;31mAdd page ranges.\033[0m"
   grep -n pages $bibfile | grep 'eoa\|--}'
   echo
fi

# Check for URLs with proxy in them.
if grep -n ezproxy $bibfile > /dev/null
then
   echo -e "\033[1;31mFix proxy URLs.\033[0m"
   grep -n ezproxy $bibfile
   echo
fi

# Check for URLs with dialog.proquest.com in them.
if grep -n 'dialog\.proquest\.com' $bibfile > /dev/null
then
   echo -e "\033[1;31mFix ProQuest Dialog URLs.\033[0m"
   grep -n 'dialog\.proquest\.com' $bibfile
   echo
fi

# \OCLC used incorrectly
if grep -n '\\OCLC ' $bibfile > /dev/null
then
   echo -e "\033[1;31m\\OCLC used incorrectly.\033[0m"
   grep -n '\\OCLC ' $bibfile
   echo
fi

## Use \OCLC.
#if grep -n 'OCLC: ' $bibfile > /dev/null
#then
   #echo -e "\033[1;31mUse \\OCLC.\033[0m"
   #grep -n 'OCLC: ' $bibfile
   #echo
#fi

# Use \ISSN.
if grep -n 'ISSN: ' $bibfile > /dev/null
then
   echo -e "\033[1;31mUse \\ISSN.\033[0m"
   grep -n 'ISSN: ' $bibfile
   echo
fi

# Use \DOI.
if grep -n 'DOI: ' $bibfile > /dev/null
then
   echo -e "\033[1;31mUse \\DOI.\033[0m"
   grep -n 'DOI: ' $bibfile
   echo
fi

# Change to bibtex[doi=] format.
if grep -n 'note = {DOI:' $bibfile > /dev/null
then
   echo -e "\033[1;31mChange to bibtex[doi=] format.\033[0m"
   grep -n 'note = {DOI:' $bibfile
   echo
fi

# Change to bibtex[] format.
if grep -n 'note = {MR:' $bibfile > /dev/null
then
   echo -e "\033[1;31mChange to bibtex[] format.\033[0m"
   grep -n 'note = {MR:' $bibfile
   echo
fi

# Change to bibtex[] format.
if grep -n 'note = {Zbl:' $bibfile > /dev/null
then
   echo -e "\033[1;31mChange to bibtex[] format.\033[0m"
   grep -n 'note = {Zbl:' $bibfile
   echo
fi

# Add closing square bracket.
if grep -n 'note = {bibtex' $bibfile > /dev/null
then
   echo -e "\033[1;31mAdd closing square bracket to bibtex[].\033[0m"
   grep -n 'note = {bibtex' $bibfile
   echo
fi

# Check for URLs with a note of 00000 in them, which is added by Zotero sometimes for no apparent reason.
if grep -n 'note = {000' $bibfile > /dev/null
then
   echo -e "\033[1;31mRemove citation count.\033[0m"
   grep -n 'note = {000' $bibfile
   echo
fi

# Check for entries with bad Library of Congress information that was not removed
if grep -n pages $bibfile | grep '\bfrom old catalog\b' > /dev/null
then
   echo -e "\033[1;31mRemove old catalog information.\033[0m"
   grep -n pages $bibfile | grep '\bfrom old catalog\b'
   echo
fi

# Check for DOI fields which have URLs in them
if grep -n 'doi =' $bibfile | grep http > /dev/null
then
   echo -e "\033[1;31mRemove http, etc. from DOIs.\033[0m"
   grep -n 'doi =' $bibfile | grep http
   echo
fi

# Check for OCLC fields which have DOIs in them
if grep -n 'oclc = {10\.' $bibfile > /dev/null
then
   echo -e "\033[1;31mChange OCLC field to DOI.\033[0m"
   grep -n 'oclc = {10\.' $bibfile
   echo
fi

# URLs which just point to DOIs.
if grep -n 'url =' $bibfile | grep doi\.org > /dev/null
then
   echo -e "\033[1;31mSwitch these URLs to DOIs.\033[0m"
   grep -n 'url =' $bibfile | grep doi\.org
   echo
fi

# Change the location to be consistent with other entries
if grep -n 'United States -- ' $bibfile > /dev/null
then
   echo -e "\033[1;31mChange the location to be consistent with other entries.\033[0m"
   grep -n 'United States -- ' $bibfile
   echo
fi

# Prefer PhD to Ph.{{D}}.
if grep -n 'Ph.{{D}}.' $bibfile > /dev/null
then
   echo -e "\033[1;31mPrefer PhD to Ph.{{D}}.\033[0m"
   grep -n 'Ph.{{D}}.' $bibfile
   echo
fi

# Prefer MS thesis.
if grep -n "type = {Master's" $bibfile > /dev/null
then
   echo -e "\033[1;31mPrefer MS thesis.\033[0m"
   grep -n "type = {Master's" $bibfile
   echo
fi

# Prefer PhD dissertation or PhD thesis.
if grep -ni 'type = {phd}' $bibfile > /dev/null
then
   echo -e "\033[1;31mPrefer PhD dissertation or PhD thesis.\033[0m"
   grep -ni 'type = {phd}' $bibfile
   echo
fi

# Prefer PhD dissertation or PhD thesis.
if grep -ni 'type = {{{PhD}}}' $bibfile > /dev/null
then
   echo -e "\033[1;31mPrefer PhD dissertation or PhD thesis.\033[0m"
   grep -ni 'type = {{{PhD}}}' $bibfile
   echo
fi

# Fix locations if they include "USA" in them, as I don't do that.
if grep -n 'location =' $bibfile | grep 'USA' > /dev/null
then
   echo -e "\033[1;31mFix locations if they include \"USA\" in them, as I don't do that.\033[0m"
   grep -n 'location =' $bibfile | grep 'USA'
   echo
fi

# Change SAE to Society of Automotive Engineers in the institution field.
if grep -n 'SAE Technical Paper' $bibfile > /dev/null
then
   echo -e "\033[1;31mChange SAE to Society of Automotive Engineers in the institution field.\033[0m"
   grep -n 'SAE Technical Paper' $bibfile
   echo
fi

# Change JFM ISSN to print ISSN (0022-1120).
if grep -n '0022-1120, 1469-7645' $bibfile > /dev/null
then
   echo -e "\033[1;31mChange JFM ISSN to print ISSN (0022-1120).\033[0m"
   grep -n '0022-1120, 1469-7645' $bibfile
   echo
fi

# Change JFM ISSN to print ISSN (0022-1120).
if grep -n '1469-7645, 0022-1120' $bibfile > /dev/null
then
   echo -e "\033[1;31mChange JFM ISSN to print ISSN (0022-1120).\033[0m"
   grep -n '1469-7645, 0022-1120' $bibfile
   echo
fi

# Change AAS ISSN to print ISSN (1044-5110).
if grep -n '1936-2684' $bibfile > /dev/null
then
   echo -e "\033[1;31mChange AAS ISSN to print ISSN (1044-5110).\033[0m"
   grep -n '1936-2684' $bibfile
   echo
fi

# 2019-12-06: Using just one or the other is okay. I recall that JFM is switching to online only.

# Use only one addendum.
if grep -n 'addendum = {addendum={' $bibfile > /dev/null
then
   echo -e "\033[1;31mUse only one addendum.\033[0m"
   grep -n 'addendum = {addendum={' $bibfile
   echo
fi

# Add the string "Abstract:" or "Abstracts:".
if grep -n 'addendum = {\\SLA' $bibfile > /dev/null
then
   echo -e "\033[1;31mAdd the string \"Abstract:\" or \"Abstracts:\".\033[0m"
   grep -n 'addendum = {\\SLA' $bibfile
   echo
fi
if grep -n 'addendum = {{\\SLA' $bibfile > /dev/null
then
   echo -e "\033[1;31mAdd the string \"Abstract:\" or \"Abstracts:\".\033[0m"
   grep -n 'addendum = {{\\SLA' $bibfile
   echo
fi
if grep -n 'addendum = {\\cite' $bibfile > /dev/null
then
   echo -e "\033[1;31mAdd the string \"Abstract:\" or \"Abstracts:\".\033[0m"
   grep -n 'addendum = {\\cite' $bibfile
   echo
fi

# Write "Abstract:" or "Abstracts:" not "Review:" or "Reviews".
if grep -n 'addendum = {Review' $bibfile > /dev/null
then
   echo -e "\033[1;31mWrite \"Abstract:\" or \"Abstracts:\" not \"Review:\" or \"Reviews\".\033[0m"
   grep -n 'addendum = {Review' $bibfile
   echo
fi

# Write "Abstract:" or "Abstracts:" not "Review:" or "Reviews".
if grep -n 'addendum = {{Review' $bibfile > /dev/null
then
   echo -e "\033[1;31mWrite \"Abstract:\" or \"Abstracts:\" not \"Review:\" or \"Reviews\".\033[0m"
   grep -n 'addendum = {{Review' $bibfile
   echo
fi

# change variations of the journal title Physics of Fluids
if grep -n 'The Physics of Fluids' $bibfile > /dev/null
then
   echo -e "\033[1;31mWrite Physics of Fluids.\033[0m"
   grep -n 'The Physics of Fluids' $bibfile
   echo
fi
if grep -n 'Physics of Fluids (1994-present)' $bibfile > /dev/null
then
   echo -e "\033[1;31mWrite Physics of Fluids.\033[0m"
   grep -n 'Physics of Fluids (1994-present)' $bibfile
   echo
fi
if grep -n 'Physics of Fluids (1958-1988)' $bibfile > /dev/null
then
   echo -e "\033[1;31mWrite Physics of Fluids.\033[0m"
   grep -n 'Physics of Fluids (1958-1988)' $bibfile
   echo
fi

# Remove \relax
if grep -n '$\\backslash$relax' $bibfile > /dev/null
then
   echo -e "\033[1;31mRemove \\relax.\033[0m"
   grep -n '$\\backslash$relax' $bibfile
   echo
fi
if grep -n '\\relax' $bibfile > /dev/null
then
   echo -e "\033[1;31mRemove \\relax.\033[0m"
   grep -n '\\relax' $bibfile
   echo
fi
# keys with relaxed names: natanzon_o_1938, natanzon_o_1938-1, natanzon_o_1938-2, natanzon_atomization_2018, trotsky_k_1933, shekhtman_k_1946, dityakin_avtokolebatelnyye_1948, borodin_neustoychivyye_1949, dityakin_ob_1954, dityakin_vliyanie_1957, dityakin_obobshcheniye_1959, borodin_o_1962, lashkov_[review_1963, borodin_o_1964, borodin_o_1964-1, skrebkov_pribory_1965, borodin_splitting_1968, voitsekhovsky_destruction_1972, weske_experimental_1974, dityakin_raspylivanie_1977, nikonov_razrushenie_1986, tonkonogiy_effect_1990, zuyev_experimental_1991
# Keywords to find others: Yu., Ya., Ye.

# Change to normal dash
if grep -n '–' $bibfile > /dev/null
then
   echo -e "\033[1;31mChange to normal dash.\033[0m"
   grep -n '–' $bibfile
   echo
fi

# Change to em dash
if grep -n '—' $bibfile > /dev/null
then
   echo -e "\033[1;31mChange to em dash.\033[0m"
   grep -n '—' $bibfile
   echo
fi

# Change to TeX quotes.
if grep -n '“' $bibfile > /dev/null
then
   echo -e "\033[1;31mChange to TeX quotes.\033[0m"
   grep -n '“' $bibfile
   echo
fi
if grep -n '”' $bibfile > /dev/null
then
   echo -e "\033[1;31mChange to TeX quotes.\033[0m"
   grep -n '”' $bibfile
   echo
fi

# Prefer new style DTIC URLs.
if grep -n 'www\.dtic' $bibfile > /dev/null
then
   echo -e "\033[1;31mChange to apps.dtic.mil.\033[0m"
   grep -n 'www\.dtic' $bibfile
   echo
fi

# Prefer HTTPS for DTIC.
if grep -n 'http://apps\.dtic' $bibfile > /dev/null
then
   echo -e "\033[1;31mPrefer HTTPS for DTIC.\033[0m"
   grep -n 'http://apps\.dtic' $bibfile
   echo
fi

# Prefer /sti for DTIC.
if grep -n 'apps\.dtic\.mil/docs/' $bibfile > /dev/null
then
   echo -e "\033[1;31mPrefer /sti for DTIC.\033[0m"
   grep -n 'apps\.dtic\.mil/docs/' $bibfile
   echo
fi
