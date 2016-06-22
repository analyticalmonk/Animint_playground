library(animint)
data(WorldBank, package = "animint")
# str(WorldBank)

WorldBank1975 <- WorldBank[WorldBank$year == 1975, ]
WorldBankTill1975 <- WorldBank[WorldBank$year >= 1970 & WorldBank$year <= 1975, ]

scatter <- ggplot() +
  geom_point(mapping = aes(y = fertility.rate, x = life.expectancy, color = region),
             data = WorldBank1975) +
  geom_path(mapping = aes(y = fertility.rate, x = life.expectancy, color = region, group = country),
            data = WorldBankTill1975)

series1 <- ggplot() +
  geom_path(mapping = aes(y = fertility.rate, x = year, color = region, group = country),
            data = WorldBankTill1975)

series2 <- ggplot() +
  geom_path(mapping = aes(y = population, x = year, color = region, group = country),
            data = WorldBankTill1975)

tres_plot_list <- list(scatter = scatter, series1 = series1, series2 = series2)
structure(tres_plot_list, class = "animint")


## FACETS
add_var <- function(df, x_var, y_var) {
  data.frame(df, x_var = factor(x_var, c("life expectancy", "fertility rate", "year")),
             y_var = factor(y_var, c("life_expectancy", "fertility rate")) )
}

aligned <- ggplot()+
  geom_point(mapping = aes(y = fertility.rate, x = life.expectancy, color = region),
             data = add_var(WorldBank1975, "fertility rate", "fertility rate")) +
  geom_path(mapping = aes(y = fertility.rate, x = life.expectancy, color = region, group = country),
            data = add_var(WorldBankTill1975, "fertility rate", "fertility rate")) +
  geom_line(mapping = aes(y = fertility.rate, x = year, color = region, group = country),
            data = add_var(WorldBank, "year", "fertility rate")) +
  geom_point(mapping = aes(x = fertility.rate, y = life.expectancy, color = region),
             data = add_var(WorldBank1975, "life expectancy", "life expectancy")) +
  geom_path(mapping = aes(x = fertility.rate, y = life.expectancy, color = region, group = country),
            data = add_var(WorldBankTill1975, "life expectancy", "life expectancy")) +
  geom_line(mapping = aes(y = life.expectancy, x = year, color = region, group = country),
            data = add_var(WorldBank, "year", "life expectancy")) +
  facet_grid(y_var ~ x_var, scales = "free") +
  theme_bw()
  #theme(panel.margin = grid::unit(0, "lines"))

viz.aligned <- list(aligned = aligned)

structure(viz.aligned, class = "animint")
  
  
  
  