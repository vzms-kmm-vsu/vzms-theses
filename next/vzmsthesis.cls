\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{vzmsthesis}[2022/10/15 Voronezh Winter Mathematical School]

% We have no options yet
% https://www.overleaf.com/learn/latex/Writing_your_own_class#Options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[a5paper,12pt,openbib]{article}

% First of all, we deal with encodings and basic fonts

\RequirePackage[utf8]{inputenc}
\RequirePackage[T2A,T1]{fontenc}
\RequirePackage[english,russian]{babel}
% And support BOM!
\DeclareUnicodeCharacter{FEFF}{}


% Graphics and related tricks

\RequirePackage{graphics}
\RequirePackage[dvips]{graphicx}
\RequirePackage{wrapfig}
\DeclareGraphicsExtensions{.pdf,.png,.jpg}


% Page geometry

\RequirePackage{geometry}
\geometry{verbose,a5paper,tmargin=1.75cm,bmargin=2.1cm,lmargin=1.75cm,rmargin=1.75cm}
\RequirePackage{lscape}

% ... and "fancy" headers
% (indeed, it looks like default headers are removed)

\RequirePackage{fancyhdr}
\fancyhf{}
\fancyfoot[C]{\vspace{-25pt}\thepage}
\renewcommand{\headrulewidth}{0pt}


% Packages that we need for development purposes
% (e.g. creating new macros)

\RequirePackage{ifthen}
\RequirePackage{etoolbox}


% {ams*} packages are a gold standart in LaTeX

\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}

% ... but, obviously, sometimes we need some others!

\RequirePackage{enumerate}
\RequirePackage{euscript}
\RequirePackage[shortcuts]{extdash}
\RequirePackage{hhline}
\RequirePackage{latexsym}
\RequirePackage{mathrsfs}
\RequirePackage{multirow}
\RequirePackage{needspace}
\RequirePackage[overload]{textcase}
\RequirePackage{textcomp}
\RequirePackage[colorlinks=true, linktocpage=true, allcolors=black]{hyperref}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Now we will adjust some settings for typesetting the text

\righthyphenmin=2
\lefthyphenmin=2
\clubpenalty=10000
\widowpenalty=10000

\renewcommand{\paragraph}{%
  \@startsection{paragraph}{4}%
  {\z@}{1.25ex \@plus 1ex \@minus .2ex}{-1em}%
  {\normalfont\normalsize\bfseries}%
}


% ... and decorate the bibliography

\renewcommand{\@biblabel}[1]{#1.} % Заменяем библиографию с квадратных скобок на точку:

\addto{\captionsenglish}{%
  \renewcommand{\refname}{{\protect\litlist}}%
  \renewcommand{\bibname}{{\protect\litlist}}%
}

\addto{\captionsrussian}{%
  \renewcommand{\refname}{{\protect\litlist}}%
  \renewcommand{\bibname}{{\protect\litlist}}%
}

% Remove hanging indent: https://tex.stackexchange.com/questions/598668/remove-left-indentation-in-bibliography
\patchcmd{\thebibliography}{\leftmargin\labelwidth}{\leftmargin\labelwidth{}\addtolength{\leftmargin}{\parindent}}{}{}
\def\bibindent{-2\parindent}

% Remove vertical spacing from the reference list
% in case of `thebibliography` environment
% https://tex.stackexchange.com/questions/93859/condense-the-space-between-bibliographic-entries
\apptocmd{\thebibliography}{\setlength{\parskip}{0pt}\setlength{\itemsep}{0pt plus 0.3ex}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Providing custom commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% For the reference list

\newcommand{\litlist}{
	\smallskip \centerline{\bf
		\normalsize\expandafter\iflanguage{russian}{Литература}{References}
	}\nopagebreak
}

% The following commands are the dark magic which generates headers

\newcommand{\vzmsyear}{2022}


\def\varvzmsauthor{}
\def\varvzmsauthortoc{}
\def\varvzmstitle{}
\def\varvzmstitleopt{}
\def\varvzmsflushedauthors{}
\def\defaultvzmsbeforeauthor{\textcopyright \vzmsyear \  }
\def\varvzms@previous@author@item{none}

\newcommand{\vzmsauthor}[2]{%

	\ifthenelse{
		\equal{\varvzms@previous@author@item}{author}
	}{
		\g@addto@macro\varvzmsflushedauthors{, }
	}{
		\g@addto@macro\varvzmsflushedauthors{\defaultvzmsbeforeauthor }
	}


	\g@addto@macro\varvzmsflushedauthors{{\it #2~#1}}

	\ifthenelse{
		\equal{\varvzmsauthortoc}{}
	}{
		\def\varvzmsauthortoc{#1\,\,#2}
	}{
		\g@addto@macro\varvzmsauthortoc{,\hspace{0.7em}#1\,\,#2}
	}
	\def\varvzms@previous@author@item{author}
}

\newcommand{\vzmstitle}[2][]{
	\def\varvzmstitle{#2}
	\def\varvzmstitleopt{#1}
}

\newcommand{\vzmsinfo}[1]{
	\g@addto@macro\varvzmsflushedauthors{\ \\ \bgroup(#1)\egroup \\}
	\def\varvzms@previous@author@item{info}
}

\newcommand{\vzmscaption}{
	%\begin{minipage}{c}
	\needspace{12em}
	%\vbox{
	\begin{center}%\nopagebreak
		\textbf{\MakeUppercase{
			\varvzmstitle
		}\varvzmstitleopt
		}
		 \ \\
		\varvzmsflushedauthors %\\
	\end{center}
	%\nopagebreak
	%\needspace{5em}
	%}
	%\end{minipage}
	\addcontentsline{toc}{section}{\varvzmsauthortoc\dotfill}
	%\needspace{20em}


	\def\varvzmsauthor{}
	\def\varvzmsauthortoc{}
	\def\varvzmstitle{}
	\def\varvzmsflushedauthors{}
	\def\varvzmstitleopt{}
	\def\varvzms@previous@author@item{none}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Now, we are going to provide some frequent custom commands.
% Note that we refuse to copy all the new commands invented by authors.
% Here we define only such commands that _are expected to work_.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% First of all, the numero sign (if it is not available):

\providecommand{\No}{№}


% The list of widely used mathematical operators

\newcommand{\varDeclareMathOperator}[2]{
	\newcommand{#1}{\mathop{\mathrm{#2}}}
}

\varDeclareMathOperator{\diag}{diag}
\varDeclareMathOperator{\Ker} {Ker}
\varDeclareMathOperator{\Lin} {Lin}
\varDeclareMathOperator{\Hol} {Hol}
\varDeclareMathOperator{\ind} {ind}
\varDeclareMathOperator{\Ind} {Ind}
\varDeclareMathOperator{\Dim} {Dim}
\varDeclareMathOperator{\rank}{rank}

\varDeclareMathOperator{\osc} {osc}
\varDeclareMathOperator{\ess} {ess}
\varDeclareMathOperator{\esssup} {ess\,sup}
\varDeclareMathOperator{\essinf} {ess\,inf}
\varDeclareMathOperator{\essosc} {ess\,osc}
