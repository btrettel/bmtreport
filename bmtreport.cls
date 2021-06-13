% Copyright 2021 Ben Trettel.
% This file is part of bmtreport <https://github.com/btrettel/bmtreport>.
% 
% bmtreport is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% bmtreport is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with bmtreport.  If not, see <https://www.gnu.org/licenses/>.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bmtreport}[2021/05/15 BMT report class]

\RequirePackage[l2tabu, orthodox]{nag}
\RequirePackage{etoolbox}

\newcommand{\reportprefix}{BMT}
\newtoggle{ccbysa}
\togglefalse{ccbysa}
\newtoggle{fairuse}
\togglefalse{fairuse}
\newtoggle{tradesecret}
\togglefalse{tradesecret}
\newtoggle{translation}
\togglefalse{translation}
\newtoggle{note}
\togglefalse{note}
\newtoggle{warningsaserrors}
\toggletrue{warningsaserrors}
\newtoggle{revnoset}
\togglefalse{revnoset}
\newtoggle{opendata}
\togglefalse{opendata}
\newtoggle{nometadatachecks}
\togglefalse{nometadatachecks}
\newtoggle{abstractmetadata}
\toggletrue{abstractmetadata}
\newtoggle{git}
\togglefalse{git}
\newtoggle{lineno}
\toggletrue{lineno}
\newtoggle{parano}
\togglefalse{parano}
\newtoggle{doublespacing} % I used to use spacing, but realistically this isn't enough to put too many comments on the page, which is why one typically uses double or one-half spacing. I have plenty of margin, however, so this may not be a problem.
\togglefalse{doublespacing}

\newtoggle{subjclassset}
\togglefalse{subjclassset}
\newtoggle{keywordsset}
\togglefalse{keywordsset}
\newtoggle{doiset}
\togglefalse{doiset}

\DeclareOption{fairuse}{\toggletrue{fairuse}}
\DeclareOption{tradesecret}{\toggletrue{tradesecret}}
\DeclareOption{nometadatachecks}{\toggletrue{nometadatachecks}}
\DeclareOption{noabstractmetadata}{\togglefalse{abstractmetadata}}
\DeclareOption{ccbysa}{
   \toggletrue{ccbysa}
   \iftoggle{tradesecret}{\PackageError{bmtreport}{Can not set a trade secret report as CC BY-SA.}{}}{}
   \iftoggle{fairuse}{\PackageError{bmtreport}{Can not set fair use and CC BY-SA simultaneously.}{}}{}
   }
\DeclareOption{translation}{
   \renewcommand{\reportprefix}{BMT\nobreakdash-T}
   \toggletrue{translation}
   }
\DeclareOption{note}{
   \renewcommand{\reportprefix}{BMT\nobreakdash-N}
   \toggletrue{note}
   }
\DeclareOption{normalwarnings}{\togglefalse{warningsaserrors}}
\DeclareOption{git}{\toggletrue{git}}
\DeclareOption{lineno}{\toggletrue{lineno}\togglefalse{parano}}
\DeclareOption{parano}{\toggletrue{parano}\togglefalse{lineno}}
\DeclareOption{nolineparano}{\togglefalse{lineno}\togglefalse{parano}}
\DeclareOption{doublespacing}{\toggletrue{doublespacing}}
\ProcessOptions\relax
\LoadClass[11pt,oneside]{article}

\iftoggle{git}{\toggletrue{revnoset}\input{git.tex}}{}

\RequirePackage{asserts}

% TODO: document fnref and fnpageref in bmtmacros
% TODO: document \linelabel
% TODO: make pararef? Look into refcount package. https://tex.stackexchange.com/q/474807/9945 https://www.overleaf.com/learn/latex/Counters

