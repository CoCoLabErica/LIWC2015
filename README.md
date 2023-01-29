# LIWC2015
A program built on LIWCalike and quanteda to produce LIWC2015 results

Note: This program does not provide LIWC dictionaries, users need to have LIWC dictionary files to produce [LIWC2015](https://www.liwc.app/static/documents/LIWC2015%20Manual%20-%20Development%20and%20Psychometrics.pdf) results.

### Installation
The following packages need to be installed for this program to work:

``` r
# Run this code in your R Console if they are not installed
install.packages("quanteda")
install.packages("devtools")
devtools::install_github("kbenoit/quanteda.dictionaries")
```

This program is built on the [quanteda package](https://github.com/kbenoit/quanteda) and the `LIWCalike()` from the [quanteda.dictionaries package](https://github.com/kbenoit/quanteda.dictionaries), which are great packages for text analysis created by [Professor Kenneth Benoit](https://kenbenoit.net/). To know more about the history and rationale behind `LIWCalike()`, you can refer to its old README file at <https://github.com/kbenoit/LIWCalike/blob/master/README_old.md>.

### How to use

To use `liwc2015()`, pass the LIWC dictionary file .dic and the text folder to the function as shown in the [example.R](https://github.com/CoCoLabErica/LIWC2015/blob/main/example.R) file. The program will then read all .txt files in the folder, pre-process the text to split on periods and commas before using [liwcalike()](https://github.com/kbenoit/quanteda.dictionaries), count words with numeric value as numbers like LIWC2015, and save the LIWC analysis results as .csv file.

``` r
# Read code from liwc2015.R
source("liwc2015.R")
# Get LIWC2015 results
liwc2015("liwc.dic","example")
liwc2015("liwc.dic","example/InauguralTexts")
```

### Why I created this

The reason why I created this program is [I found that LIWC2015 splits on periods in abbreviations but liwcalike() does not](https://github.com/kbenoit/quanteda.dictionaries/issues/38). To make the comparison easy, this program could split on periods and commas and also count words with numeric value as numbers like LIWC2015. To understand the difference, you can compare the analysis results such as `WC` (Word Count) and `number` for [JonBenet Ramsey note](https://github.com/CoCoLabErica/LIWC2015/blob/main/example/JonBenetRamsey_note.txt) outputted by the [LIWC2015 software](https://youtu.be/YqgBViXWKoM?t=71), `LIWCalike()`, and `liwc2015()`.

``` r
# The output of liwcalike()
x <- readr::read_file("example/JonBenetRamsey_note.txt")
quanteda.dictionaries::liwcalike(x, dictionary = liwc_dict, remove_punct = TRUE, remove_symbols = TRUE)[["WC"]]
# 374
quanteda.dictionaries::liwcalike(x, dictionary = liwc_dict, remove_punct = TRUE, remove_symbols = TRUE)[["number"]]
# 0.27 (i.e., only 1 number is found in the text)

# The output of liwc2015()
results <- liwc2015("liwc.dic","example")
# "Results saved as R-LIWC2015 Results JonBenetRamsey_note 2023-01-28 204308.csv"
results$WC
# 382
results$number
# 3.66 (i.e., 14 numbers are found in the text)
```

### Future work

Since `LIWCalike()` and the LIWC2015 software still have other differences on tokenization, `liwc2015()` needs to further pre-process the inputted text and/or post-process the analysis results outputted by `LIWCalike()`.

For example, ["LIWC2015 counts red-shirted as two words (since it is not in the LIWC dictionary), and ex-boyfriend as a single word since it is in the dictionary."](https://www.liwc.app/static/documents/LIWC2015%20Manual%20-%20Operation.pdf) rather than pre-defined splitting all or none of the hyphenated words (i.e., `split_hyphens = TRUE` or `split_hyphens = FALSE`).

In general, LIWC2015 will check if the word is in the LIWC dictionary before splitting, such as :( will not be split as : and ( because it is in the LIWC dictionary (Affect, Negemo, Informal and Netspeak categories). Therefore, punctuation should not be pre-defined as removed all or none (i.e., `remove_punct = TRUE` or`remove_punct = FALSE`).

### Remark
`liwc2015()` is created for studying and comparing `LIWCalike()` and the LIWC2015 software, this program is not a replacement of the LIWC2015 software. LIWC created by [Professor James Pennebaker](https://scholar.google.com/citations?user=KYOCMe0AAAAJ&hl=en) is a very comprehensive computerized text analysis tool. To get the complete feature and the latest LIWC (currently LIWC-22), purchase the LIWC software at <https://www.liwc.app/>.


