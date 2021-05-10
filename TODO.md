# To-do list

## Files

- Add bmtslides.cls.
- Add bmtcv.cls.
- Add bmt.mk
- Finish make check
- bmt-diction (Convert existing writing check file to a diction database.)
- DOUBTSS package
- TeXidote for grammar checking

## bmtreport.cls

- check PDF document information
- check log file
- check that PDF/A compliant
- <https://tex.stackexchange.com/a/69086/9945>
- compile different specific test files to test different features, e.g., test each class option, e.g., have a file which will raise a warning to see if that leads to an error
- Make tests to ensure that metadata is present, etc.
- Check XMP metadata in Adobe Acrobat on Windows.
- draft option
- refcheck
- Have flags for various manual checks, e.g., reading out loud.
- Add macros for the DOI, pagetotal, etc. Add these to XMP metadata, update the citation as appropriate, etc.
- maybe
   - Distribution list like some old DOD reports?
   - revision history/changelog after appendices
   - transparency/conflict-of-interest/research-integrity statement
   - top right of front page: QR code with link to article?
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

- Switch to LuaLaTeX with Make files and latexmk.
- <https://github.com/atrettel/grfstyl/blob/master/tex-example/Makefile>
- first run
   - `lualatex "\PassOptionsToClass{normalwarnings}{bmtreport}\input{bmtreport}"`
   - <https://tex.stackexchange.com/a/22525/9945>
- <https://tex.stackexchange.com/questions/27878/pdflatex-bash-script-to-supress-all-output-except-error-messages>
- <https://tex.stackexchange.com/questions/tagged/warnings%2berrors?tab=Votes>
- <https://tex.stackexchange.com/questions/84246/warnings-and-errors-highlighting-when-compiling-in-bash-environment>
- <https://www.oreilly.com/library/view/managing-projects-with/0596006101/ch06.html>: "Avoiding Duplicate Code"
- <http://gnu-make.2324884.n4.nabble.com/How-can-I-avoid-duplication-of-code-in-makefiles-td4784.html>
- Digital signature?
   - <https://tex.stackexchange.com/questions/30354/digital-signature>
   - <https://www.pdf-insecurity.org/>
   - <http://jsignpdf.sourceforge.net/>
      - <https://github.com/kwart/jsignpdf>

### make check

- check text itself for particular phrases
- Use list of phrases which are not allowed in bibliography, etc., rather than the clunky shell script.

### make test