% Advantage of paragraph numbers over line numbers: Paragraph numbers are independent of the formatting, e.g., changing the font size will not change the paragraph number but it often would change the line numbers.
% Seems to not number certain paragraphs.
% Changes the spacing in sections without text (i.e., incomplete sections), but does not seem to change the spacing appreciably in sections with text. Not a major issue.
% TODO: number list items
\iftoggle{parano}{
\asserttogglefalse{lineno}
%\setlength{\parindent}{0pt} % Similar to the line below but apparently with negative effects.
%\usepackage[skip=0em]{parskip} % Removes all paragraph indentation. The paragraph number will indicate that a new paragraph has started now.
% wright_presenting_1977 p. 98: > Hartley and Burnhill (1976) have suggested on the basis of their own research findings that leaving an empty line between paragraphs is a more effective cue for the reader than just indenting the first line of the new paragraph.
% https://tex.stackexchange.com/a/74173/9945
%\usepackage[parfill]{parskip}
\usepackage[skip=0.5em]{parskip}
\RequirePackage{parano}
\RequirePackage{accsupp}
%\renewcommand\theparano{\BeginAccSupp{ActualText=}{\bfseries\footnotesize[\arabic{parano}]}\EndAccSupp{}}
\RequirePackage{fmtcount}
\renewcommand\theparano{\BeginAccSupp{ActualText=}{\bfseries\footnotesize[\padzeroes[4]{\decimal{parano}}]}\EndAccSupp{}}
% This command will make a paragraph number when it was not, but I don't understand why.
\newcommand\para{\@startsection{paragraph}{4}{\z@}%
                                    {0em}%
                                    {0em}%
                                    {\normalfont\normalsize}}
}{}

\iftoggle{lineno}{
\asserttogglefalse{parano}
%\RequirePackage[pagewise]{lineno}
\RequirePackage{lineno}
\RequirePackage{accsupp}
\RequirePackage{indentfirst} % indent all paragraphs
\modulolinenumbers[5]
% The \BeginAccSupp and \EndAccSupp parts make the line numbers not selectable text, which presumably will help those using screen readers and also definitely helps when copying text.
% https://tex.stackexchange.com/a/158886/9945
\renewcommand{\linenumberfont}{\bfseries\footnotesize\BeginAccSupp{ActualText=}}
\appto{\LineNumber}{\enspace\EndAccSupp{}} % Could remove \enspace before the \EndAccSupp{} to move number closer
\newcommand\para{}
}{}

% Adds \boldsymbol to make Greek letters bold in math mode
\RequirePackage{amsbsy}

% Improvements to amsmath, which it also loads.
\RequirePackage{mathtools}

