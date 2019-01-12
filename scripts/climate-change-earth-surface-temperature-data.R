library(readr)
library(dplyr, warn.conflicts = FALSE)
library(ggplot2)

# data: https://www.kaggle.com/berkeleyearth/climate-change-earth-surface-temperature-data
d <- read_csv("data/GlobalLandTemperaturesByCity.csv")

d %>%
  group_by(City) %>% 
  summarise(sum(is.na(AverageTemperature)))

# recent 75 years
d <- d %>%
  tidyr::drop_na() %>%
  filter(dt > lubridate::ymd("1913-01-01"))

d_summurised <- d %>%
  group_by(City, year = lubridate::ceiling_date(dt, "year")) %>%
  summarise(temp = mean(AverageTemperature),
            uncertainty = mean(AverageTemperatureUncertainty)) %>%
  ungroup()

ggplot(d) +
  geom_tile(aes(x = dt, y = City))

library(gghighlight)

p <- ggplot(d_summurised) +
  geom_line(aes(x = year, y = temp, colour = City)) +
  gghighlight(diff(range(temp))) +
  geom_ribbon(aes(x = year, ymax = temp + uncertainty, ymin = temp - uncertainty, fill = City), alpha = 0.2)

ggsave(
  here::here("img/climate-change-earth-surface-temperature-data.png"),
  p,
  dpi = 600, width = 7, height = 7
)
