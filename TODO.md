# To-do list

- Use a LaTeX subset that is widely compatible.
    - targets:
        - arXiv
        - Physical Review Fluids
        - Journal of Fluid Mechanics
        - Atomization and Sprays
        - International Journal of Multiphase Flows
        - Journal of Fluids Engineering
        - ILASS-Americas
        - ICLASS
        - TeX Live
            - Debian/Ubuntu base package subset
                - texlive-latex-recommended
                - <https://tex.stackexchange.com/a/504566>
                - <https://tex.stackexchange.com/a/13601/9945>
            - <https://wiki.archlinux.org/title/TeX_Live#Arch-packaged_TeX_Live>
        - MikTeX
        - Overleaf
        - various LaTeX compilers
            - `latex` - how to obtain?
            - `pdflatex`
            - `lualatex`
            - <https://tug.org/levels.html>
        - converters
            - <https://en.wikipedia.org/wiki/LaTeX#Compatibility_and_converters>
            - <https://github.com/arxiv-vanity/engrafo/issues/159>
            - <http://hevea.inria.fr/>
                - `sudo apt install hevea`
                - <https://github.com/maranget/hevea>
                - <http://hevea.inria.fr/doc/manual007.html#both>
            - <https://www.latex2html.org/>
                - `sudo apt install latex2html`
                - <https://github.com/latex2html/latex2html/blob/master/docs/features.tex>
            - <https://tug.org/tex4ht/>: > it supports most LaTeX packages and custom commands, including: BibLaTeX, TikZ, Fontspec
                - in TeX Live
            - <https://en.wikipedia.org/wiki/LaTeXML>: > LaTeXML supports a large range of LaTeX packages
                - `sudo apt install latexml`
                - Used by these:
                    - <https://www.arxiv-vanity.com/>
                    - <https://ar5iv.labs.arxiv.org/>
                - <https://github.com/arxiv-vanity/engrafo/issues/159>
                - <https://github.com/brucemiller/LaTeXML>
                - <https://web.archive.org/web/20190327205151/https://math.nist.gov/~BMiller/LaTeXML/manual/included.bindings/>
                    - This should correspond to the version Ubuntu 20.04 LTS has.
            - <https://en.wikipedia.org/wiki/Pandoc>: > any of five formats: BibTeX, BibLaTeX, CSL JSON or CSL YAML, or RIS
                - `sudo apt install pandoc`
            - latex2man
                - in TeX Live
            - <https://academ.us/>
            - latex2rtf
                - <https://latex2rtf.sourceforge.net/>
                - <https://ctan.org/pkg/latex2rtf?lang=en>
                    - > many packages are supported (in whole or as implementation of a subset of their commands) — for example, the whole of natbib is implemented.
                - <https://github.com/magsilva/latex2rtf>
            - TTH
            - tex2page
                - <http://ds26gte.github.io/tex2page/index.html>
            - <https://ctan.org/topic/cvt-html>
            - comparison table (latex-subsets.xml)
            - text extraction
                - This highlights the importance of making the text accessible, using Unicode math, and hiding text like line numbers.
                - `pdf2txt`
                - <https://github.com/karpathy/arxiv-sanity-preserver>
        - subsets of TeX intended for equations on web pages
            - itex
                - <https://golem.ph.utexas.edu/~distler/blog/itex2MMLcommands.html>
                - <https://jblevins.org/notes/itex>
            - MathJax
                - <https://docs.mathjax.org/en/latest/input/tex/differences.html>
        - subset that is easy to spell check with aspell...
        - <https://www.latex-project.org/get/>
        - subsets that make linters happy
            - <https://tex.stackexchange.com/questions/418500/how-to-use-a-linter-with-latexmk>
            - <https://tex.stackexchange.com/questions/163/is-there-a-program-equivalent-to-lint-for-latex>
    - far fewer dependencies
    - reduce number of external files; have one for things common to reports/slides, one for reports, and one for slides
    - bibtex, not biblatex
        - You can use biber with BibTeX, *except with natbib*, unfortunately: <https://en.wikipedia.org/wiki/Biber_(LaTeX)>. I suppose sticking to notation that's common to both the BibTeX natbib and BibLaTeX's reimplementation is safest. Switching to BibTeX itself would require changes to your Zotero entries, unfortunately.
    - compiles in at least pdflatex and lualatex
