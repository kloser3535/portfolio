# install and call plotly
#install.packages("plotly")
library(plotly)

# import dataset
nfl <- read.csv("C:/Users/klose/OneDrive/Documents/DSS 445/datasets/NFL Offensive Player stats, 1999-2013.csv")
nfl

# create custom order for conference variable
nfl$Conference <- factor(
  nfl$Conference,
  levels = c("ACC", "Big 12", "Big Ten", "Pac 12", "SEC", "Non-Power5", "Unknown")
)

# (1) basic scatterplot
ex1 <- plot_ly(
  data = nfl,
  x = ~TotYds,
  y = ~FantPt,
  type = "scatter",
  mode = "markers"
)
ex1

# (2) scatterplot with colors, custom title, and custom labels
ex2 <- plot_ly(
  data = nfl,
  x = ~TotYds,
  y = ~FantPt,
  color = ~Conference,
  type = "scatter",
  mode = "markers"
) %>%
  layout(
    title = "Total Yards vs. Fantasy Points for NFL Offensive Players (1999-2013)",
    margin = list(t = 50),
    xaxis = list(title = "Total Yards"),
    yaxis = list(title = "Fantasy Points")
  )
ex2

# (3) create a ggplot and turn it into an interactive plotly plot
library(ggplot2)
gg <- ggplot(nfl, aes(
  x = TotYds, 
  y = FantPt, 
  col = Conference,
  text = paste(
    "Player:", Player,
    "<br>Season:", Year,
    "<br>Total Yards:", TotYds,
    "<br>Fantasy Points:", FantPt,
    "<br>College:", College
  )
)) +
  geom_point() + 
  labs(x = "Total Yards", y = "Fantasy Points") +
  facet_wrap(~FantPos)

gg
ex3 <- ggplotly(gg, tooltip="text") %>%
  layout(
    title = list(text = "Total Yards vs. Fantasy Points for NFL Offensive Players (1999-2013)"),
    margin = list(t = 40)
  )
ex3

# (4) geographic map of total fantasy points for each state (using players' home states)
state_data <- aggregate(
  FantPt ~ Home.State,
  data = nfl,
  FUN = sum,
  na.rm = TRUE
)

ex4 <- plot_ly(
  data = state_data,
  type = "choropleth",
  locations = ~Home.State,
  locationmode = "USA-states",
  z = ~FantPt,
  colorscale = "YlOrRd",
  hovertemplate = paste(
    "State: %{location}<br>",
    "Total Fantasy Points: %{z:,.0f}",
    "<extra></extra>" # gets rid of trace box
  )
) %>%
  layout(
    title = "Total Fantasy Points by State (using Home States of NFL Offensive Players from 1999-2013)",
    margin = list(t = 50),
    geo = list(scope ="usa")
  )
ex4



###########################################################
# Graphs in PPT

# Boxpolt
ex8 <- plot_ly(
  data = nfl,
  x = ~FantPos,
  y = ~FantPt,
  type = "box"
) %>%
  layout(
    title = "Fantasy Points by Position",
    margin = list(t = 50),
    xaxis = list(title = "Fantasy Position"),
    yaxis = list(title = "Fantasy Points"),
    boxmode = "group"
  )

ex8

# Histogram
ex6 <- plot_ly(
  data = nfl,
  x = ~Age,
  type = "histogram",
  xbins = list(
    start = 20,
    end = 44,
    size = 2
  ),
  marker = list(
    color = "red",
    line = list(color = "white", width = 1)
  )
) %>%
  layout(
    title = "Distribution of Ages of NFL Offensive Players",
    margin = list(t = 50),
    xaxis = list(title = "Age"),
    margin = list(t = -50),
    yaxis = list(title = "Frequency", range=c(0, 2500))
  )

ex6

# 3D Plot
ex7 <- plot_ly(
  data = nfl,
  x = ~TotYds,
  y = ~TotTD,
  z = ~FantPt,
  type = "scatter3d",
  mode = "markers"
) %>%
  layout(
    title = "3D Plot of NFL Offensive Player Statistics",
    margin = list(t = 50),
    scene = list(
      xaxis = list(title = "Total Yards"),
      yaxis = list(title = "Total Touchdowns"),
      zaxis = list(title = "Fantasy Points")
    )
  )

ex7

