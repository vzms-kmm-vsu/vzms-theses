\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{vzmsthesis}[2020/01/20 Voronezh Winter Mathematical School]

\LoadClass[a5paper,12pt,openbib]{report}


% First of all, we deal with encodings and basic fonts

\RequirePackage[utf8]{inputenc}
\RequirePackage[T2A,T1]{fontenc}
\RequirePackage[english,russian]{babel}


% Graphics and related tricks

\RequirePackage{graphics}
\RequirePackage[dvips]{graphicx}
\RequirePackage{wrapfig}


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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Now we will adjust some settings for typesetting the text

\righthyphenmin=2
\lefthyphenmin=2
\clubpenalty=10000
\widowpenalty=10000



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Providing custom commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% For the reference list

\newcommand{\litlist}{
	\smallskip \centerline{\bf
		\expandafter\iflanguage{russian}{Литература}{References}
	}\nopagebreak
}

% The following commands are the dark magic which generates headers

\def\pretovar#1#2{\edef#1{\unexpanded{#2}\unexpanded\expandafter{#1}}}
\def\addtovar#1#2{\edef#1{\unexpanded\expandafter{#1#2}}}

\def\varvzmsauthor{}
\def\varvzmsauthortoc{}
\def\varvzmstitle{}
\def\varvzmstitleopt{}
\def\varvzmsflushedauthors{}

\newcommand{\vzmsauthor}[2]{%
	\ifthenelse{
		\equal{\varvzmsauthor}{}
	}
	{
		\def\varvzmsauthor{#2~#1}
	}{
		\addtovar\varvzmsauthor{, #2~#1}
	}
	\ifthenelse{
		\equal{\varvzmsauthortoc}{}
	}
	{
		\def\varvzmsauthortoc{#1~#2}
	}{
		\addtovar\varvzmsauthortoc{, #1~#2}
	}
}

\newcommand{\vzmsflushauthors}{
	\ifthenelse{
		\equal{\varvzmsflushedauthors}{}
	}{
		%\addtovar\varvzmsflushedauthors{{\noexpand\it{\varvzmsauthor}}}
		\edef\varvzmsflushedauthors{{\noexpand\textcopyright \ 2018 \ \noexpand\it{\varvzmsauthor}}}
		%\edef\varvzmsflushedauthors{\varvzmsauthor}
	}{
		\ifthenelse{
			\equal{\varvzmsauthor}{}
		}{
		}{
			\edef\vartmp{\varvzmsauthor}
			\addtovar\varvzmsflushedauthors{\\ {\textcopyright} 2018 \  {\it\vartmp}}
			%\addtovar\varvzmsflushedauthors{\varvzmsauthor}
		}
	}
	\def\varvzmsauthor{}
}

\newcommand{\vzmstitle}[2][]{
	\def\varvzmstitle{#2}
	\def\varvzmstitleopt{#1}
}

\newcommand{\vzmsinfo}[1]{
	\vzmsflushauthors
	\addtovar\varvzmsflushedauthors{\ \\ (#1)}
}

\newcommand{\vzmscaption}{
	\vzmsflushauthors
	\vzmsflushauthors

	%\begin{minipage}{c}
	\needspace{20em}
	%\vbox{
	\begin{center}%\nopagebreak
		\textbf{\MakeUppercase{
			\varvzmstitle
		}\varvzmstitleopt
		}
		 \ \\
		\varvzmsflushedauthors %\\
	%\needspace{5em}
	\end{center}
	%}
	%\end{minipage}
	\addcontentsline{toc}{section}{\varvzmsauthortoc}
	%\needspace{20em}


	\def\varvzmsauthor{}
	\def\varvzmsauthortoc{}
	\def\varvzmstitle{}
	\def\varvzmsflushedauthors{}
	\def\varvzmstitleopt{}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
