# To-do list

## Files

- Add bmtslides.cls.
- Add bmtcv.cls.
- Finish make check.
- Convert existing writing check file to a diction file.
- DOUBTSS package
- Use [TeXtidote](https://github.com/sylvainhalle/textidote) for grammar checking.

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

## bmtslides.cls

- Make beamer version of this. Use Fira Math?
   - <https://github.com/firamath/firamath>
   - https://tug.org/FontCatalogue/firasansmath/>
   - https://en.wikipedia.org/wiki/Fira_(typeface)>
   - https://fonts.google.com/specimen/Fira+Sans>

## Makefile

### make

- <https://github.com/atrettel/grfstyl/blob/master/tex-example/Makefile>
- <https://tex.stackexchange.com/questions/27878/pdflatex-bash-script-to-supress-all-output-except-error-messages>
- <https://tex.stackexchange.com/questions/tagged/warnings%2berrors?tab=Votes>
- <https://tex.stackexchange.com/questions/84246/warnings-and-errors-highlighting-when-compiling-in-bash-environment>

### make check

- Check text itself for particular phrases with diction and shell script for what diction can't handle. diction is preferred, however, as it can put the recommendations inline.
- For text which should not appear in the bibliography, write a Python script with an input CSV file rather than the clunky shell script. That'll be easier to manage in the long run.

## tests for bmtreport and other classes

- Make sure that document compiles in both lualatex and pdflatex
- check PDF document information
- check log file
- (later) check that PDF/A compliant
- <https://tex.stackexchange.com/a/69086/9945>
- compile different specific test files to test different features, e.g., test each class option, e.g., have a file which will raise a warning to see if that leads to an error
- Make tests to ensure that metadata is present, etc.
- (manual test) Check XMP metadata in Adobe Acrobat on Windows.
