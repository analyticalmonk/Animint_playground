data(WorldBank, package="animint")
library(animint)

## Scatter plot based on showSelected and clickSelects keywords
## ------------------------------------------------------------
scatter <- ggplot()+
  geom_point(aes(x=life.expectancy, y=fertility.rate, color=region,
                 key=country,
                 # Only data for the currently selected year plotted
                 showSelected=year,
                 clickSelects=country),
             data=WorldBank)

viz.scatter <- list(
  scatter=scatter,
  duration=list(year=2000))

viz.text <- viz.scatter
viz.text$scatter <- scatter+
  geom_text(aes(x=life.expectancy, y=fertility.rate, label=country,
                # To make the text disappear when the point does on a region being clicked on the legend,
                # we tie text to region variable through the color parameter.
                color = region,
                key=country,
                showSelected=year,
                showSelected2=country),
            data=WorldBank)

structure(viz.text, class="animint")

## Using the 'first' option

viz.text$first <- list(
  year = 1970,
  country = "India",
  region = c("North America", "South Asia"))

structure(viz.text, class = "animint")