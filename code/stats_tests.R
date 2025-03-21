library(ggplot2)
library(readxl)
library(dplyr)
library(FSA)

file_path <- '/Users/jacobpollard/Desktop/Uni/1.2/BABS-2 /Tutor/Week 6 figure for report/Week 6 figure Tonon et al./processed_data/Combined.xlsx'
sheets <- excel_sheets(file_path)

data_list <- list()

for (sheet in sheets) {
  df <- read_excel(file_path, sheet = sheet)
  df$Location <- sheet 
  data_list[[sheet]] <- df
}

data <- bind_rows(data_list)

ggplot(data, aes(x = `Amino Acid`, y = `% biomass dry weight`, fill = Location)) +
  geom_violin() +
  theme_minimal() +
  labs(title = "Violin Plot of Amino Acids by Location",
       x = "Amino Acid",
       y = "% Biomass Dry Weight") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

model <- lm(`% biomass dry weight` ~ `Amino Acid` + Location, data = data)

shapiro_test <- shapiro.test(residuals(model))

print
#p = 4.991x10^-7. Therefore, there is significant evidence to suggest that the data is not normal.

ggplot(mapping = aes(x = model$residuals)) + 
  geom_histogram(bins = 10)
#Looks normal but has positive skew. n = 3 so sensitive and unreliable.

#Non-parametric test (Kruskal Wallace)
kruskal_results <- kruskal.test(`% biomass dry weight` ~ Location, data = data)
print(kruskal_results)

#Post-hoc Dunn test performed
posthoc_results <- dunnTest(`% biomass dry weight` ~ Location, data = data, method = "bonferroni")
print(posthoc_results)
