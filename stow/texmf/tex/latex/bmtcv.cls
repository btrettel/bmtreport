% Copyright 2022 Ben Trettel.
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
\ProvidesClass{bmtcv}[2022/05/14 BMT CV/resume class]

\RequirePackage[l2tabu, orthodox]{nag}
\RequirePackage{etoolbox}

\newtoggle{cv}
\toggletrue{cv}
\DeclareOption{cv}{\toggletrue{cv}}
\DeclareOption{resume}{\togglefalse{cv}}

\newtoggle{nolists}
\togglefalse{nolists}
\DeclareOption{nolists}{\toggletrue{nolists}}

\ProcessOptions\relax
\LoadClass[12pt,oneside]{article}

\iftoggle{cv}{%
\newcommand*{\cvtype}{Curriculum Vit\ae}%
}{%
\newcommand*{\cvtype}{R\'{e}sum\'{e}}%
}

% Adds \boldsymbol to make Greek letters bold in math mode
\iftoggle{cv}{\RequirePackage{amsbsy}}{}

% Improvements to amsmath, which it also loads.
\iftoggle{cv}{\RequirePackage{mathtools}}{}

\RequirePackage{asserts}

% <https://tex.stackexchange.com/a/89765/9945>
\RequirePackage{xcolor}

\iftoggle{cv}{\RequirePackage{amssymb}}{}

% <https://nickhigham.wordpress.com/2016/01/28/typesetting-mathematics-according-to-the-iso-standard/#comment-3038>
\iftoggle{cv}{\RequirePackage{commath}}{}

% <https://tex.stackexchange.com/a/173851/9945>
\RequirePackage[inline,shortlabels]{enumitem}
\setlist{nosep}

% <https://tex.stackexchange.com/a/19276/9945>
% Needs to be loaded before unicode-math when using Unicode math fonts.
\iftoggle{cv}{\RequirePackage{isomath}}{}

\RequirePackage{iftex}

\ifluatex
    \RequirePackage{fontspec}
    \iftoggle{cv}{\RequirePackage{unicode-math}}{}
    \iftoggle{cv}{\RequirePackage{lualatex-math}}{}
    
    \setmainfont{STIXTwoText}[
        Extension=.otf,
        UprightFont=*-Regular,
        BoldFont=*-Bold,
        ItalicFont=*-Italic,
        BoldItalicFont=*-BoldItalic]
    \iftoggle{cv}{\setmathfont{STIXTwoMath}}{}
\else
    \PackageError{bmtcv}{luatex required}{}%
    % Given that luatex does the right thing in terms of making the text selectable, I don't plan to add pdflatex compatibility.
    % <https://github.com/latex3/latex2e/issues/465>
\fi

% load microtype
% needs to load after fonts
% <https://tex.stackexchange.com/a/586>
\RequirePackage{microtype}

% Some notes on margins: <https://practicaltypography.com/page-margins.html>
\iftoggle{cv}{%
\RequirePackage[
    letterpaper,
    left=0.5in,
    right=0.5in,
    top=0.5in,
    bottom=1.0in
    ]{geometry}
%\RequirePackage[
    %letterpaper,
    %left=1.5in,
    %right=1.5in,
    %top=1.25in,
    %bottom=1.5in
    %]{geometry}
}{%
\RequirePackage[
    letterpaper,
    left=0.5in,
    right=0.5in,
    top=0.5in,
    bottom=0.5in
    ]{geometry}
%\RequirePackage[
    %letterpaper,
    %left=1.0in,
    %right=1.0in,
    %top=1.0in,
    %bottom=1.0in
    %]{geometry}
}

% <http://texd.cvs.sourceforge.net/viewvc/texd/latex/sty/strict.sty?view=log>
\RequirePackage{strict}

\RequirePackage{xpatch}

\RequirePackage[normalem]{ulem}

\RequirePackage{titlesec}

% Discussion of a possible conflict between onlyamsmath and TikZ:
% <https://tex.stackexchange.com/q/31860/9945>
\iftoggle{cv}{\RequirePackage[all,error]{onlyamsmath}}{}

% biblatex documentation: > When using the hyperref package, it is preferable to load it after biblatex.
\iftoggle{cv}{\RequirePackage[
    natbib=true,
    backend=biber,
    sorting=ydnt,
    defernumbers=true
]{biblatex}}{}

\RequirePackage[unicode,hidelinks]{hyperref}
\hypersetup{
    colorlinks  = false,
    urlcolor    = black,
    pdfpagemode = UseNone,
    pdflang     = {en-US}
}

\iftoggle{cv}{\RequirePackage{bmtmacros}}{}

% Change the URL style to be Roman.
\urlstyle{rm}

% Sets the text on the top left to be placed exactly at the margins.
\setlength{\topskip}{0pt}
\setlength{\parindent}{0pt}

% Loosely based on: <https://github.com/sb2nov/resume>
\titleformat{\section}{\vspace{-1em}\bfseries\scshape\raggedright\large}{}{0em}{}[\color{black}\titlerule \vspace{-5pt}]

% Loosely based on: <https://github.com/sb2nov/resume>
\newcommand*{\resumeItem}[5]{%
\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}lr}
\textbf{#1} & #2 \\
#3 & #4 to #5
\end{tabular*}%
}

