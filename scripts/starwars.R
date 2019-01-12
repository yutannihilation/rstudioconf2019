library(gghighlight)

p <- ggplot(dplyr::starwars, aes(birth_year, mass, colour = species)) +
  geom_point() +
  geom_rug() +
  scale_x_log10() +
  scale_y_log10() +
  gghighlight(ifelse(is.na(birth_year), 0, birth_year),
              label_key = name,
              use_group_by = FALSE,
              max_highlight = 10)

p

ggsave(
  here::here("img/starwars.png"),
  dpi = 600, width = 7, height = 7
)
