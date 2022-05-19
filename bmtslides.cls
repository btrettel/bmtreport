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
\ProvidesClass{bmtmacros}[2021/05/15 BMT presentation slides class]

\RequirePackage[l2tabu, orthodox]{nag}
\RequirePackage{etoolbox}

\newtoggle{revnoset}
\togglefalse{revnoset}
\newtoggle{doiset}
\togglefalse{doiset}

\LoadClass[t]{beamer}

\RequirePackage{asserts}

% Adds \boldsymbol to make Greek letters bold in math mode
\RequirePackage{amsbsy}

% Improvements to amsmath, which it also loads.
\RequirePackage{mathtools}

\RequirePackage{amssymb}

\RequirePackage{appendixnumberbeamer} % https://stackoverflow.com/a/1738033/1124489

\RequirePackage{cancel}

% https://tex.stackexchange.com/a/17726/9945
\RequirePackage[small,it,labelformat=empty]{caption}

\RequirePackage{color}

% https://nickhigham.wordpress.com/2016/01/28/typesetting-mathematics-according-to-the-iso-standard/#comment-3038
\RequirePackage{commath}

% For some reason this eliminates the bullets in lists.
%% https://tex.stackexchange.com/a/173851/9945
%\RequirePackage[inline,shortlabels]{enumitem}
%% make description environment not use bold letters
%% http://www.latex-community.org/forum/viewtopic.php?f=44&t=4204
%\renewcommand*\descriptionlabel[1]{\hspace\labelsep\normalfont #1}

% https://tex.stackexchange.com/a/19276/9945
% Needs to be loaded before unicode-math when using Unicode math fonts.
\RequirePackage{isomath}

\RequirePackage{media9}

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

% Load fonts here.
\ifluatex
    \RequirePackage{fontspec}
    \RequirePackage{unicode-math}
    \RequirePackage{lualatex-math}
    
    \setmainfont{FiraSans}
    \setsansfont{FiraSans} % FiraMath has no bold.
    \setmathfont{FiraMath}
    \setmonofont{FiraMono}
    
    %\setmainfont{Open Sans}
    %\setsansfont{Open Sans}
    %\setmathfont{FiraMath}
\else
    \RequirePackage[T1]{fontenc}
    
    % Change math to sans serif in a crude way.
    \renewcommand{\rmdefault}{cmss}
    
    \newcommand{\ct}{\tt\small} % eventually will be deprecated due to http://www.tex.ac.uk/cgi-bin/texfaq2html?label=2letterfontcmd
\fi

% load microtype
% needs to load after fonts
% https://tex.stackexchange.com/a/586
\RequirePackage{microtype}

\RequirePackage{graphicx}

\RequirePackage{overpic}

\RequirePackage{subfigure}

\RequirePackage{perpage}
\MakePerPage{footnote}

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

% biblatex documentation: > When using the hyperref package, it is preferable to load it after biblatex.
\RequirePackage[
    backref=true,
    natbib=true,
    style=alphabetic,
    backend=biber,
    giveninits=true,
    maxcitenames=3,
    maxbibnames=99,
    isbn=false
]{biblatex}
% was style=numeric-comp, but changed due to:
% https://dblab.cs.toronto.edu/~miller/Research/writing.html
% > Unless required by the restrictions of a journal or conference, use more than cryptic numbers for citations. It is hard for a reader to remember the meaning of Reference 42. This forces her to repeatedly look this up as she is reading. If you use the more common convention of author initials and year (e.g., [AO72]), it is much easier to remember common references.

% Normally I would have hyperref here and associated things like hyperxmp, but beamer automatically loads hyperref and loading it here leads to an error:
% https://tex.stackexchange.com/a/553815/9945

\newcommand*{\docids}[2][]{
    \assertnonemptystr{#2}
    \newcommand*{\docnumber}{#2}
    \ifstrempty{#1}{}{\toggletrue{revnoset}\newcommand*{\revno}{#1}}
    }
\newcommand*{\setdoi}[1]{%
    \assertnonemptystr{#1}%
    \gdef\thedoi{\DOI{#1}}% needs to be defined with gdef as otherwise the scope would be limited to the environment
    \global\toggletrue{doiset}%
    }

% https://www.semipol.de/2018/06/12/latex-best-practices.html#hyperlinks-to-floats-and-not-their-captions
\RequirePackage{hypcap} % load after hyperref

\RequirePackage{bmtmacros}

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

\setbeamertemplate{bibliography item}{}
\renewcommand*\footnoterule{}

% https://tex.stackexchange.com/a/30726/9945
\newcommand\blfootnote[1]{%
  \begingroup
  \renewcommand\thefootnote{}\footnote{#1}%
  \addtocounter{footnote}{-1}%
  \endgroup
}

\renewcommand*{\bibfont}{\scriptsize} % http://tex.stackexchange.com/a/57341

\addtolength{\subfigcapskip}{1em}

% http://tex.stackexchange.com/a/74251
\beamertemplatenavigationsymbolsempty
\setbeamerfont{page number in head/foot}{size=\footnotesize}
\setbeamertemplate{footline}[frame number]

\setbeamercolor{bibliography entry author}{fg=black}
\setbeamercolor{bibliography entry title}{fg=black}
\setbeamercolor{bibliography entry location}{fg=black}
\setbeamercolor{bibliography entry note}{fg=black}

% Change frame total in Beamer footer to be last slide number
% https://tex.stackexchange.com/a/333684
\setbeamertemplate{footline}{%
    \large%
    \hspace{1em}BMT-P-\docnumber%
    \hfill%
    \iftoggle{doiset}{\thedoi\hfill}{}%
    \usebeamercolor[fg]{page number in head/foot}% 
    \usebeamerfont{page number in head/foot}% 
    \large\insertframenumber%
    \,/\,\inserttotalframenumber%
    \kern1em\vskip2pt%
}

\usetikzlibrary{patterns}
\usetikzlibrary{shapes}

% https://tex.stackexchange.com/q/11622/9945
%\setlength{\parskip}{\baselineskip}
