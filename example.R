# Read code from liwc2015.R
source("liwc2015.R")

# Note: Require LIWC dictionary file .dic to use the liwc2015()

# The example folder has 1 file
liwc2015("liwc.dic","example")
# [1] "Results saved as R-LIWC2015 Results JonBenetRamsey_note 2023-01-28 152805.csv" 

# The InauguralTexts subfolder has 2 files
liwc2015("liwc.dic","example/InauguralTexts")
# [1] "Results saved as R-LIWC2015 Results 01.Washington.1 - 02.Washington.2 (2 files) 2023-01-28 152935.csv"

# Empty folder
liwc2015("liwc.dic","example/empty")
# [1] "No .txt file found, please check the input folder: example/empty"

# Folder that does not exist
liwc2015("liwc.dic","folder0")
# [1] "No .txt file found, please check the input folder: folder0"
