\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{mathscript}[2018/08/05 mathscript]

%programming related packages
\RequirePackage{zref-base}
\RequirePackage{etoolbox}
\RequirePackage{xparse}                          % better macros, for \DeclarePairedDelimiter
\RequirePackage{mleftright}                      % for \DeclarePairedDelimiter
\RequirePackage{calc}
\RequirePackage{xstring}
\RequirePackage{xkeyval}

%possible values: firstnumber, firstname
\def\theoremheader@order@val{firstnumber}
\DeclareOptionX{order}{%
	%sets accordingly the required ntheoremoptions
	\let\tempa\@empty
	\IfEq{#1}{firstnumber}{\def\tempa{changebreak}}{%
		\IfEq{#1}{firstname}{\def\tempa{break}}{%
			\PackageWarning{mathscript}{Unknown Value for key `order'}
		}
	}
	\edef\theoremheader@order@val{\tempa}	
}
\def\theoremcounter@belongingto{section}
\DeclareOptionX{theoremcounterreset}{%
	\let\tempa\@empty
	\IfEq{#1}{section}{\def\tempa{section}}{%
		\IfEq{#1}{chapter}{\def\tempa{chapter}}{%
			\PackageWarning{mathscript}{Unknown Value for key `theoremcounterreset'}
		}
	}
	\edef\theoremcounter@belongingto{\tempa}
}

%possible values: all you can imagine.
%usefull values: theorem-names defined in this class, new theorems defined by \newmdtheoremenv
\listadd{\theorem@disable}{\@empty}
\DeclareOptionX{disable}{%
	\listadd{\theorem@disable}{#1}
}

\newif\ifreset@section@after@chapter
\reset@section@after@chaptertrue
\DeclareOptionX{sectionreset}{%
	\reset@section@after@chapterfalse
}

\newif\ifreset@equation@number@after@section
\reset@equation@number@after@sectiontrue
\DeclareOptionX{equationnumberreset}{%
	\reset@equation@number@after@sectionfalse
}

\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptionsX
\LoadClass[ngerman,a4paper]{report}

\RequirePackage{ifpdf,ifluatex}

%decent space; change explicitly the space between header and content and footer and content
\RequirePackage[left=2.1cm,right=3.1cm,bottom=3cm,footskip=0.75cm,headsep=0.5cm]{geometry}
\RequirePackage{babel}


\ifpdf
	\ifluatex
		%new lualatex needs explicit fontspec to draw properly e.g. german umlauts
		\RequirePackage{fontspec}
		\RequirePackage{lua-visual-debug} %for debugging
	\else
		%old pdflatex needs explicitly utf-8-support
		\RequirePackage[utf8]{inputenc}
		\RequirePackage{chngcntr}
		\RequirePackage{eufrak}
	\fi
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Layout related packages
\RequirePackage{parskip}  	%split paragraphs by vspace instead of intendations
\RequirePackage{fancyhdr} 	%customize header / footer
\RequirePackage{titlesec} 	%customize titles
\RequirePackage{tocloft}	%customize toc
\RequirePackage[font=small,labelfont=bf]{caption}     % not-floating figures with caption
\RequirePackage{changepage}

%tabulars
\RequirePackage{tabularx} 	%tabularx-environment (explicitly set width of columns)
\RequirePackage{longtable} %Tabellen mit Seitenumbrüchen
\RequirePackage{multirow}
\RequirePackage{booktabs}	%improved rules
\usepackage{colortbl} %einfärben von Spalten, Zeilen und Zellen

\RequirePackage[title,titletoc]{appendix}

\RequirePackage{environ}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Math related packages
%basic ams-math and enhancments
\RequirePackage[fleqn]{amsmath}
\RequirePackage{amssymb,amsfonts,mathtools}
\RequirePackage{blkarray}

%add some font-related stuff
\RequirePackage{latexsym}
\RequirePackage{marvosym} 	%lightning (contradiction)
\RequirePackage{stmaryrd} 	%Lightning symbol
\RequirePackage{bbm} 		%unitary matrix
\RequirePackage{wasysym}	%add some symbols
\RequirePackage[bb=boondox]{mathalfa} %special zero using \mathbb{0}
\RequirePackage{systeme}
\usepackage{upgreek}		%griechische Buchstaben, für mehr Auswahl bei phi's

%further support for different equation setting
\RequirePackage{cancel}
\RequirePackage{aligned-overset}         % fixes alignment when overset ist used.
\RequirePackage{xfrac}		             % sfrac -> fractions e.g. 3/4
\RequirePackage{nicefrac}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Graphics-related packages
\RequirePackage[table,dvipsnames]{xcolor}
\RequirePackage{graphicx}
\RequirePackage{tcolorbox}

\RequirePackage{pgfplots}
\pgfplotsset{compat=1.10}
\usepgfplotslibrary{fillbetween}
\RequirePackage{pgf}
\RequirePackage{tikz}
\RequirePackage{tikz-qtree}
\usetikzlibrary{patterns,arrows,calc,decorations.pathmorphing,backgrounds, positioning,fit,petri,decorations.fractals,trees,cd,automata,babel,shapes.geometric,arrows.meta,bending}
\usetikzlibrary{matrix}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Text-related packages
%increase line spacing
%\RequirePackage[onehalfspacing]{setspace} %increase row-space
\RequirePackage{ulem} 		%better underlines
\RequirePackage{marginnote}	%notes at the edge

%enumeration
\RequirePackage{enumerate}
\RequirePackage[inline]{enumitem} 		%customize label

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Pakete für Programmierung

\RequirePackage{lmodern}
\RequirePackage{listings}

%Konfiguration dazu
\definecolor{lightlightgray}{rgb}{0.95,0.95,0.95}
\definecolor{lila}{rgb}{0.8,0,0.8}
\definecolor{mygray}{rgb}{0.5,0.5,0.5}
\definecolor{mygreen}{rgb}{0,0.8,0.26}

\lstset{language=[95]Fortran,
  basicstyle=\ttfamily,
  keywordstyle=\color{lila},
  commentstyle=\color{lightgray},
  morecomment=[l]{!\ },% Comment only with space after !
  morekeywords={compute, solve, choose, break, switch, determine},
  stringstyle=\color{mygreen}\ttfamily,
  backgroundcolor=\color{white},
  showstringspaces=false,
  numbers=left,
  numbersep=10pt,
  numberstyle=\color{mygray}\ttfamily,
  identifierstyle=\color{blue},
  xleftmargin=.2\textwidth, 
  xrightmargin=.1\textwidth,
  escapechar=\%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Index related packages
\RequirePackage[texindy]{imakeidx}
\indexsetup{
	level=\chapter*
}
\makeindex[intoc]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Theorem-related packages
\RequirePackage[amsmath,amsthm,thmmarks,hyperref]{ntheorem}
\RequirePackage[ntheorem,framemethod=TikZ]{mdframed}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[unicode,bookmarks=true]{hyperref}
\hypersetup{
	colorlinks,
	citecolor=green,
	filecolor=green,
	linkcolor=blue,
	urlcolor=blue
}
\RequirePackage{cleveref}
\RequirePackage{bookmark}	%pdf-bookmarks

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 						End Packages							%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%tweak \newmdtheoremenv to create an empty environment if this very enviroment is disabled
\RenewDocumentCommand{\newmdtheoremenv}{O{} m o m o}{%
	\ifinlist{#2}{\theorem@disable}{%
		\IfStrEq{#2}{theorem}{\newtheorem{#2}{}[section]}{\newtheorem{#2}{}[theorem]}
		\RenewEnviron{#2}{\stepcounter{theorem}}{}
	}{%
		%from mdframed.sty, definition of \newmdtheoremenv
		\ifboolexpr{ test {\IfNoValueTF {#3}} and test {\IfNoValueTF {#5}} }%
		{\newtheorem{#2}{#4}}{%
			\IfValueTF{#3}{\newtheorem{#2}[#3]{#4}}{}%
			\IfValueTF{#5}{\newtheorem{#2}{#4}[#5]}{}%
		}%
		\BeforeBeginEnvironment{#2}{%
			\begin{mdframed}[#1]}%
		\AfterEndEnvironment{#2}{%
		\end{mdframed}%
		}%
	}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Setup theorem environments

%triangle symbol + length
\newlength{\blacktrianglewidth}
\settowidth{\blacktrianglewidth}{$\blacktriangleright$}

%colors
\definecolor{lightgrey}{gray}{0.91}
\definecolor{lightred}{rgb}{1,0.6,0.6}
\definecolor{darkgrey}{gray}{0.6}
\definecolor{darkgreen}{rgb}{0,0.6,0}

\mdfdefinestyle{boxedtheorem}{%
	outerlinewidth=3pt,%
	skipabove=5pt,%
	skipbelow=10pt,%
	frametitlefont=\normalfont\bfseries\color{black},%
%	nobreak,%enforce no pagebrakes in the whole frame
}

%numbered environments
\theoremstyle{\theoremheader@order@val} %set by pacakge options above
\theorembodyfont{}

%including background
\newmdtheoremenv[%
	style=boxedtheorem,%
	innertopmargin=\topskip,%
	innerbottommargin=\topskip,%
	linecolor=darkgrey,%
	backgroundcolor=lightgrey,%
	nobreak
]{theorem}{Theorem}[\theoremcounter@belongingto]

\newmdtheoremenv[%
	style=boxedtheorem,%
	linecolor=darkgrey,%
	topline=false,%
	rightline=false,%
	bottomline=false,%
	innertopmargin=\topskip,%
	innerbottommargin=\topskip,%
	backgroundcolor=lightgrey,%
	nobreak
]{proposition}[theorem]{Satz}

\newmdtheoremenv[%
	style=boxedtheorem,%
	linecolor=darkgrey,%
	topline=false,%
	rightline=false,%
	bottomline=false,%
	backgroundcolor=lightgrey,%
	innertopmargin=\topskip,%
	innerbottommargin=\topskip,%
	nobreak
]{lemma}[theorem]{Lemma}

%excluding background
\newmdtheoremenv[%
	style=boxedtheorem,%
	linecolor=red,%
	topline=false,%
	rightline=false,%
	bottomline=false,%
	innertopmargin=0,%
	innerbottommargin=-3pt,%
]{definition}[theorem]{Definition}

\newmdtheoremenv[%
	outerlinewidth=3pt,%
	linecolor=black,%
	topline=false,%
	rightline=false,%
	bottomline=false,%
	innertopmargin=0pt,%
	innerbottommargin=-0pt,%
	frametitlefont=\normalfont\bfseries\color{black},%
	skipabove=5pt,%	
	skipbelow=10pt,%
]{conclusion}[theorem]{Folgerung}

\newmdtheoremenv[%
	hidealllines=true,%
	frametitlefont=\normalfont\bfseries\color{black},%
	innerleftmargin=0pt,%
	skipabove=5pt,%
	innerleftmargin=10pt,%
]{remark}[theorem]{\hspace*{-10pt}$\blacktriangleright$\hspace*{\dimexpr 10pt - \blacktrianglewidth\relax}Bemerkung}

\newmdtheoremenv[%
	hidealllines=true,%
	frametitlefont=\normalfont\bfseries\color{black},%
	innerleftmargin=0pt,%
	skipabove=5pt,%
	innerleftmargin=10pt,%
]{erinnerung}[theorem]{\hspace*{-10pt}$\blacktriangleright$\hspace*{\dimexpr 10pt - \blacktrianglewidth\relax}Erinnerung}

\newmdtheoremenv[%
	hidealllines=true,%
	frametitlefont=\normalfont\bfseries\color{black},%
	innerleftmargin=10pt,%
	skipabove=5pt,%
]{example}[theorem]{\hspace*{-10pt}\rule{5pt}{5pt}\hspace*{5pt}Beispiel}

\newmdtheoremenv[%
	hidealllines=true,%
	frametitlefont=\normalfont\bfseries\color{black},%
	innerleftmargin=10pt,%
	skipabove=5pt,%
]{algorithm}[theorem]{\hspace*{-10pt}\rule{5pt}{5pt}\hspace*{5pt}Algorithmus}

%unnumbered theorems
\theoremstyle{nonumberbreak}
\theoremindent0cm

\newmdtheoremenv[%
	style=boxedtheorem,%
	linecolor=red,%
	topline=false,%
	rightline=false,%
	bottomline=false,%
	innertopmargin=1pt,%
	innerbottommargin=1pt,%
]{*definition}{Definition}

\newmdtheoremenv[%
	hidealllines=true,%
	frametitlefont=\normalfont\bfseries\color{black},%
	skipabove=5pt,%
	innerleftmargin=10pt,%
]{*remark}{\hspace*{-10pt}$\blacktriangleright$\hspace*{\dimexpr 10pt - \blacktrianglewidth\relax}Bemerkung}

\newmdtheoremenv[%
	hidealllines=true,%
	innerleftmargin=10pt,%
]{*example}{\hspace*{-10pt}\rule{5pt}{5pt}\hspace*{5pt}Beispiel}

\newmdtheoremenv[%
	style=boxedtheorem,%
	hidealllines=true,%
	innertopmargin=\topskip,%
	innerbottommargin=\topskip,%
	backgroundcolor=lightgrey,%
]{*anmerkung}{Anmerkung}

\newmdtheoremenv[%
hidealllines=true,%
frametitlefont=\normalfont\bfseries\color{black},%
innerleftmargin=0pt,%
skipabove=5pt,%
innerleftmargin=10pt,%
]{*erinnerung}{\hspace*{-10pt}$\blacktriangleright$\hspace*{\dimexpr 10pt - \blacktrianglewidth\relax}Erinnerung}

\newmdtheoremenv[%
	style=boxedtheorem,%
	hidealllines=true,%
	innertopmargin=\topskip,%
	innerbottommargin=\topskip,%
	backgroundcolor=lightgrey,%
]{mathematica}{Mathematica/WolframAlpha-Befehle}

\newtheorem{overview}[theorem]{Überblick}

\newmdtheoremenv[
	outerlinewidth=0.1pt,
]{repetition}{Wiederholung}

\newmdtheoremenv[%
	hidealllines=true,%
	frametitlefont=\normalfont\bfseries\color{black},%
	innerleftmargin=0pt,%
	skipabove=5pt,%
	innerleftmargin=10pt,%
]{hint}{\hspace*{-10pt}$\blacktriangleright$\hspace*{\dimexpr 10pt - \blacktrianglewidth\relax}Hinweis}

%various unnumbered thereoms and environment (usually included in theorems like above)
%To get rid of the parentheses, a new theorem style is neccessary (definition of nonumberbreak from ntheorem.sty)
%to achieve the underlining, this needed to put in the theoremstyle definition
\theoremheaderfont{\mdseries}
\theoremseparator{:}
\theorempostskip{0pt}

%define new theorem-styles
\newtheoremstyle{noparentheses}%
{\item[\rlap{\vbox{\hbox{\hskip\labelsep \theorem@headerfont
				\underline{##1}\theorem@separator}\hbox{\strut}}}]}%
{\item[\rlap{\vbox{\hbox{\hskip\labelsep \theorem@headerfont
				\underline{##1\ ##3\theorem@separator}}\hbox{\strut}}}]}
			
\newtheoremstyle{underlinedPlain}%
{\item[\hskip\labelsep \uline{\theorem@headerfont ##1\theorem@separator}]}%
{\item[\hskip\labelsep \uline{\theorem@headerfont ##1\ \theorem@headerfont(##3)\theorem@separator}]}

\newtheoremstyle{plainEnvironment}{}%
{\item[\hskip\labelsep {##1\theorem@headerfont ##3\theorem@separator}]}

\newtheoremstyle{underlinedEnvironment}{}%
{\item[\hskip\labelsep \uline{##1\theorem@headerfont ##3\theorem@separator}]}

\newtheoremstyle{boldEnvironment}{}%
{\item[\hskip\labelsep \textbf{##1\theorem@headerfont ##3\theorem@separator}]}

%theorems
\theoremstyle{noparentheses}
\newmdtheoremenv[%
	hidealllines=true,%
	innerleftmargin=1em,%
	innerbottommargin=0pt,%
	innerrightmargin=0,%
	skipbelow=0pt,%
]{interpretation}{\hspace*{\dimexpr - \mdflength{innerleftmargin}\relax}Interpretation}

%\theoremstyle{underlinedPlain}
%\newmdtheoremenv[%
%	hidealllines=true,%
%	innerleftmargin=1em,%
%	innerrightmargin=0,%
%	skipbelow=0pt,%
%]{hint}{\hspace*{\dimexpr - \mdflength{innerleftmargin}\relax}Hinweis}

\theoremstyle{plainEnvironment}
\newmdtheoremenv[%
	hidealllines=true,%
	innerleftmargin=1em,%
	innerbottommargin=0pt,%
	innerrightmargin=0,%
	skipbelow=0pt,%
]{plainenvironment}{\hspace*{\dimexpr -\mdflength{innerleftmargin}\relax}}

\theoremstyle{underlinedEnvironment}
\newmdtheoremenv[%
	hidealllines=true,%
	innerleftmargin=1em,%
	innerrightmargin=0,%
	skipbelow=0pt,%
]{underlinedenvironment}{\hspace*{\dimexpr -\mdflength{innerleftmargin}\relax}}

\theoremheaderfont{\bfseries}
\theoremstyle{boldEnvironment}
\newmdtheoremenv[%
	hidealllines=true,%
	innerleftmargin=1em,%
	innerrightmargin=0,%
	skipbelow=0pt,%
]{boldenvironment}{\hspace*{\dimexpr -\mdflength{innerleftmargin}\relax}}

%proofs
\newtheoremstyle{proofstyle}%
{\item[\hskip\labelsep {\theorem@headerfont ##1}\theorem@separator]}%
{\item[\hskip\labelsep {\theorem@headerfont ##1}\ (##3)\theorem@separator]}

\theoremstyle{proofstyle}
\theoremheaderfont{\normalfont\normalsize\itshape}
\theorembodyfont{\normalfont\small}
\theoremseparator{.}
\theorempreskip{5pt}
\theorempostskip{5pt}
\theoremsymbol{$\square$}

\ifinlist{proof}{\theorem@disable}{\RenewEnviron{proof}{}{}}{\renewtheorem{proof}{Beweis}}

%cref: print correct translation
\crefname{theorem}{Theorem}{Theoreme}
\crefname{proposition}{Satz}{Sätze}
\crefname{lemma}{Lemma}{Lemmata}
\crefname{conclusion}{Folgerung}{Folgerungen}
\crefname{definition}{Definition}{Definitionen}
\crefname{remark}{Bemerkung}{Bemerkungen}
\crefname{example}{Beispiel}{Beispiele}
\crefname{erinnerung}{Erinnerung}{Erinnerungen}
\crefname{algorithm}{Algorithmus}{Algorithmen}
\crefname{*definition}{Definition}{Definitionen}
\crefname{*remark}{Bemerkung}{Bemerkungen}
\crefname{*example}{Beispiel}{Beispiele}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Additional features

%some minor commands
\newcommand*{\rom}[1]{\expandafter\@slowromancap\romannumeral #1@} %print integer in capital roman letters
\newcommand{\leqnos}{\tagsleft@true\let\veqno\@@leqno}	%set equation numbering left / right
\newcommand{\reqnos}{\tagsleft@false\let\veqno\@@eqno}

\zref@newprop{sectionnumber}[\@z]{}
\zref@newprop{theoremnumber}[\@z]{}
\zref@newprop{chapternumber}[\@z]{}

%renew zref properties only once, when the counter gets updated
\pretocmd{\section}{\zref@setcurrent{sectionnumber}{\arabic{section}}}{}{}
\pretocmd{\chapter}{\zref@setcurrent{chapternumber}{\arabic{chapter}}}{}{}

%declare a new label; store current chapter number
\newcommand*{\proplbl}[1]{%
	\@bsphack
	\begingroup
	\label{#1}%
	\zref@setcurrent{theoremnumber}{\arabic{theorem}}
	%chapternumber, sectionnumber are updated at each \section / \chapter-command
	\zref@labelbyprops{#1}{chapternumber,sectionnumber,theoremnumber}
	\endgroup
	\@esphack
}

%refer to a label set by proplbl.
%If the label is not defined (yet), question marks are output at the calling position. If the label is defined, the chapter number is prepended to the link output by \cref if the current chapter number and the one set when calling \proplbl differ.
%the macro handels both text and math mode. mbox is needed due to a feature concerning ulem / cleveref
\newcommand*{\propref}[1]{%
	\zref@ifrefundefined{#1}%in first compilation the label may not be defined yet
	{\begingroup\ifmmode\else\bfseries\fi ???\endgroup}%similar to \ref\cref: question marks in case of undefined labels
	{%
		\zref@refused{#1}%
		\cref@gettype{#1}{\propositionref@current@type}%get the environment's name
		\ifnumcomp{\c@chapter}{=}{\zref@extract{#1}{chapternumber}}%
		{%same chapter
			\ifmmode 
				\text{\ref{#1}}%
			\else
				\mbox{\cref{#1}}%
			\fi
		}%
		{%otherwise
			%example for following line:
			%\crefformat{truetheorem}{\cref@truetheorem@name~##2\rom{\zref@extractdefault{#1}{#1chapter}{1}}.##1##3}
			%this changes the format used by \cref to <environtment name> <chapter-number>.<section-number>.<theorem number>
			\crefformat{\propositionref@current@type}{%
				\csname cref@\propositionref@current@type @name\endcsname ~##2\rom{\zref@extract{#1}{chapternumber}}.##1##3%
			}%
			\ifmmode
				\hyperref[#1]{\text{\rom{\zref@extract{#1}{chapternumber}}.\zref@extract{#1}{sectionnumber}.\zref@extract{#1}{theoremnumber}}}%
			\else
				\mbox{\cref{#1}}%
			\fi
			\crefformat{\propositionref@current@type}{%
				\csname cref@\propositionref@current@type @name\endcsname~##2##1##3%
			}%
		}%
	}%
}

%declare new term to the index, output if no star is given to call position
\NewDocumentCommand{\begriff}{s O{} m O{}}{%
	\uline{#3}%
	\IfBooleanTF{#1}{}{\index{#2#3#4}}%
}

%append a new mathsymbol to the index, output if no star is given at the call position
\NewDocumentCommand{\mathsymbol}{s O{} m m O{}}{%
	\IfBooleanTF{#1}%
	{\index[symbols]{#2#3@\detokenize{#4}#5}}%
	{#4\index[symbols]{#2#3@\detokenize{#4}#5}}%
}

%remove skip before / after amsmath-environments: default to 0pt. 1star: just before the environment, 2stars: just after the environment, no star: both
\NewDocumentCommand{\zeroAmsmathAlignVSpaces}{s s O{0 pt} O{0 pt}}{%
	\IfBooleanTF{#1}%
	{%
		\IfBooleanTF{#2}%
		{\setlength{\belowdisplayskip}{#4}}%
		{\setlength{\abovedisplayskip}{#3}}%
	}%
	{%
		\setlength{\abovedisplayskip}{#3}%
		\setlength{\belowdisplayskip}{#4}%
	}%
}

\NewDocumentCommand{\itemEq}{s m}{%
	\begingroup%
	\setlength{\abovedisplayskip}{\dimexpr -\parskip + 1pt\relax}%
	\setlength{\belowdisplayskip}{0pt}%
	\IfBooleanTF{#1}%
	{\parbox[c]{\linewidth}{\begin{flalign*}#2&&\end{flalign*}}}%}
	{\parbox[c]{\linewidth}{\begin{flalign}#2&&\end{flalign}}}%}
	\endgroup% 
}

%macro that defines the spacing between bracket and content of a matrix
\NewDocumentCommand{\matrixBracketSpacing}{}{\mspace{4.0mu plus 3.0mu minus 1.0mu}}
%macro width customized spacing between bracktes / content, lineheight and columnwidth
\newenvironment{henrysmatrix}{%
	\renewcommand*{\arraystretch}{1.2}
	\setlength\arraycolsep{5pt}
	\left(\matrixBracketSpacing
	\begin{matrix}
	}{%
	\end{matrix}
	\matrixBracketSpacing\right)
}

%redefine \overline to customize the space between text / line (currently 0.4mm + height of the content)
%ATTENTION: when changing the 0.4mm unfortunately, in \kringel the 0.4mm need to be changed accordingly
%\let\@old@overline\overline
%\RenewDocumentCommand{\overline}{s m}{%
%	\IfBooleanTF{#1}%
%	{\@old@overline{#2}}%
%	{%
%		\ifmmode
%			\@old@overline{\raisebox{0pt}[\dimexpr\height+0.4mm\relax]{$#2$}}%
%		\else
%			\@old@overline{\raisebox{0pt}[\dimexpr\height+0.4mm\relax]{#2}}%
%		\fi
%	}%
%}

%encircle some content. Arguments: border color (optional), background color (mandatory), content (mandatory)
%two lengths to get width / height of content (important for width / height of the circle)
\newlength{\@kringel@contentheight}
\newlength{\@kringel@contentwidth}
\newlength{\@kringel@depth}
\NewDocumentCommand{\kringel}{O{blue} m m}{%
	%as the macro should work for both text and math mode, add some macros for later use to distinguish
	%in text mode, nothing happens (except discarding the 1st argument for the raisebox, that is permantently given), in math mode, the content needs to be enbraced by \ensuremath, the tcolorbox-environment by a raisebox
	%ATTENTION: when changing the height-factor of tcolorbox, the depth correction needs to be changed as well
	\let\@kringel@inner\relax
	\let\@kringel@outer\@secondoftwo
	\ifmmode
		\let\@kringel@inner\ensuremath
		\let\@kringel@outer\raisebox
	\fi
	%set the width and height
	\settoheight{\@kringel@contentheight}{\hbox{\@kringel@inner{#3}}}
	\settowidth{\@kringel@contentwidth}{\@kringel@inner{#3}}
	\settodepth{\@kringel@depth}{\@kringel@inner{#3}}
	%change the depth correction dependend whethere there is a depth (e.g. y) or not (e.g. a)
	\ifdim \@kringel@depth > 0pt%
		\setlength{\@kringel@depth}{\dimexpr\@kringel@depth+0.5mm\relax}
	\else
		\settodepth{\@kringel@depth}{y}
		\setlength{\@kringel@depth}{\dimexpr\@kringel@depth+0.3mm\relax}
	\fi
	%output the colorbox width given parameter: frame color, background color, computed width and height, and escaped content depending on math / text mode
	\@kringel@outer{\dimexpr-\@kringel@contentheight/2-\@kringel@depth\relax}{\begin{tcolorbox}[colframe=#1,halign=center,=center,width=\dimexpr1.5\@kringel@contentwidth+1mm\relax,height=2.5\@kringel@contentheight,left=0pt,right=0pt,bottom=0pt,top=0pt,boxrule=0.8pt,colback=#2,boxsep=0pt,bean arc]
			\@kringel@inner{#3}
	\end{tcolorbox}}
}

%https://tex.stackexchange.com/questions/7032/good-way-to-make-textcircled-numbers
\newcommand*\circled[1]{\tikz[baseline=(char.base)]{
		\node[shape=circle,draw,inner sep=2pt] (char) {#1};}}

%update ntheorem macro to provide space between theorem numbers and any optional comment, adds in upper roman letters the chapter number. removes any numbering for theorem environments with just one counter
\renewcommand{\thm@@thmline@name}[5]{%-       		
	\def\thm@@thmline@name@tmp{%
		\if\relax\detokenize{#3}\relax\else%
			{\hspace*{2.2ex}#3}%
		\fi%
	}
	\let\thm@@thmline@name@numbering\relax
	\StrCount{#5}{.}[\thm@@thmline@name@dot@number]
	\ifnum\thm@@thmline@name@dot@number < 3%
		\ifnum\thm@@thmline@name@dot@number = 2%
			\def\thm@@thmline@name@numbering{\rom #2}
		\else
			\def\thm@@thmline@name@tmp{\hspace*{-1em}#3}
		\fi
	\else%
		\StrBetween[1,2]{#5}{.}{.}[\thm@@thmline@name@chap@num]%get the chapter number for roman transliteration
		\def\thm@@thmline@name@numbering{\rom{\thm@@thmline@name@chap@num}.#2}
	\fi
	\ifx\\#5\\%
		\@dottedtocline{-2}{0em}{4.4em}%
		{#1 \protect\numberline{\thm@@thmline@name@numbering:}{}}%
		{#4}
	\else
		\ifHy@linktocpage\relax\relax
			\@dottedtocline{-2}{0em}{1.3em}%
			{#1 \protect\numberline{\thm@@thmline@name@numbering:}\thm@@thmline@name@tmp}%
			{\hyper@linkstart{link}{#5}{#4}\hyper@linkend}%
		\else
			\@dottedtocline{-2}{0em}{4.em}%
			{#1 \protect\numberline{\thm@@thmline@name@numbering:}\thm@@thmline@name@tmp}%
			{\hyper@linkstart{link}{#5}{#4}\hyper@linkend}%
		\fi
	\fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%Settings

%disable brackets left for linear systems by systeme-package
\sysdelim..

\pdfstringdefDisableCommands{%
	\def\\{}%
	\def\texttt#1{<#1>}%
	\def\mathbb#1{<#1>}%
}
%numbers of numbered equations appear on the righthand side
\reqnos

%Headings
\titlelabel{\thetitle.\quad}%. behind section/sub... (3. instead of 3)
\counterwithout{section}{chapter}
\renewcommand{\thechapter}{\Roman{chapter}}
\renewcommand{\thepart}{\Alph{part}}
%italic chapters (due to titlesec package some more stuff)
%\titleformat{command}[shape]{format}{label}{sep}{before-code}[after-code]
\titleformat{\chapter}[display]{\bfseries}{\Large\chaptername\;\thechapter}{-5pt}{\huge\bfseries\itshape}
\titlespacing{\chapter}{0pt}{0pt}{10pt}
\titleformat{\section}[hang]{\bfseries\Large}{\thesection.}{8pt}{\Large\bfseries}
%\titlespacing{command}{left}{before-sep}{after-sep}
\titlespacing{\subsection}{0pt}{10pt}{5pt}

%change appearence of heading of toc: 0 space above, bold, italic huge toc-heading
\renewcommand{\cftbeforetoctitleskip}{0pt}
\renewcommand{\cfttoctitlefont}{\itshape\Huge\bfseries}
%change indentations due to width of capital roman numbers
\renewcommand{\cftchapnumwidth}{2.5em}
\renewcommand{\cftsecindent}{2.5em}
\renewcommand{\cftsubsecindent}{4.8em}

% Add new page-style (just footer), patch \chapter command to use this page style
\fancypagestyle{plainChapter}{%
	\fancyhf{}%
	\fancyfoot[C]{\thepage}%
	\renewcommand{\headrulewidth}{0pt}% Line at the header invisible
	\renewcommand{\footrulewidth}{0.4pt}% Line at the footer visible
}
%changes pagestyle; instead of empty page the normal footer is printed
\patchcmd{\chapter}{\thispagestyle{plain}}{\thispagestyle{plainChapter}}{}{}
%usually, after a new chapter the section counter needs to be reset manually. Instead, automatic reset
\ifreset@section@after@chapter
	\pretocmd{\chapter}{\setcounter{section}{0}}{}{}
\fi

\pagestyle{fancy}
\pagenumbering{arabic}
%remember chapter-title in \leftmark and \rightmark
\renewcommand{\chaptermark}[1]{%
	\markboth{\chaptername
		\ \thechapter:\ #1}{}}
%remember section title in \leftmark
\renewcommand{\sectionmark}[1]{%
	\markright{\thesection.\ #1}{}}

%remove page number from part{}-pages
\let\sv@endpart\@endpart
\def\@endpart{\thispagestyle{empty}\sv@endpart}

%change header:
\renewcommand{\headrulewidth}{0.75pt}
\renewcommand{\footrulewidth}{0.3pt}
\lhead{\rightmark}%left: section-number. section-title
\rhead{\leftmark}%right: chapter chapternumber: chapter-title

%change numbering of equations to be section by section
\counterwithout{equation}{section}
\ifreset@equation@number@after@section
	\pretocmd{\section}{\setcounter{equation}{0}}{}{}
\fi

\renewcommand{\thetheorem}{\arabic{\theoremcounter@belongingto}.\arabic{theorem}}

%appendix:
\let\old@appendix\appendix
\def\appendix{%
	\old@appendix%
	\patchcmd{\chapter}{\thispagestyle{plainChapter}}{\thispagestyle{fancy}}{}{}%
	\renewcommand{\chaptername}{Anhang}%
	\renewcommand{\thesection}{\Alph{chapter}.\arabic{section}}%
	\titleformat{\chapter}[hang]{\bfseries}{\LARGE\chaptername\ \thechapter:}{0.5em}{\LARGE\bfseries}%
	\titlespacing{\chapter}{0pt}{-0.75cm}{0pt}%
}

\AtBeginDocument{%
}

\endinput