\iftoggle{lineno}{
% Fix lineno so that the line numbers are correct around amsmath environments. Needs to load after amsmath is loaded, and lineno needs to load before amsmath.
% https://tex.stackexchange.com/a/461192/9945
% Patch 'normal' math environments:
\newcommand*\linenomathpatch[1]{%
  \cspreto{#1}{\linenomath}%
  \cspreto{#1*}{\linenomath}%
  \csappto{end#1}{\endlinenomath}%
  \csappto{end#1*}{\endlinenomath}%
}

\linenomathpatch{equation}
\linenomathpatch{gather}
\linenomathpatch{multline}
\linenomathpatch{align}
\linenomathpatch{alignat}
\linenomathpatch{flalign}
}{}

% This seems to conflict with the mathtools package and needs to be loaded after it or else it won't work. It is preferable to load this as soon as possible in order to catch as many warnings as possible.
\iftoggle{warningsaserrors}{
   \typeout{Treating warnings as errors.}
   % treat warnings as errors to catch minor mistakes
   
   % The following does not seem to catch all warnings as of 2021-04-24.
   % https://stackoverflow.com/a/3277465/1124489
   \RequirePackage{silence} % Needs to be before the following in order for this to work.
   \renewcommand{\GenericWarning}[2]{\GenericError{#1}{#2}{}{This warning has been turned into a fatal error.}}
   %\ErrorFilter{latex}{Marginpar on page}
   %\ErrorFilter{latexfont}{Font}
   %\ErrorFilter{biblatex}{Please rerun LaTeX}
   
   %\ErrorFilter{atenddvi}{Rerun}
   %\ErrorFilter{lastpage}{Rerun}
   %\ErrorFilter{latex}{Reference `LastPage'}
   %\ErrorFilter{latex}{There were undefined references}
   %\ErrorFilter{lineno}{Linenumber reference failed}
   %\ErrorFilter{lineno}{Rerun}
   %\ErrorFilter{rerunfilecheck}{File}
   }{}

\RequirePackage{amssymb}

\RequirePackage{cancel}

% https://tex.stackexchange.com/a/17726/9945
\RequirePackage{caption}

\RequirePackage{color}

% https://nickhigham.wordpress.com/2016/01/28/typesetting-mathematics-according-to-the-iso-standard/#comment-3038
\RequirePackage{commath}

% https://tex.stackexchange.com/a/173851/9945
\RequirePackage[inline,shortlabels]{enumitem}

% https://tex.stackexchange.com/a/19276/9945
% Needs to be loaded before unicode-math when using Unicode math fonts.
\RequirePackage{isomath}

\RequirePackage{iftex}

\ifluatex
\RequirePackage{luacode}
\fi

% Create a Makefile if none exists.
% \noexpand is needed for the newline: https://tex.stackexchange.com/a/69207/9945
% The filecontents environment doesn't work because it seems to automatically add a file extension if none is given.
% Could also try something based on this: https://tex.stackexchange.com/a/521819/9945

% https://stackoverflow.com/a/4991602/1124489
\ifluatex
\directlua{
f = io.open("Makefile", "r")
if f==nil then
   out = io.open("Makefile", "w")
   out:write("key=\jobname\noexpand\ninclude bmt.mk")
   io.close(out)
   texio.write_nl("Makefile created.")
else
   io.close(f)
   texio.write_nl("Makefile already present, not creating.")
end
}
\fi

% https://www.texfaq.org/FAQ-otf-maths
% https://tex.stackexchange.com/questions/425098/which-opentype-math-fonts-are-available
% https://tug.org/FontCatalogue/mathfonts.html
% https://tex.stackexchange.com/a/413046
\ifluatex
   \RequirePackage{fontspec}
   \RequirePackage{unicode-math}
   \RequirePackage{lualatex-math}
   
   % I like the integrals in newtx better than TeX Gyre Termes Math. I think that's why I used this before.
   % https://tex.stackexchange.com/a/145382/9945
   
   % Option: TeX Gyre Termes 
   % It is better to use Unicode fonts in LuaTeX, so don't pick newtx.
   % https://tex.stackexchange.com/a/552351/9945 
   % No Cyrillic characters.
   %\setmainfont{TeX Gyre Termes}
   %\setmathfont{TeX Gyre Termes Math}
   
   % Option: STIX (no longer updated)
   % Has Cyrillic characters.
   %\setmainfont{STIX}
   %\setmathfont{STIX Math} % Also leads to font errors like newtxmath but looks like newtxmath and I assume this is a Unicode font. Unfortuantely this is no longer developed.
   
   % Option: STIX Two
   % Thicker and less detailed than Times New Roman, which I don't like.
   % Has Cyrillic characters. Does not have Chinese or Japanese characters.
   % https://www.overleaf.com/learn/latex/Articles/OpenType-based_math_typesetting:_An_introduction_to_the_STIX2_OpenType_fonts
   % https://ctan.org/pkg/stix2-otf/
   \setmainfont{STIX2Text}[
      Extension=.otf,
      UprightFont=*-Regular,
      BoldFont=*-Bold,
      ItalicFont=*-Italic,
      BoldItalicFont=*-BoldItalic]
   \setmathfont{STIX2Math}[Extension=.otf]
   
   % Option: EB Garamond (no associated math font; ebgaramond-maths is a hack)
   %\setmainfont{EB Garamond}
   
   % Option: DejaVu serif
   %\setmainfont{DejaVu Serif}
   %\setmainfont{TeX Gyre DejaVu Math}
   
   % Option: TeX Gyre Pagella
   % Looks nice. No Cyrillic support.
   %\setmainfont{TeX Gyre Pagella}
   %\setmathfont{TeX Gyre Pagella Math}
   
   % Option: TeX Gyre Schola
   % Looks nice. No Cyrillic support.
   %\setmainfont{TeX Gyre Schola}
   %\setmathfont{TeX Gyre Schola Math}
   
   % https://md.ekstrandom.net/blog/2014/07/tex-modern-fonts
   % https://tex.stackexchange.com/a/248608/9945
   % https://texfaq.org/FAQ-otf-maths
   % http://www.tug.dk/FontCatalogue/newtx/
   % https://tex.stackexchange.com/a/552351/9945
   % https://tex.stackexchange.com/a/79866/9945
\else
   \RequirePackage[T1]{fontenc}
   
   % Option: newtx
   %\RequirePackage{newtxtext,newtxmath} % https://ctan.org/pkg/newtx (2017, no font errors)
   
   % Option: STIX Two
   \usepackage{stix2}
\fi

% load microtype
% needs to load after fonts
% https://tex.stackexchange.com/a/586
\RequirePackage{microtype}

% Some notes on margins: https://practicaltypography.com/page-margins.html
\RequirePackage[
   letterpaper,
   left=1.5in,
   right=1.5in,
   top=1.25in,
   bottom=1.5in
   ]{geometry}

\RequirePackage{graphicx}

\RequirePackage{siunitx}
\DeclareSIUnit[number-unit-product = ]\percent{\char`\%} % remove space before percentage sign

% http://texd.cvs.sourceforge.net/viewvc/texd/latex/sty/strict.sty?view=log
\RequirePackage{strict}

\RequirePackage{xpatch}

% Discussion of a possible conflict between onlyamsmath and TikZ:
% https://tex.stackexchange.com/q/31860/9945
\usepackage[all,error]{onlyamsmath}

\RequirePackage{tikz,tikz-3dplot,pgfplots}
\pgfplotsset{compat=1.16} % https://tex.stackexchange.com/a/81912
\usetikzlibrary{arrows}

\iftoggle{doublespacing}{
% needs to be loaded before hyperref
\RequirePackage{setspace}
}{}

% biblatex documentation: > When using the hyperref package, it is preferable to load it after biblatex.
\RequirePackage[
   backref=true,
   natbib=true,
   style=alphabetic,
   backend=biber,
   giveninits=true,
   maxcitenames=3,
   maxbibnames=99
]{biblatex}
% was style=numeric-comp, but changed due to:
% https://dblab.cs.toronto.edu/~miller/Research/writing.html
% > Unless required by the restrictions of a journal or conference, use more than cryptic numbers for citations. It is hard for a reader to remember the meaning of Reference 42. This forces her to repeatedly look this up as she is reading. If you use the more common convention of author initials and year (e.g., [AO72]), it is much easier to remember common references.

\RequirePackage{hyperxmp}
\RequirePackage[unicode]{hyperref}
%\RequirePackage{breakurl}
\hypersetup{
   colorlinks    = false,
   urlcolor      = black,
   pdfpagemode   = UseNone,
   pdflang       = {en-US},
   pdfcontacturl = {http://trettel.us/contact.html}
}

\newcommand*{\docids}[2][]{
   \assertnonempty{#2}
   \newcommand*{\docnumber}{#2}
   \iftoggle{note}{}{\RequirePosInt{\docnumber}}
   \ifstrempty{#1}{}{\toggletrue{revnoset}\newcommand*{\revno}{#1}}
   }
\newcommand*{\opendata}[2][Data and processing scripts]{
   \assertnonempty{#2}
   \newcommand*{\opendataprefix}{#1}
   \newcommand*{\opendatasource}{#2}
   \toggletrue{opendata}
   }
\newcommand*{\subjclass}[2][Universal Decimal Classification]{%
   \assertnonempty{#1}%
   \assertnonempty{#2}%
   \begin{quotation}
   \small%
   \hypersetup{pdfsubject = {#1: #2}}%
   \noindent\textbf{#1:} #2 \\%
   \gdef\thesubjclass{#1: #2}% needs to be defined with gdef as otherwise the scope would be limited to the environment
   \asserttogglefalse{keywordsset}%
   \global\toggletrue{subjclassset}%
   }
\newcommand*{\extrasubjclass}[2]{%
   \assertnonempty{#1}%
   \assertnonempty{#2}%
   \noindent \textbf{#1:} #2 \\%
   \global\appto{\thesubjclass}{, #1: #2}%
   \asserttoggletrue{subjclassset}%
   }
\newcommand*{\keywords}[1]{%
   \assertnonempty{#1}%
   \hypersetup{pdfkeywords = {#1}}%
   \noindent\textbf{Keywords:} #1%
   \gdef\thekeywords{#1}% needs to be defined with gdef as otherwise the scope would be limited to the environment
   \end{quotation}
   \asserttoggletrue{subjclassset}%
   \global\toggletrue{keywordsset}%
   \iftoggle{translation}{}{\iftoggle{lineno}{\linenumbers}{}\iftoggle{parano}{\parano}{}}%
   }
\newcommand*{\setdoi}[1]{%
   \assertnonempty{#1}%
   \hypersetup{pdfdoi = {#1}}%
   \gdef\thedoi{\DOI{#1}}% needs to be defined with gdef as otherwise the scope would be limited to the environment
   \global\toggletrue{doiset}%
   }

\newcommand*{\translationboilerplate}[3]{%
   \assertnonempty{#1}%
   \assertnonempty{#2}%
   \asserttoggletrue{translation}%
   \begingroup%
   \renewcommand\thefootnote{}\footnote{Translation from #1 of: \fullcite{#2}\mybibexclude{#2}. \par The right margin indicates the page of the original text. This is a lightly edited machine translation made with \href{https://translate.google.com/}{Google Translate}. Last updated on #3.
   \iftoggle{fairuse}{\par Fair use notice: This translation was made only for the purposes of noncommercial research and criticism. The rights to the content of the translation itself remain with the rightful owner of the original document. %While the original was not released under an open access license, it was released openly.
   % TODO: hypersetup pdfcopyright
   % https://termly.io/resources/articles/fair-use-disclaimer/
   % https://en.wikipedia.org/wiki/Fair_use
   % https://github.com/btrettel/pipe-jet-breakup-data/blob/master/FAIR-USE.md
   }{}}
   \addtocounter{footnote}{-1}%
   \endgroup%
   \vspace{-1em}
   \iftoggle{lineno}{\linenumbers}{}\iftoggle{parano}{\parano}{}%
   }

% https://www.semipol.de/2018/06/12/latex-best-practices.html#hyperlinks-to-floats-and-not-their-captions
\RequirePackage{hypcap} % load after hyperref

% For putting the number of references, figures, etc. at the end of an abstract.
% https://en.wikibooks.org/wiki/LaTeX/Counters#LaTeX_default_counters
\usepackage{totcount}
% Requires biblatex.
% https://tex.stackexchange.com/a/202797/9945
\newtotcounter{citenum}
\AtEveryBibitem{\stepcounter{citenum}}
\regtotcounter{figure}

% Needs to be placed down here to avoid a clash with some other package.
\iftoggle{translation}{\RequirePackage{transcheck}}{}

\RequirePackage{bmtmacros}

% make description environment not use bold letters
% http://www.latex-community.org/forum/viewtopic.php?f=44&t=4204
\renewcommand*\descriptionlabel[1]{\hspace\labelsep\normalfont #1}

% Remove "In:" from the bibliography
% https://tex.stackexchange.com/a/10686
\renewbibmacro{in:}{}

% Change issue number to be in parentheses
% https://tex.stackexchange.com/a/97729
\xpatchbibmacro{volume+number+eid}{%
   \setunit*{\adddot}%
}{%
}{}{}
\DeclareFieldFormat[article]{number}{\mkbibparens{#1}}

% Put URLs and DOIs in same font as remainder of text
% https://tex.stackexchange.com/q/151110
%\urlstyle{same}
\DeclareFieldFormat{url}{URL: \url{#1}}
\DeclareFieldFormat{doi}{\DOI{#1}}

% Change ISSN from small caps and add WorldCat link
\DeclareFieldFormat{issn}{\ISSN{#1}}
\DeclareFieldFormat{isbn}{ISBN: \href{https://www.worldcat.org/search?q=isbn\%3A#1}{#1}}

% Change the URL style to be Roman.
\urlstyle{rm}

% add the section number to the equation
\iftoggle{translation}{}{\numberwithin{equation}{section}}

% Provides the \thetitle, \theauthor, and \thedate commands.
\RequirePackage{titling}

% Provides the abstract as \theabstract.
% https://tex.stackexchange.com/a/596396/9945
\RequirePackage{environ}
\let\svabstract\abstract
\let\svendabstract\endabstract
\iftoggle{abstractmetadata}{
\RenewEnviron{abstract}{
   \svabstract\BODY%
   \ifnumequal{\totvalue{citenum}}{1}{%
      \ \total{citenum} reference.}{%
      \ \total{citenum} references.}%
   \ifnumequal{\totvalue{figure}}{1}{%
      \ \total{figure} figure.}{%
      \ \total{figure} figures.}%
   \svendabstract
   \expandafter\gdef\expandafter\theabstract\expandafter{\BODY}
}}{
\RenewEnviron{abstract}{
   \svabstract\BODY\svendabstract
   \expandafter\gdef\expandafter\theabstract\expandafter{\BODY}
}}

%\RenewEnviron{abstract}{
   %\svabstract\BODY%
   %\directlua{%
      %n_ref = "\totvalue{citenum}"
      %tex.print(n_ref)
   %}%
   %references.\svendabstract
   %\expandafter\gdef\expandafter\theabstract\expandafter{\BODY}
%}

% Guidelines on marking CC works: https://wiki.creativecommons.org/wiki/Marking_your_work_with_a_CC_license
% TODO?: add a trade secrecy notice?
% Needs to be before lastpage package is loaded, otherwise the footer will be added on a new page.
% https://tex.stackexchange.com/a/212214/9945
\AtEndDocument{
   % Check if subject classification and keywords are set, return error if not.
   \asserttoggletrue{subjclassset}%
   \asserttoggletrue{keywordsset}%
   %
   % The macros below *re-add* PDF document information removed by hyperxmp.
   % https://tex.stackexchange.com/a/524690/9945
   % https://tex.stackexchange.com/a/5961/9945
   \ifluatex%
      \directlua{%
         pdf.setinfo ("/Title (\thetitle)"
                   .. "/Author (\theauthor)"
                   .. "/Subject (\thesubjclass)"
                   .. "/Keywords (\thekeywords)")
         }%
      \iftoggle{nometadatachecks}{}{
         \luaexec{%
            s = \luastring{\thetitle}
            n = string.len(s)
            texio.write_nl("Title character count: ")
            texio.write(n)
            if n>75 then
               tex.error("Title is over 75 characters long")
            end
            _,n_words = s:gsub("\%S+","")
            texio.write_nl("Title word count: ")
            texio.write(n_words)
            if n_words>15 then
               tex.error("Title is over 15 words long")
            end
            out = io.open("title.tex", "w")
            out:write(s)
            out:write('.')
            io.close(out)
            }%
         \luaexec{%
            s = \luastring{\thekeywords}
            _,n = s:gsub(",","")
            n = n + 1
            texio.write_nl("Keyword count: ")
            texio.write(n)
            if n>5 then
               tex.error("There are more than 5 keywords")
            end
            }%
         \luaexec{%
            s = \luastring{\theabstract}
            % Word count
            % https://stackoverflow.com/a/29136751/1124489
            _,n_words = s:gsub("\%S+","")
            texio.write_nl("Abstract word count: ")
            texio.write(n_words)
            % https://www.uspto.gov/web/offices/pac/mpep/s608.html#d0e44136
            if n_words<50 then
               tex.error("Abstract is under 50 words long")
            end
            if n_words>150 then
               tex.error("Abstract is over 150 words long")
            end
            % https://www.apsdfd2019.org/abstract-submission
            % APS DFD abstract limit is 1300 characters.
            n_chars = string.len(s)
            texio.write_nl("Abstract character count: ")
            texio.write(n_chars)
            if n_chars>1300 then
               tex.error("Abstract is over 1300 characters long")
            end
            out = io.open("abstract.tex", "w")
            out:write(s)
            io.close(out)
            }%
         }%
   \else%
      \pdfinfo{/Title (\thetitle)
               /Author (\theauthor)
               /Subject (\thesubjclass)
               /Keywords (\thekeywords)}%
   \fi%
   \hypersetup{
      pdfdate={\thedate}
   }
   \iftoggle{lineno}{\nolinenumbers}{}\iftoggle{parano}{\endparano}{}\iftoggle{doublespacing}{\singlespacing\null}{}\vfill
   \noindent Citation: \theauthor, ``\thetitle'', \iftoggle{translation}{Translation}{\iftoggle{note}{Note}{Technical report}} \reportprefix\nobreakdash-\docnumber, \thedate. \iftoggle{doiset}{\thedoi.}{} \\[1em]
   \iftoggle{opendata}{\noindent \opendataprefix: \opendatasource \\[1em]}{}%
   \iftoggle{revnoset}{\hypersetup{pdfversionid={\revno}} \noindent Revision ID: \revno\\}{}%
   \iftoggle{fairuse}{}{%
      %\noindent Contact info.: \url{http://trettel.us/contact.html} \\
      \noindent \url{http://trettel.us/} \\
      \noindent\copyright \the\year{} \theauthor.
      \iftoggle{ccbysa}{%
         This document is available under a \href{https://creativecommons.org/licenses/by-sa/4.0/}{CC BY-SA 4.0} license.%
         \hypersetup{
            pdfcopyright={\copyright \the\year{} \theauthor. This document is licensed to the public under the Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) license.},
            pdflicenseurl={https://creativecommons.org/licenses/by-sa/4.0/}%
         }%
         }{%
         \hypersetup{pdfcopyright={\copyright \the\year{} \theauthor.}}%
         }
      }
   }

% Set up the headers and footers.
% Put the total number of pages in the footer so that the recipient can be certain nothing is missing.
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0pt}
\fancyhf{} % clear default for head and foot
\iftoggle{tradesecret}{
   \setlength{\headheight}{25pt}
   \chead{\reportprefix\nobreakdash-\docnumber \\ \textbf{TRADE SECRET}}
   }{
   \setlength{\headheight}{14pt} % Needed to avoid a warning in the default settings. Odd situation. https://latex.org/forum/viewtopic.php?t=30693
   \chead{\reportprefix\nobreakdash-\docnumber} % I put the report number at the top center for symmetry reasons.
   }
\cfoot{\thepage\ of \pageref{LastPage}}
\fancypagestyle{cover}{
   \fancyhf{} % clear default for head and foot
   \iftoggle{tradesecret}{
      \chead{\reportprefix\nobreakdash-\docnumber \\ \textbf{TRADE SECRET}}
      }{
      \chead{\reportprefix\nobreakdash-\docnumber} % I put the report number at the top center for symmetry reasons.
      }
   \cfoot{\thepage\ of \pageref{LastPage}}
}

\iftoggle{doublespacing}{
% Automatically make first page style the cover style and set the document to use 1.5 spacing.
% https://tex.stackexchange.com/a/12574/9945
% Needs to be after the setup of fancyhdr.
% Note that \appto{}{} from etoolbox doesn't seem to work here for some reason.
\makeatletter
\g@addto@macro{\maketitle}{\thispagestyle{cover}\doublespacing}
\makeatother
}{}

% Remove line numbers from references, as you can simply refer to the citation key.
\pretocmd{\printbibliography}{\iftoggle{lineno}{\nolinenumbers}{}\iftoggle{parano}{\endparano}{}}{}{}
