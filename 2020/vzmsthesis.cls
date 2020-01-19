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
% Providing custom commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% For the reference list

\newcommand{\litlist}{
	\smallskip \centerline{\bf
		\expandafter\iflanguage{russian}{Литература}{References}
	}\nopagebreak
}
