library(readxl)
O_ALKYL_RATIOS <- read_excel("U:/NMR//Langwell/Peak Integrals/O-ALKYL RATIOS.xlsx")
View(O_ALKYL_RATIOS)

dat <- O_ALKYL_RATIOS

#produce depth category and location columns and produce columns normalised by the total integral

dat$Depth = as.numeric(dat$Depth)
dat$Category = substr(dat$Sample, 3, 4)
dat$Location = substr(dat$Sample, 1,2)
dat$Integral1 = dat$`Integral 1`
dat$Integral2 = dat$`Integral 2`/dat$`Integral 1`
dat$Integral3 = dat$`Integral 3`/dat$`Integral 1`
dat$Integral4 = dat$`Integral 4`/dat$`Integral 1`
dat$Integral5 = dat$`Integral 5`/dat$`Integral 1`


dat

#remove the un normalised integrals

dat1 <- select(dat, c("Sample", "Depth", "Integral2","Integral3", "Integral4", "Integral5", "Ratio"))
dat1

#this is just just a mish mash of producing scatter graphs and linear models of stuff, anything doesn't make sense lmk 

ggscatter(dat, "Depth", "Ratio",
          color = "Category", shape = "Location",
          size = 5,
          ylab = "Alkyl to O-Alkyl Ratio", xlab = dep_lab)


ggsave('alkyl ratio.png', path = "U:/NMR/Langwell")

ggscatter(dat, "Depth", "Integral4",
          color = "Category", shape = "Location" ,size = 5,
          ylab = "O-Alkyl Integral", xlab = dep_lab)
ggsave('o-alkyl integral.png', path = "U:/NMR/Langwell")
ggscatter(dat, "Depth", "Integral5",
          color = "Category", shape = "Location",size =5,
          ylab = "Alkyl Integral", xlab = dep_lab)
ggsave('alkyl integral.png', path = "U:/NMR/Langwell")

summary(lm(Ratio~Depth + Category+Category:Depth, data = dat))
summary(lm(Ratio~Depth + Category, data = dat))
summary(lm(Integral1~Depth + Category, data = dat))
summary(lm(Integral4~Depth + Category, data = dat))
summary(lm(Integral4~Depth + Category+Depth:Category, data = dat))
summary(lm(Integral5~Depth + Category, data = dat))
summary(lm(Integral5~Depth + Category+Depth:Category, data = dat))

dat1 = gather(dat, key = )

ggplot(dat, aes(x = Depth, y = In, fill = Cultivar)) +
  geom_col(position = "fill")

ggboxplot(dat, "Category", "Ratio",
          fill = "Location", order = cat_ord)

ggboxplot(dat, "Category", "Integral 2",
          fill = "Category", order = cat_ord)

ggboxplot(dat, "Category", "Integral 3",
          fill = "Category", order = cat_ord)

ggboxplot(dat, "Category", "Integral4",
          fill = "Category", order = cat_ord)

ggboxplot(dat, "Category", "Integral5",
          fill = "Category", order = cat_ord)

ggscatter(dat, "Depth", "Integral 1",
          color = "Category", size = 5)

ggscatter(dat, "Depth", "Integral 2",
          color = "Category", size = 5)
ggscatter(dat, "Depth", "Integral 3",
          color = "Category",shape = "Location", size = 5)

