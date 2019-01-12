library(gghighlight)

nc <- sf::st_read(system.file("shape/nc.shp", package = "sf"), quiet = TRUE)

ggplot(nc) +
  geom_histogram(aes(x = SID74/BIR74))

p <- ggplot(nc) +
  geom_sf(aes(fill = SID74/BIR74)) +
  gghighlight(SID74/BIR74 >= 0.0050) +
  geom_sf_label(aes(label = NAME), hjust = 0, vjust = 0)
p

ggsave(
  here::here("img/nc.png"),
  dpi = 600, width = 7, height = 7
)
