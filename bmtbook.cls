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
\ProvidesClass{bmtreport}[2021/05/31 BMT book class]

\RequirePackage[l2tabu, orthodox]{nag}
\RequirePackage{etoolbox}

\newcommand{\reportprefix}{BMT-B}
\newtoggle{warningsaserrors}
\toggletrue{warningsaserrors}
\newtoggle{revnoset}
\togglefalse{revnoset}
\newtoggle{git}
\togglefalse{git}

\newtoggle{subjclassset}
\togglefalse{subjclassset}
\newtoggle{keywordsset}
\togglefalse{keywordsset}
\newtoggle{doiset}
\togglefalse{doiset}

\DeclareOption{normalwarnings}{\togglefalse{warningsaserrors}}
\DeclareOption{git}{\toggletrue{git}}
\ProcessOptions\relax
\documentclass[8pt,oneside]{book}

\iftoggle{git}{\toggletrue{revnoset}\input{git.tex}}{}

\RequirePackage{asserts}

% Adds \boldsymbol to make Greek letters bold in math mode
\RequirePackage{amsbsy}

% Improvements to amsmath, which it also loads.
\RequirePackage{mathtools}

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
    \RequirePackage{stix2}
\fi

% load microtype
% needs to load after fonts
% https://tex.stackexchange.com/a/586
\RequirePackage{microtype}

% Some notes on margins: https://practicaltypography.com/page-margins.html
% TODO: Update this to have smaller top and bottom margins per the link on the previous line.
\RequirePackage[
    paperwidth=6in,
    paperheight=9in,
    margin=0.5in
    ]{geometry}
% Your Selection
% Book Size: US Trade (6 x 9 in / 152 x 229 mm)
% Page Count: 250
% Interior Color: Black & White Standard
% Binding Type: Paperback
% Paper Type: 60# White
% Cover Finish: Matte
% Requirements
% Page Size: 6.25 x 9.25in / 158.75mm x 234.95mm
% Cover Size (includes Spine): 14.563 x 10.75in / 369.9mm x 273.05mm
% Spine Width: 0.813in / 20.65mm

\RequirePackage{graphicx}

\RequirePackage{siunitx}
\DeclareSIUnit[number-unit-product = ]\percent{\char`\%} % remove space before percentage sign

% http://texd.cvs.sourceforge.net/viewvc/texd/latex/sty/strict.sty?view=log
\RequirePackage{strict}

\RequirePackage{xpatch}

% Discussion of a possible conflict between onlyamsmath and TikZ:
% https://tex.stackexchange.com/q/31860/9945
\RequirePackage[all,error]{onlyamsmath}

\RequirePackage{tikz,tikz-3dplot,pgfplots}
\pgfplotsset{compat=1.16} % https://tex.stackexchange.com/a/81912
\usetikzlibrary{arrows}

% needs to be loaded before hyperref
\RequirePackage{setspace}

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
    \assertnonemptystr{#2}
    \newcommand*{\docnumber}{#2}
    \iftoggle{note}{}{\RequirePosInt{\docnumber}}
    \ifstrempty{#1}{}{\toggletrue{revnoset}\newcommand*{\revno}{#1}}
    }
\newcommand*{\subjclass}[2][Universal Decimal Classification]{%
    \assertnonemptystr{#1}%
    \assertnonemptystr{#2}%
    \begin{quotation}
    \small%
    \hypersetup{pdfsubject = {#1: #2}}%
    \noindent\textbf{#1:} #2 \\%
    \gdef\thesubjclass{#1: #2}% needs to be defined with gdef as otherwise the scope would be limited to the environment
    \asserttogglefalse{keywordsset}%
    \global\toggletrue{subjclassset}%
    }
\newcommand*{\extrasubjclass}[2]{%
    \assertnonemptystr{#1}%
    \assertnonemptystr{#2}%
    \noindent \textbf{#1:} #2 \\%
    \global\appto{\thesubjclass}{, #1: #2}%
    \asserttoggletrue{subjclassset}%
    }
\newcommand*{\keywords}[1]{%
    \assertnonemptystr{#1}%
    \hypersetup{pdfkeywords = {#1}}%
    \noindent\textbf{Keywords:} #1%
    \gdef\thekeywords{#1}% needs to be defined with gdef as otherwise the scope would be limited to the environment
    \end{quotation}
    \asserttoggletrue{subjclassset}%
    \global\toggletrue{keywordsset}%
    \iftoggle{translation}{}{\linenumbers}%
    }
\newcommand*{\setdoi}[1]{%
    \assertnonemptystr{#1}%
    \hypersetup{pdfdoi = {#1}}%
    \gdef\thedoi{\DOI{#1}}% needs to be defined with gdef as otherwise the scope would be limited to the environment
    \global\toggletrue{doiset}%
    }

% https://www.semipol.de/2018/06/12/latex-best-practices.html#hyperlinks-to-floats-and-not-their-captions
\RequirePackage{hypcap} % load after hyperref

% For putting the number of references, figures, etc. at the end of an abstract.
% https://en.wikibooks.org/wiki/LaTeX/Counters#LaTeX_default_counters
\RequirePackage{totcount}
% Requires biblatex.
% https://tex.stackexchange.com/a/202797/9945
\newtotcounter{citenum}
\AtEveryBibitem{\stepcounter{citenum}}
\regtotcounter{figure}

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
\numberwithin{equation}{section}