- Improve compilation time.
- Reduce the number of files.
    - <https://tex.stackexchange.com/questions/116719/how-can-i-balance-uniformity-of-style-files-against-modularity>
- Makefile
    - Compatible with both GNU and BSD Make.
    - Simpler and shorter.
    - No recursive Make.
    - `latexmk`
        - <https://lobste.rs/s/sq9h3p/unreasonable_effectiveness_makefiles#c_v7pkr0>
    - figures
        - .gp (gnuplot)
        - Compile xfig files with transfig: <https://news.ycombinator.com/item?id=31224924>
- Simple examples and templates.
    - <https://www.fooledbyrandomness.com/bmn.pdf>
    - <https://github.com/davidwhogg/DataAnalysisRecipes>    
- No unique numbering.
- Include comments in template on what to include in abstract, introduction, conclusions, etc.
- Generic (works on any language) regex linter with input file similar to what Flint uses (YAML), not what plint uses (CSV). Could use configparser and `.sections()` to get all sections. Could have lists at the end like Flint.
- PDFs produced by LaTeX: less than 80 characters per line so that it'll fit in a terminal properly (74 on my monitor)

## Old

- Split bmtreport.cls further so that you can use various checks and metadata adding and whatnot in other class files
- Simplify all files to have less dependencies. Remove line numbers as few would use them.
- Make more similar to this: <https://www.cs.princeton.edu/~bwk/202/index.html>
- Reduce dependencies to better future-proof. <https://tex.stackexchange.com/a/664793/9945>
- <https://www.dickimaw-books.com/latex/admin/>
- Tight feedback loop: (make quick or something like that?) (<https://news.ycombinator.com/item?id=20009123>):
    > So knowing this, my approach is to *use a system that continuously shows the typeset output* as I type, if I can. That way errors are usually obvious and easy to find. If that's not practical with your favorite editor, just manually run LaTex on your source frequently to see how your document is progressing. The times I've had to do serious puzzling over what was happening were almost always because I had pages of complex text entered before checking to see the output.
- <https://www.semipol.de/posts/2018/06/latex-best-practices-lessons-learned-from-writing-a-phd-thesis/>
- root-mean-square vs. root-mean-squared vs. root mean square (etc.) (Check Google Ngram. Require dashes?)
- Switch to a structured abstract.
- Break up sections into multiple files?
    - <https://academia.stackexchange.com/a/180254/31143>
    - <https://tex.stackexchange.com/q/29577/9945>
- TODO: Switch to cumulative numbering of all personal reports, presentations, notes, etc.

## Files

- Add bmtbook.cls.
- Finish make check.
- Convert existing writing check file to a diction file.
- DOUBTSS package
- eqcheck Python package; add to Python PATH
- Business card
- Invoice
- Writing checklist
    - List the person you have in mind when writing.
        - <https://jvns.ca/blog/confusing-explanations/#pattern-2-having-inconsistent-expectations-of-the-reader-s-knowledge>: > instead: pick 1 specific person and write for them!

## bmtreport.cls

- draft option
- Have flags for various manual checks, e.g., reading out loud.
- Add macros for the DOI, pagetotal, etc. Add these to XMP metadata, update the citation as appropriate, etc.
- Make environments for standardized sections like the introduction and conclusions. These will automatically define the labels in a standardized way (for example, `\label{sec:introduction}`) and automatically enforce word counts.
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
    - Add macros to bmtreport to keep track of important/critical lessons you want the paper to make. These will need to be put early in the paper (inverted pyramid) and be repeated later in the paper for spaced repetition.
    - <https://nhigham.com/2020/06/18/six-useful-latex-packages/>: > By loading the upref package you ensure that every \ref or \eqref reference is set in an upright font. This is normal typesetting practice, but it is not enforced by all \LaTeX classes. It is enforced by the SIAM class, for example.
    - cleverref package instead of non-standard macros?
    - topic sentences:
        - <https://web.eecs.utk.edu/~azh/blog/lessonsfrommyphd.html>
        - <https://news.ycombinator.com/item?id=29723973>
- later
    - Automatically embed files? embedfile does not seem to support LuaTeX.
    - Make CJK font available with a flag.
        - <https://en.wikipedia.org/wiki/List_of_CJK_fonts>
        - <https://tex.stackexchange.com/a/499992/9945>
    - Make PDF/A compliant.
        - Unicode is working nicely now for equations, at least, but it seems it'll be a while before the other requirements can easily be met.
        - <https://www.mathstat.dal.ca/~selinger/pdfa/>
        - <https://tex.stackexchange.com/a/545904/9945>
        - <https://shen.hong.io/reproducible-pdfa-compliant-latex/>
            - <https://news.ycombinator.com/item?id=32202571>
    - Standardize on LaTeX commands that pandoc can use in order to make conversion to HTML via pandoc as good as possible. Test conversion to HTML via pandoc.
        - `pandoc --bibliography file.bib file.tex -s --mathml -o ~/file.html`
        - Issues:
             - siunitx doesn't seem to work, though it seems that they added support for it?
             - Extra math commands from commath aren't recognized, making the equations not render.
             - pandoc does recognize my bib file correctly, but the inline citations are a bit mangled; the "p." part that starts many of optional arguments is cut off for some reason: "Wu (1992, 68, fig. 4.2)" should be "Wu (1992, p. 68, fig. 4.2)".
    - <https://github.com/synercys/annotated_latex_equations>
        - <https://twitter.com/sibinmohan/status/1480583840858996743>
        - <https://news.ycombinator.com/item?id=29898655> (many other similar ideas here)

## bmtslides.cls

- Follow USPTO internal presentation guidelines.
    - Have a macro for the "Thank you" closing slide.
- Since James Chen (and presumably others) didn't like my minimalist slide style (he seemed to think it was unprofessional), try something more typical. John Lienhard has a nice format that uses the Fira fonts and seems to be a modification of a standard Beamer template: <https://dspace.mit.edu/bitstream/handle/1721.1/124894/Turb-bl-lecture-for-posting.pdf> (lienhard_heat_2020-1).

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

- put everything in `arxiv/` directory, zip it
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
- <https://tex.stackexchange.com/q/83663>
- <https://terrytao.wordpress.com/2017/07/07/what-are-some-useful-but-little-known-features-of-the-tools-used-in-professional-mathematics/#comment-551741>
- <https://news.ycombinator.com/item?id=29352868>
- <https://www.cmcrossroads.com/article/making-directories-gnu-make>
- <https://github.com/adynathos/tex-submission-purify>
- <https://converged.yt/notes/lyx_arxiv>
- <https://tex.stackexchange.com/q/500160/9945>

### make check

- Check text itself for particular phrases with diction and shell script for what diction can't handle. diction is preferred, however, as it can put the recommendations inline.
- For text which should not appear in the bibliography, write a Python script with an input CSV file rather than the clunky shell script. That'll be easier to manage in the long run.
- Use [TeXtidote](https://github.com/sylvainhalle/textidote) for grammar checking.
    - <https://sylvainhalle.github.io/textidote/>
    - <https://github.com/sylvainhalle/textidote>
    - <http://wiki.languagetool.org/checking-la-tex-with-languagetool>
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
- List warnings in make check.
- Make Makefile detect document class used to pass warningsaserrors appropriately. Or pass warningsaserrors to all bmt document classes to catch them all? What happens if that document class is not loaded? Nothing?
- ambiguity detection
    - <https://cs.nyu.edu/~davise/ai/ambiguity.html>
- Disable detection of double words for diction -L tex
- Find most commonly used words in your document, switch with most common versions of each *in general* (not just in your document).
    - <https://unix.stackexchange.com/questions/41479/find-n-most-frequent-words-in-a-file>
    - <https://superuser.com/questions/799440/create-a-word-cloud-on-linux-command-line>
- Tasks for each document to list and manually check off:
    - Keyword/keyphrase research
    - DOUBTSS
    - Reading over, reading out loud, reading backwards
    - Getting external feedback
- Check that you refer to the figures in the body of the paper in numerical order.
- Check equations for closed parentheses.
- <https://github.com/redpen-cc/redpen>
- Check that page ranges are possible, for example, pages 115-101 is unlikely to be right. <https://academia.stackexchange.com/a/173146/31143>
- Check for titles, journal names, etc., in all caps.
- Check for \todo commands.
- Some ideas from users of Kedit.
    - <https://signalsandthreads.com/writing-technically/>
    - <https://www.newyorker.com/magazine/2013/01/14/structure>
- <https://www.researchinformation.info/analysis-opinion/language-barrier-publishing>
    - "NLP for automated proofreading"
- <https://github.com/Kingsford-Group/biblint>
    - <https://news.ycombinator.com/item?id=29340573>
- <https://github.com/nbartlomiej/lisense>
- <https://news.ycombinator.com/item?id=4454070>
    - <http://backreaction.blogspot.com/2011/07/blablameter.html>
- CRM114
    - Can use instead of text_check.sh for checks too advanced for diction, and can also use as a classifier for things more difficult to create simple rules for.
    - <https://en.wikipedia.org/wiki/CRM114_(program)>
    - <https://news.ycombinator.com/item?id=30276212>
    - <https://news.ycombinator.com/item?id=124281>
    - <http://crm114.sourceforge.net/wiki/doku.php?id=books>
        - <http://crm114.sourceforge.net/docs/CRM114_Revealed_20061010.pdf> p. 172
    - Use something like [this](https://unix.stackexchange.com/a/157607) to have comments in the text file that are automatically filtered out:
        - `grep -o '^[^#]*' file | xargs --delimiter=\\n --max-args=1 crm learn.crm A`
            - 2022-06-29: This doesn't seem to train CRM114.
        - Note that xargs will trim whitespace so you could have a space before the comment character. For example `This is a sentence. # source` will be piped as `This is a sentence.`.
            - <https://stackoverflow.com/a/12973694>
        - Run both on the text as a whole and each sentence individually. Each sentence individually will help locate the source of problems, but it's possible that the text as a whole is a problem while each individual sentence is not.
        - The xargs arguments are needed to train CRM114 for each line separately. <https://stackoverflow.com/a/28806991>
    - Use classification to estimate probability that:
        - passage is offensive
        - patent claim is indefinite
             - alderucci_using_2020
- typo
    - <https://research.swtch.com/bell-labs>
        - > Another of my favorites, and again Lorinda Cherry was in this one, with Bob Morris, was typo. This was a program for finding spelling errors. It didn’t know the first thing about spelling. It would read a document, measure its statistics, and print out the words of the document in increasing order of what it thought the likelihood of that word having come from the same statistical source as the document. The words that did not come from the statistical source of the document were likely to be typos, and now I mean typos as distinct from spelling errors, where you actually hit the wrong key. Those tend to be off the wall, whereas phonetic spelling errors you’ll never find. And this worked remarkably well. Typing errors would come right up to the top of the list. A really really neat program.
    - <https://en.wikipedia.org/wiki/Lorinda_Cherry>
        - > > Out of that work came the remarkable typo, which spotted typing errors by statistical inference
    - <https://news.ycombinator.com/item?id=22582815>
    - <https://news.ycombinator.com/item?id=22582644>
    - <https://github.com/robpike/typo>
- Writer's Workbench
    - <https://en.wikipedia.org/wiki/Writer%27s_Workbench>
    - <https://web.archive.org/web/20160313131946/http://www2.parc.com/isl/groups/nltt/medley/>
    - <http://ftp.icm.edu.pl/packages/ftp.parc.xerox.com/pub/lfg/>
    - <https://news.ycombinator.com/item?id=22582857>
- <https://winworldpc.com/product/grammatik/iv>
- <https://winworldpc.com/product/rightwriter/50-for-windows>
- <http://kurtstephens.com/icstars/wshop/src/fun_Defensive_Programming/>

#### make analyze

- Run gnu style.
- List most frequent words and phrases. This could be useful to identify new rules to add to your diction files (global and local). For example, adding rules for whether to use a or an in front of a word.

#### make draft

This would produce a separate PDF file that needs to be checked manually.

- refcheck
    - <https://tex.stackexchange.com/questions/87610/making-refcheck-work-with-cleveref>
- Check for overfull hboxes: <https://texblog.org/2007/08/15/using-draft-to-show-overfull-hboxes/>
- <https://terrytao.wordpress.com/2017/07/07/what-are-some-useful-but-little-known-features-of-the-tools-used-in-professional-mathematics/#comment-483543>: > I’m now reminded of another LaTeX package I learned to use from some coauthors: showkeys, which labels all references to equations, theorems, and citations by their label, which is useful when proofreading a draft. Of course one should comment out the package when it is finally time to submit, but this just requires editing one line of code.

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
