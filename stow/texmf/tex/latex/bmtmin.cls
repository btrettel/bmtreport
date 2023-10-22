% Copyright 2023 Ben Trettel.
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

% TODO: This won't compile with abstractmetadata as true and math in the abstract. Fix that. <https://texfaq.org/FAQ-extrabrace>

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bmtmin}[2023/07/04 BMT report class]

\RequirePackage[l2tabu, orthodox]{nag}
\RequirePackage{etoolbox}

\newtoggle{stix}
\togglefalse{stix}
\DeclareOption{stix}{\toggletrue{stix}}

\ProcessOptions\relax
\LoadClass[letterpaper,12pt,oneside]{article}

\RequirePackage{iftex}

\RequirePackage{amsbsy,mathtools,amssymb,commath,isomath}
\iftoggle{stix}{}{\RequirePackage{lmodern}}

% load microtype
% needs to load after fonts
% <https://tex.stackexchange.com/a/586>
\RequirePackage{microtype}

\ifluatex
    \RequirePackage{fontspec}
    
    % `texdoc unicode-math`: > should be loaded after any other maths or font-related package in case it needs to overwrite their definitions
    \RequirePackage{unicode-math}
    
    \RequirePackage{lualatex-math}
    
    \iftoggle{stix}{
    \setmainfont{STIXTwoText}[
        Extension=.otf,
        UprightFont=*-Regular,
        BoldFont=*-Bold,
        ItalicFont=*-Italic,
        BoldItalicFont=*-BoldItalic]
    \setmathfont{STIXTwoMath}
    }{}
\else
    \RequirePackage[T1]{fontenc}
    
    \iftoggle{stix}{\RequirePackage{stix2}}{}
\fi

\RequirePackage[square,numbers]{natbib}
\bibliographystyle{plainnat}
\RequirePackage{doi} % Turn DOIs into hyperlinks.

\RequirePackage{siunitx}
\DeclareSIUnit[number-unit-product = ]\percent{\char`\%} % remove space before percentage sign
\sisetup{per-mode = symbol}

% Provides the \thetitle, \theauthor, and \thedate commands.
\RequirePackage{titling}

\RequirePackage{hyperref}

% <https://www.semipol.de/2018/06/12/latex-best-practices.html#hyperlinks-to-floats-and-not-their-captions>
\RequirePackage{hypcap} % load after hyperref

% \RequirePackage{strict} % Not on CTAN and not that useful.

% Double spacing
% needs to be loaded before hyperref
% seems buggy and leads to warnings like this even when loaded before `hyperref`: <https://github.com/schlcht/microtype/issues/11>
% [ArXiv doesn't like double spacing](https://info.arxiv.org/help/submit_tex.html#autoproc): > Do not submit in double-spaced "referee" mode
%\RequirePackage{setspace}
