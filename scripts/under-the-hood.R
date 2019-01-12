library(gghighlight)

d <- tibble::tribble(
  ~x, ~y, ~type, ~value,
   3,  3,   "a",      9,
   8,  3,   "a",      9,
  13,  3,   "a",      9,
   2,  2,   "b",      9,
   7,  2,   "b",     10,
  12,  2,   "b",     10,
   1,  1,   "c",     10,
   6,  1,   "c",     11,
  11,  1,   "c",      9
)

do_plot <- function(filename, p) {
  p <- p  +
    scale_x_continuous(expand = expand_scale(mult = 0.2)) +
    scale_y_continuous(expand = expand_scale(mult = 0.2))
  
  plot(p)
  ggsave(filename, dpi = 1000, width = 3.5, height = 3.5)
}

do_plot(
  here::here("img/basic_point.png"),
  ggplot(d) +
    geom_point(aes(x, y, colour = type), size = 10) +
    theme_minimal()
)

do_plot(
  here::here("img/bleached_point.png"),
  ggplot(d) +
    geom_point(aes(x, y), size = 10, colour = "grey") +
    theme_minimal()
)

do_plot(
  here::here("img/sieved_point.png"),
  ggplot(d) +
    geom_point(data = function(d) dplyr::filter(d, type == "b"),
               aes(x, y, colour = type), size = 10) +
    theme_minimal()
)


do_plot(
  here::here("img/highlighted_point.png"),
  ggplot(d) +
    geom_point(aes(x, y), size = 10, colour = "grey") +
    geom_point(data = function(d) dplyr::filter(d, type == "b"),
               aes(x, y, colour = type), size = 10) +
    theme_minimal()
)

do_plot(
  here::here("img/ungrouped_line.png"),
  ggplot(d) +
    geom_line(aes(x, y, group = type), size = 3, colour = "grey") +
    geom_line(data = function(d) dplyr::filter(d, value >= 10),
              aes(x, y, colour = type), size = 3) +
    theme_minimal()
)

do_plot(
  here::here("img/grouped_line.png"),
  ggplot(d) +
    geom_line(aes(x, y, group = type), size = 3, colour = "grey") +
    geom_line(data = function(d) dplyr::filter(dplyr::group_by(d, type), max(value) >= 10),
              aes(x, y, colour = type), size = 3) +
    theme_minimal()
)
