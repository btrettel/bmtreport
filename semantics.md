# Some notes on various semantic extensions to LaTeX

## Planned and implemented in bmtreport

Use \emph instead of \textit for semantics.
https://tex.stackexchange.com/q/1980
https://tex.stackexchange.com/q/14667
https://tex.stackexchange.com/q/175322
https://tex.stackexchange.com/q/531687

Make linter complain when \textit and \textbf are used.

Make linter identify bare numbers not using \num.
https://tex.stackexchange.com/a/38830

https://tex.stackexchange.com/questions/tagged/semantics?tab=Votes

## Past implementations

### COntent Oriented LaTeX

https://tex.stackexchange.com/questions/54425/basic-use-of-derivative-with-cool-package-fails-with-missing-endcsname-inserte

### Hermes

https://openmath.org/meetings/bremen2003/hermes.htm
https://www.swmath.org/software/27416
http://hermes.roua.org/

### Tralics

http://www-sop.inria.fr/marelle/tralics/

### sTeX

https://link.springer.com/article/10.1007/s11786-008-0055-5
https://kwarc.info/people/mkohlhase/papers/mcs08-stex.pdf
https://kwarc.info/systems/sTeX/
https://ctan.org/pkg/stex

Check for interesting references.

>  such packages largely neglect the relations between statements and leave them to be figured out from the presentation by a human reader; even Leslie Lamport’s proposal in [Lam94a] failed to catch on in mathematics. Two notable exceptions are the MMiSSLaTeX [DLL+04] and Salt [GHMD07] approaches, which allow to annotate LATEX documents with ontological relations to interrelate scientific documents and identify claims in them for search purposes. The MathLang format [KMW07] goes still a little farther, extending the semantic relations to the sub-sentence level, but is only implemented in the TeXmacs editor, not directly in LATEX.

### Lamport

https://lamport.azurewebsites.net/pubs/proof.pdf
https://blog.acolyer.org/2015/01/12/how-to-write-a-21st-century-proof/
https://blogs.scientificamerican.com/roots-of-unity/computer-scientist-tells-mathematicians-how-to-write-proofs/
https://news.ycombinator.com/item?id=17430577
https://link.springer.com/article/10.1007/s11784-012-0071-6
https://gabrielferreirasilva.medium.com/why-we-need-structured-proofs-in-mathematics-34a3034f2f90

### SALT

Has environments for background, motivation, conclusions, etc.

https://link.springer.com/chapter/10.1007/978-3-540-72667-8_37
https://web.archive.org/web/20090301143749/http://salt.semanticauthoring.org/download.html
https://link.springer.com/chapter/10.1007/978-3-540-76298-0_15

### Others

https://web.archive.org/web/20100727194929/http://www.informatik.uni-bremen.de/mmiss/tools_e.htm
https://www.sciencedirect.com/science/article/pii/S1571066104000179
https://link.springer.com/chapter/10.1007/978-3-540-73086-6_23
https://ctan.org/pkg/semantex?lang=en
https://tex.stackexchange.com/questions/1229/semantic-tex-where-are-we-heading
https://www2.ph.ed.ac.uk/snuggletex/documentation/overview-and-features.html
https://www.albany.edu/~hammond/gellmu/

Has sectioning like SALT:
http://ceur-ws.org/Vol-206/paper8.pdf
https://scholar.google.com/scholar?cluster=15943762426218601230&hl=en&as_sdt=5,47&sciodt=0,47
https://link.springer.com/chapter/10.1007/978-3-030-00668-6_8
https://content.iospress.com/articles/semantic-web/sw177
