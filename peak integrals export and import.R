library(ggpubr)
library(ggplot2)
library(tidyverse)
library(data.table)
library(writexl)
library(ff)
library(plyr)

# this part takes all the files from one location and copies them to another
names <- list.files('U:/NMR/Langwell/Peak Integrals/Each Spectrum Peaks')

names

# if there are files with the same name in the destination, this will overwrite them, if you don't want them overwritten, change overwrite to false

copy_function <-function(x){
  file.copy(from = file.path('U:/NMR/Langwell/Peak Integrals/Each Spectrum Peaks',x),
            to = file.path('C:/Users/Sam/Documents/R/PhD/NMR/Langwell/Peak Integrals',x),
            overwrite = TRUE)
}

lapply(names,copy_function)



#checks all files have been transferred

filenames <- list.files(path = 'C:/Users/Sam/Documents/R/PhD/NMR/Langwell/Peak Integrals')

filenames

#function for reading each csv into the dataframe

read_files <- function(filename){
  ret <- read.csv(filename)
  ret$Source <- filename
  ret
}

#set your working directory to the location of your csvs

getwd()
setwd("~/R/PhD/NMR/Langwell/Peak Integrals")

#ldply applies the function to the files to produce one dataframe 

import.list <-ldply(filenames, read_files)


import.list

#selects the relevant columns from the dataframe

import.list <- select(import.list, "Object", "Integral..abs.", "Source" )%>%
  separate(Source, c("Sample", "Depth"))
import.list$Depth <- as.numeric(import.list$Depth)
typeof(import.list$Depth)


import.list

#transforms dataframe so that each integral has it's own column

import.list <- spread(import.list, 
                    key = "Object",
                    value = "Integral..abs.")
import.list

#this produces the o-alkyl ratio calculation as a column

import.list$Ratio <- (import.list$`Integral 5`/import.list$`Integral 4`)
import.list
# integral 4 = o-alkyl C || integral 5 = aliphatic C

#produces a spreadsheet of the dataframe, you could also use write.csv

write_xlsx(import.list,'C:/Users/Sam/Documents/R/PhD/NMR/Langwell/O-ALKYL RATIOS.xlsx')
write_xlsx(import.list,"U:/NMR//Langwell/Peak Integrals/O-ALKYL RATIOS.xlsx")


