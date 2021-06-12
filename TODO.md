# To-do list

- <https://www.dickimaw-books.com/latex/admin/>
- Tight feedback loop: (make quick or something like that?) (<https://news.ycombinator.com/item?id=20009123>):
   > So knowing this, my approach is to *use a system that continuously shows the typeset output* as I type, if I can. That way errors are usually obvious and easy to find. If that's not practical with your favorite editor, just manually run LaTex on your source frequently to see how your document is progressing. The times I've had to do serious puzzling over what was happening were almost always because I had pages of complex text entered before checking to see the output.
- <https://www.semipol.de/posts/2018/06/latex-best-practices-lessons-learned-from-writing-a-phd-thesis/>

## Files

- Add bmtcv.cls.
- Add bmtbook.cls.
- Finish make check.
- Convert existing writing check file to a diction file.
- DOUBTSS package
- eqcheck Python package; add to Python PATH
- Business card
- Invoice

## bmtreport.cls

- draft option
- refcheck
- Have flags for various manual checks, e.g., reading out loud.
- Add macros for the DOI, pagetotal, etc. Add these to XMP metadata, update the citation as appropriate, etc.
- maybe
   - Distribution list like some old DOD reports?
   - revision history/changelog after appendices
   - transparency/conflict-of-interest/research-integrity statement
   - top right of front page: QR code with link to article?
   - latexmk
   - Digital signature?
      - <https://tex.stackexchange.com/questions/30354/digital-signature>
      - <https://www.pdf-insecurity.org/>
      - <http://jsignpdf.sourceforge.net/>
         - <https://github.com/kwart/jsignpdf>
- later
   - Automatically embed files? embedfile does not seem to support LuaTeX.
   - Make CJK font available with a flag.
      - <https://en.wikipedia.org/wiki/List_of_CJK_fonts>
      - <https://tex.stackexchange.com/a/499992/9945>
   - Make PDF/A compliant.
      - Unicode is working nicely now for equations, at least, but it seems it'll be a while before the other requirements can easily be met.
      - <https://www.mathstat.dal.ca/~selinger/pdfa/>
      - <https://tex.stackexchange.com/a/545904/9945>
   - Standardize on LaTeX commands that pandoc can use in order to make conversion to HTML via pandoc as good as possible. Test conversion to HTML via pandoc.
      - `pandoc --bibliography file.bib file.tex -s --mathml -o ~/file.html`
      - Issues:
         - siunitx doesn't seem to work, though it seems that they added support for it?
         - Extra math commands from commath aren't recognized, making the equations not render.
         - pandoc does recognize my bib file correctly, but the inline citations are a bit mangled; the "p." part that starts many of optional arguments is cut off for some reason: "Wu (1992, 68, fig. 4.2)" should be "Wu (1992, p. 68, fig. 4.2)".

## Makefile

### make

- Change the Makefile to not assume that the bmtreport class was used, e.g., make switch to bmtslides. It compiles as-is but isn't strictly right.
- <https://github.com/atrettel/grfstyl/blob/master/tex-example/Makefile>
- <https://tex.stackexchange.com/questions/27878/pdflatex-bash-script-to-supress-all-output-except-error-messages>
- <https://tex.stackexchange.com/questions/tagged/warnings%2berrors?tab=Votes>
- <https://tex.stackexchange.com/questions/84246/warnings-and-errors-highlighting-when-compiling-in-bash-environment>
- Have local diction file to help catch issues specific to the local paper. local.diction. Make Makefile automatically recognize this and use it.
- Other ways to convert to plain text: <https://tex.stackexchange.com/q/102397/9945>
   - <https://github.com/pkubowicz/opendetex>

### make arxiv

- put everything in `arxiv/` directory
- change absolute filenames to relative
- <https://arxiv.org/help/faq/texlive>
- Use specific versions of pdflatex and biber per <https://tex.stackexchange.com/a/467471/9945>.
- <https://github.com/plk/biblatex/wiki/biblatex-and-the-arXiv>
- <https://tex.stackexchange.com/a/271460/9945>
- <https://github.com/djsutherland/arxiv-collector>
   - Might be best to avoid external dependencies and use your own script for this.
- <https://github.com/google-research/arxiv-latex-cleaner/>
- <https://tex.stackexchange.com/q/358831/9945>
- <https://tex.stackexchange.com/q/26990/9945>
- <https://news.ycombinator.com/item?id=21850466>

### make check

- Check text itself for particular phrases with diction and shell script for what diction can't handle. diction is preferred, however, as it can put the recommendations inline.
- For text which should not appear in the bibliography, write a Python script with an input CSV file rather than the clunky shell script. That'll be easier to manage in the long run.
- Use [TeXtidote](https://github.com/sylvainhalle/textidote) for grammar checking.
- <https://news.ycombinator.com/item?id=13297379>
- Add ability to make comments to diction CSV file and add commented out items from previous file.
- <https://github.com/get-alex/alex>
   - <https://www.reddit.com/r/programmingcirclejerk/comments/3kknoc/take_your_writing_to_a_next_level_without/>
   - <https://news.ycombinator.com/item?id=10199414>
- <http://proselint.com/>
   - <https://github.com/amperser/proselint>
   - <https://news.ycombinator.com/item?id=11232882>
- Plagiarism detection in case I accidentally produce something similar to something else.
   - Google search: command line plagiarism detection
   - <https://github.com/frizensami/plagiarism-basic>
   - <https://github.com/diogocabral/sherlock>

#### bib file checks

- Spell check the bib file.
- Check for whether smart or normal quotes are used in titles. Make consistent.
- Check that ILASS and ICLASS are set as the proceedings titles, with no conference names.
- Check all conference papers to make sure that editors were not set as authors.
- Check the end of each citation for a period.
- Check for proper capitalization of all titles.
- Check for broken links. <https://bootlin.com/blog/pdf-link-checker/>
- Check for missing page numbers. Every journal article and conference paper must have page numbers if they exist.
- Check that all DTIC links are to the correct reports.
- Search the bib file for "BibLateX quality report" and fix things as needed.
- Degree names are inconsistent. PhD vs. Dr.-Ing. vs. Candidate of Technical Sciences. The first is an abbreviation with no periods, the second an abbreviation with periods, and the last unabbreviated.
- Check for consistency with period at the end of the addendum. Should have no period in the typical case.
- Check that locations are consistent, e.g., using two letter abbreviations for states.

## tests for bmtreport and other classes

- Make sure that document compiles in both lualatex and pdflatex
- check PDF document information
- check log file
- (later) check that PDF/A compliant
- <https://tex.stackexchange.com/a/69086/9945>
- compile different specific test files to test different features, e.g., test each class option, e.g., have a file which will raise a warning to see if that leads to an error
- Make tests to ensure that metadata is present, etc.
- (manual test) Check XMP metadata in Adobe Acrobat on Windows.
- Run chktex, lacheck, and TeXidate on class and style files.

## Ambiguity detection

- <https://link.springer.com/chapter/10.1007/978-3-642-14192-8_20>
- site:github.com ambiguity detection
- <https://github.com/vaibhav29498/Cross-Domain-Ambiguity-Detection>
- <https://github.com/kach/nearley/issues/168>
- <https://github.com/nvasudevan/sinbad>
- <https://github.com/topics/text-detection-ambiguity>
