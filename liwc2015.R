liwc2015 <- function(dictionary_file, data_folder){
  # Get the names of all .txt files with the directory path
  filenames <- list.files(path = data_folder, pattern = ".txt", full.names=TRUE)
  
  num_files <- length(filenames)
  if (num_files > 0) {
    # Load LIWC dictionary and ignore diagnostic messages
    liwc_dict <- suppressMessages(quanteda::dictionary(file=dictionary_file, format="LIWC"))
    
    # Generate LIWC2015 results
    results <- data.frame()
    for (input_file in filenames){
      # Read text data
      x <- readr::read_file(input_file)
      # Add whitespace after periods when there is no whitespace after them and the next character is a letter
      x <- gsub("\\.(?=[A-Za-z])", ". ", x, perl = TRUE)
      # Add whitespace after commas when there is no whitespace after them and the next character is a letter or digit
      x <- gsub("\\,(?=[A-Za-z0-9])", ", ", x, perl = TRUE)
      # Apply LIWCalike() to the pre-processed text that split on periods and commas like LIWC2015
      df <- quanteda.dictionaries::liwcalike(x, dictionary = liwc_dict, remove_punct = TRUE, remove_symbols = TRUE)
      
      # Show the filename of each text like LIWC2015
      df[["docname"]] <- basename(input_file)
      # Round the WPS (Words per Sentence) to two decimal places like LIWC2015
      df[["WPS"]] <- round(df[["WPS"]], 2)
      
      # Count words with numeric value as numbers like LIWC2015
      words <- quanteda::tokens(x, split_hyphens = TRUE, remove_punct = TRUE, remove_symbols = TRUE)[["text1"]]
      df[["number"]] <- round((ceiling(df[["number"]]/100*df[["WC"]])+sum(!is.na(suppressWarnings(as.numeric(gsub(",","",words))))))/df[["WC"]]*100, 2)
      
      # Append the analysis of each text to the results
      if (length(results) == 0) { results <- df } else { results <- rbind(results, df) }
    }
    
    # Construct the summary of the input files
    first_file <- tools::file_path_sans_ext(basename(filenames[1]))
    if (num_files < 2) { file_summary <- first_file } 
    else { 
      last_file <- tools::file_path_sans_ext(basename(filenames[num_files]))
      file_summary <- paste0(first_file," - ",last_file," (",num_files," files)")
    }
    
    # Save results as CSV with timestamp
    output_file <- paste0("R-LIWC2015 Results ", file_summary, format(Sys.time()," %Y-%m-%d %H%M%S"), ".csv")
    readr::write_csv(results, output_file)
    print(paste("Results saved as", output_file))
    
  } else { print(paste("No .txt file found, please check the input folder:", data_folder)) }
}