\newcommand*{\resumeSpacing}{\vspace{0.5em}}

\newcommand*{\resumeHalfSpacing}{\vspace{0.25em}}

\newenvironment{resumeListAlways}
    {\begin{itemize}}
    {\end{itemize}\resumeSpacing{}}

\newenvironment{resumeList}
    {\begin{resumeListAlways}}
    {\end{resumeListAlways}}

\newenvironment{resumeListCv}
    {\begin{resumeListAlways}}
    {\end{resumeListAlways}}

\newcommand*{\resumeKeywordsStart}{%
\begin{center}
\begin{tabular*}{0.75\textwidth}{@{\extracolsep{\fill}}ccccc}
}

\newcommand*{\resumeKeywordsEnd}{%
\end{tabular*}
\end{center}%
}

\newcommand*{\resumeKeywordsRow}[5]{#1 & #2 & #3 & #4 & #5 \\}

\newcommand*{\resumeKeywordsLastRow}[5]{#1 & #2 & #3 & #4 & #5}

% If run with the nolists option, all the lists are removed for brevity. The versions package works but comment does not. <https://tex.stackexchange.com/a/230044/9945>
\iftoggle{nolists}{%
\RequirePackage{versions}
\excludeversion{resumeList}%
\excludeversion{resumeListCv}%
}{}

\iftoggle{cv}{}{%
\RequirePackage{versions}
\excludeversion{resumeListCv}%
}

\iftoggle{cv}{%
% Remove numbers in front of bibliography entries
% https://tex.stackexchange.com/a/219999/9945
\DeclareFieldFormat{labelnumberwidth}{}
\setlength{\biblabelsep}{0pt}

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

% <http://robjhyndman.com/researchtips/cv/>
% Bibliography categories
\newcommand*{\makebibcategory}[2]{\DeclareBibliographyCategory{#1}\defbibheading{#1}{\subsection*{#2}}}
\makebibcategory{journals}{Refereed journal articles}
%\makebibcategory{books}{Books}
%\makebibcategory{presentations}{Presentations}
%\makebibcategory{chapters}{Book chapters}
\makebibcategory{conferences}{Conference papers}
\makebibcategory{techreports}{Technical reports}
%\makebibcategory{inpreparation}{In preparation}
%\makebibcategory{bookreviews}{Book reviews}
%\makebibcategory{editorials}{Editorials}
\makebibcategory{phd}{Dissertations and theses}
%\makebibcategory{subpapers}{Submitted papers}
%\makebibcategory{curpapers}{Current projects}
\makebibcategory{mentions}{Mentions of research in popular press}
\makebibcategory{translations}{Translations}
\makebibcategory{preprints}{Preprints}

\newcommand*{\printbib}[1]{\printbibliography[category=#1,heading=#1]}
}{}
