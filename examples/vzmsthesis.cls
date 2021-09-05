\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{vzmsthesis}[2021/09/05 Voronezh Winter Mathematical School]

% We have no options yet
% https://www.overleaf.com/learn/latex/Writing_your_own_class#Options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[a5paper,12pt,openbib]{article}

% First of all, we deal with encodings and basic fonts

\RequirePackage[cp1251,utf8]{inputenc}
\RequirePackage[T2A,T1]{fontenc}
\RequirePackage[english,russian]{babel}


% Graphics and related tricks

\RequirePackage{graphics}
\RequirePackage[dvips]{graphicx}
\RequirePackage{wrapfig}
\DeclareGraphicsExtensions{.pdf,.png,.jpg}


% Page geometry


\RequirePackage[
	tmargin=1.75cm,
	bmargin=2.1cm,
	lmargin=1.75cm,
	rmargin=1.75cm
]{geometry}
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
\RequirePackage{amsthm}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}

% ... but, obviously, sometimes we need some others!

\RequirePackage{enumerate}
\RequirePackage{enumitem}
\RequirePackage{euscript}
\RequirePackage[shortcuts]{extdash}
\RequirePackage{hhline}
\RequirePackage{latexsym}
\RequirePackage{mathrsfs}
\RequirePackage{multirow}
\RequirePackage{needspace}
\RequirePackage[overload]{textcase}
\RequirePackage{textcomp}
\usepackage[colorlinks=true, urlcolor=blue, linkcolor=black]{hyperref}


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

%... waste less space on lists...
\setlist[itemize,1]{leftmargin=0.9em}


% And decorate the bibliography

\renewcommand{\@biblabel}[1]{#1.} % Заменяем библиографию с квадратных скобок на точку:

\addto{\captionsenglish}{%
  \renewcommand{\refname}{{\protect\litlist}}%
  \renewcommand{\bibname}{{\protect\litlist}}%
}

\addto{\captionsrussian}{%
  \renewcommand{\refname}{{\protect\litlist}}%
  \renewcommand{\bibname}{{\protect\litlist}}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Providing custom commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% For the reference list

\newcommand{\litlist}{
	\smallskip \centerline{\bf
		\normalsize\expandafter\iflanguage{russian}{
			\CYRL\cyri\cyrt\cyre\cyrr\cyra\cyrt\cyru\cyrr\cyra%Литература
		}{References}
	}\nopagebreak
}

% The following commands are the dark magic which generates headers

\newcommand{\vzmsyear}{2020}


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
		\def\varvzmsauthortoc{#1~#2}
	}{
		\g@addto@macro\varvzmsauthortoc{, #1~#2}
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
	\addcontentsline{toc}{section}{\varvzmsauthortoc}
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
