library(animint)
data(WorldBank, package = "animint")


## showSelected keyword in action
## ------------------------------
create_var <- function(df, x_var) {
  data.frame(df, x_var = factor(x_var, levels = c("life expectancy", "year")))
}

aligned <- ggplot() +
  geom_point(mapping = aes(y = fertility.rate, x = life.expectancy, color = region, showSelected = year),
             data = create_var(WorldBank, "life expectancy")) +
  geom_text(mapping = aes(y = fertility.rate, x = life.expectancy, color = region, label = year,
                          showSelected = year),
            data = create_var(WorldBank, "life expectancy")) +
  geom_line(mapping = aes(y = fertility.rate, x = year, color = region, group = country),
            data = create_var(WorldBank, "year")) +
  geom_vline(mapping = aes(xintercept = year, color = region, showSelected = year),
             data = create_var(WorldBank, "year")) +
  facet_grid(.~x_var, scales = "free") +
  theme_bw()

aligned_list <- list(aligned = aligned)
structure(aligned_list, class = "animint")

## TODO: Translate one of the animation package examples to an animint
## Relevant link: http://vis.supstat.com/categories.html#animation-ref
