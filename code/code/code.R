library(readxl)
library(dplyr)
library(ggplot2)

file_path <- '/Users/jacobpollard/Desktop/Uni/1.2/BABS-2 /Tutor/Week 6 figure for report/Week 6 figure Tonon et al./processed_data/Combined.xlsx'
locations <- c("Jamaica", "Dominican Republic", "Mexico, July 2020", "Mexico, January 2021")

process_data <- function(sheet_name) {
  df <- read_excel(file_path, sheet = sheet_name) %>%
    select(Amino_Acid = 1, Biomass = 2) %>% 
    group_by(Amino_Acid) %>%
    summarise(
      Mean = mean(Biomass, na.rm = TRUE),
      SE = sd(Biomass, na.rm = TRUE) / sqrt(n())
    ) %>%
    mutate(Location = sheet_name)
  
  return(df)
}

summary_data <- bind_rows(lapply(locations, process_data))

location_colors <- c(
  "Jamaica" = "#FCD116",
  "Dominican Republic" = "#005AA7",
  "Mexico, July 2020" = "#006747",
  "Mexico, January 2021" = "#D91026"
)

ggplot(summary_data, aes(x = Amino_Acid, y = Mean, fill = Location)) +
  geom_bar(stat = "identity", position = position_dodge(), color = "black") +
  geom_errorbar(aes(ymin = Mean - SE, ymax = Mean + SE), 
                position = position_dodge(width = 0.9), width = 0.2) +
  labs(
    title = expression(atop("Amino Acid Composition of Pelagic" ~ italic("Sargassum") ~ 
                              "Biomass Harvested at Different Locations in the Caribbean", "")),
    x = "Amino acid",
    y = "Mean % biomass",
    fill = "Location"
  ) +
  theme_minimal() +
  theme_light() +
  scale_fill_manual(values = location_colors) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(size = 10)
  )

