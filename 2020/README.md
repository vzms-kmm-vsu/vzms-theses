## Структура:

* auxpages - вспомогательные страницы типа титульника

* main.tex - основной файл, в который подключены все остальные. Его и собирать!

* Data - TeXовские файлы. Голенькие, без преамбул, в utf8. Аспиранток, присылающих в utf8, рекоменуется брать на заметку как адекватных.

* Data/pic - картинки к ТеХовским файлам.

* Data/* - всякие там подрубрики.

* utf8.sh - перекодирование всего в utf8 насильно (независимо от того, в чём оно было, на выходе будет utf8)

## Борьба с переполнениями (Overfull)

Переполнение - это когда текст вылезает на правые поля.
Бороться с переполнениями можно на любом этапе сбора тезисов:
это "горизонтальная" вёрстка и она не повредится от добавления новых материалов.

### Поиск переполнений

Запускаем: `make overfull`

**Внимание! Если сборка (обычный `make`) идёт с ошибками, то перед ловлей переплнений эти ошибки нужно устранить! **

По итогам запуска появится вывод наподобие такого:

```
******* Processing thesis BezmelnitsynaYu *******
*
(./Data/BezmelnitsynaYu.tex [220]
Overfull \hbox (1.72566pt too wide) in paragraph at lines 19--20
\T1/cmr/m/n/12 nonempty, closed and, re-spec-tively, com-pact sub-sets of the s
pace
\T1/cmr/m/it/12 sur-able \T1/cmr/m/n/12 if, for each open sub-set $\OML/cmm/m/i
t/12 W \OMS/cmsy/m/n/12 ^^Z \OML/cmm/m/it/12 Y;$ \T1/cmr/m/n/12 its pre-image
[221] [222]
Overfull \hbox (2.32175pt too wide) in paragraph at lines 84--93
\OT1/cmr/m/n/12
$ \T1/cmr/m/n/12 there ex-ists $\OML/cmm/m/it/12 k[]\OT1/cmr/m/n/12 (\OML/cmm/m
/it/12 r\OT1/cmr/m/n/12 ) \OML/cmm/m/it/12 > r$ \T1/cmr/m/n/12 such that if $\O
ML/cmm/m/it/12
               []\OT1/cmr/m/n/12 (\OML/cmm/m/it/12 !\OT1/cmr/m/n/12 ) := []\OM
S/cmsy/m/n/12 f\OML/cmm/m/it/12 V\OT1/cmr/m/n/12 (\OML/cmm/m/it/12 !; x\OT1/cmr
/m/n/12 )\OML/cmm/m/it/12 ; \OMS/cmsy/m/n/12 k\OML/cmm/m/it/12 x\OMS/cmsy/m/n/1
2 k ^^T
[223]
Overfull \hbox (6.8948pt too wide) in paragraph at lines 131--132
\T1/cmr/m/n/12 the Tra-jec-to-ries of Dif-fer-en-tial Equa-tions. Trans-la-tion
s of Mathe-
)
*
******* End of thesis BezmelnitsynaYu *******
*
*
******* Processing thesis GetmanovaEk *******
*
(./Data/GetmanovaEk.tex [224] [225]
Overfull \hbox (1.37575pt too wide) in paragraph at lines 36--38
[]\T2A/cmr/m/n/12 For $\OML/cmm/m/it/12 ^^\ > \OT1/cmr/m/n/12 0$ \T2A/cmr/m/n/1
2 we denote by the symbol $\OMS/cmsy/m/n/12 C$ \T2A/cmr/m/n/12 the space $\OML/
cmm/m/it/12 C\OT1/cmr/m/n/12 ([\OMS/cmsy/m/n/12 ^^@\OML/cmm/m/it/12 ^^\; \OT1/c
mr/m/n/12 0]; \U/msb/m/n/12 R[]\OT1/cmr/m/n/12 )$
\T2A/cmr/m/n/12 is locally integrable, and we have for each $\OML/cmm/m/it/12 !
 \OMS/cmsy/m/n/12 2 \OT1/cmr/m/n/12
$
[226]
\OT1/cmr/m/n/12 (\OML/cmm/m/it/12 i\OT1/cmr/m/n/12 )$ $\OML/cmm/m/it/12 V\OT1/c
mr/m/n/12 (\OMS/cmsy/m/n/12 ^^A\OML/cmm/m/it/12 ; x\OT1/cmr/m/n/12 ) [] []
 \OMS/cmsy/m/n/12 ! \U/msb/m/n/12 R$ \T2A/cmr/m/n/12 is measurable for every $\
OML/cmm/m/it/12 x \OMS/cmsy/m/n/12 2 \U/msb/m/n/12 R[]$\T2A/cmr/m/n/12 ;
pdflatex main.tex | grep -c Overfull
215
nickolaus@nicknout:/media/work2/git/vzms-2020/2020$
```

Последнее число (`215` в нашем примере) показывает, насколько много ошибок осталось (не уверен, что точное их количество).

Строчки вроде вот этой:

```
******* Processing thesis GetmanovaEk *******
```

помогают ориентироваться, в каком файле проблема.
Кроме того, приложены:

 + цитата: `is locally integrable, and we have for each`,

 + номера строк файла-исходника, в которых расположен проблемный абзац:
`in paragraph at lines 36--38`
 + номера страниц PDF-файла в квадратных скобках:
`[224] [225]`.

Иногда расположение оказывается не очень точным (например, последний абзац может оказаться после строчки `End of ...`),
но в целом ориентироваться можно, и весьма удобно.

### Исправление переполнений

В ряде случаев помогает просто правильно выставить язык:
`\selectlanguage{english}` перед всей статьёй, если она на английском, или в списке литературы;
аналогично - `\selectlanguage{russian}` перед русскими ссылками в списке литературы,
если перед ними идёт английский текст.
Иногда (независимо от предыдущего пункта) надо добавить или, наоборот, убрать на\-сильст\-венные переносы.
Для формул помните про `\begin{multline*}`

