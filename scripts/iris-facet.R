library(gghighlight)

p <- ggplot(iris) +
  geom_histogram(aes(Sepal.Length, fill = Species)) +
  gghighlight() +
  facet_wrap(vars(Species))

ggsave(
  here::here("img/iris-facet.png"),
  p,
  dpi = 600, width = 7, height = 7
)
