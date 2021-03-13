---
title: 'Weekly Exercises #6'
author: "Brian Lee"
output: 
  html_document:
    keep_md: TRUE
    toc: TRUE
    toc_float: TRUE
    df_print: paged
    code_download: true
---





```r
library(tidyverse)     # for data cleaning and plotting
library(gardenR)       # for Lisa's garden data
library(lubridate)     # for date manipulation
library(openintro)     # for the abbr2state() function
library(palmerpenguins)# for Palmer penguin data
library(maps)          # for map data
library(ggmap)         # for mapping points on maps
library(gplots)        # for col2hex() function
library(RColorBrewer)  # for color palettes
library(sf)            # for working with spatial data
library(leaflet)       # for highly customizable mapping
library(ggthemes)      # for more themes (including theme_map())
library(plotly)        # for the ggplotly() - basic interactivity
library(gganimate)     # for adding animation layers to ggplots
library(gifski)        # for creating the gif (don't need to load this library every time,but need it installed)
library(transformr)    # for "tweening" (gganimate)
library(shiny)         # for creating interactive apps
library(patchwork)     # for nicely combining ggplot2 graphs  
library(gt)            # for creating nice tables
library(rvest)         # for scraping data
library(robotstxt)     # for checking if you can scrape data
theme_set(theme_minimal())
```


```r
# Lisa's garden data
data("garden_harvest")

#COVID-19 data from the New York Times
covid19 <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")
```

## Put your homework on GitHub!

Go [here](https://github.com/llendway/github_for_collaboration/blob/master/github_for_collaboration.md) or to previous homework to remind yourself how to get set up. 

Once your repository is created, you should always open your **project** rather than just opening an .Rmd file. You can do that by either clicking on the .Rproj file in your repository folder on your computer. Or, by going to the upper right hand corner in R Studio and clicking the arrow next to where it says Project: (None). You should see your project come up in that list if you've used it recently. You could also go to File --> Open Project and navigate to your .Rproj file. 

## Instructions

* Put your name at the top of the document. 

* **For ALL graphs, you should include appropriate labels.** 

* Feel free to change the default theme, which I currently have set to `theme_minimal()`. 

* Use good coding practice. Read the short sections on good code with [pipes](https://style.tidyverse.org/pipes.html) and [ggplot2](https://style.tidyverse.org/ggplot2.html). **This is part of your grade!**

* **NEW!!** With animated graphs, add `eval=FALSE` to the code chunk that creates the animation and saves it using `anim_save()`. Add another code chunk to reread the gif back into the file. See the [tutorial](https://animation-and-interactivity-in-r.netlify.app/) for help. 

* When you are finished with ALL the exercises, uncomment the options at the top so your document looks nicer. Don't do it before then, or else you might miss some important warnings and messages.

## Your first `shiny` app 

  1. This app will also use the COVID data. Make sure you load that data and all the libraries you need in the `app.R` file you create. Below, you will post a link to the app that you publish on shinyapps.io. You will create an app to compare states' cumulative number of COVID cases over time. The x-axis will be number of days since 20+ cases and the y-axis will be cumulative cases on the log scale (`scale_y_log10()`). We use number of days since 20+ cases on the x-axis so we can make better comparisons of the curve trajectories. You will have an input box where the user can choose which states to compare (`selectInput()`) and have a submit button to click once the user has chosen all states they're interested in comparing. The graph should display a different line for each state, with labels either on the graph or in a legend. Color can be used if needed. 
  
[Covid19 App](https://briandlee.shinyapps.io/covid19_app/)
  
## Warm-up exercises from tutorial

  2. Read in the fake garden harvest data. Find the data [here](https://github.com/llendway/scraping_etc/blob/main/2020_harvest.csv) and click on the `Raw` button to get a direct link to the data. 
  

```r
fake_garden_harvest <- read_csv("https://raw.githubusercontent.com/llendway/scraping_etc/main/2020_harvest.csv")
```

  
  3. Read in this [data](https://www.kaggle.com/heeraldedhia/groceries-dataset) from the kaggle website. You will need to download the data first. Save it to your project/repo folder. Do some quick checks of the data to assure it has been read in appropriately.


```r
groceries <- read_csv("Groceries_dataset.csv")
```


  4. CHALLENGE(not graded): Write code to replicate the table shown below (open the .html file to see it) created from the `garden_harvest` data as best as you can. When you get to coloring the cells, I used the following line of code for the `colors` argument:


  5. Create a table using `gt` with data from your project or from the `garden_harvest` data if your project data aren't ready.
  

```r
g2 <- garden_harvest %>%
  filter(vegetable %in% c("lettuce", "spinach", "peas")) %>%
  group_by(vegetable, date) %>%
  summarize(daily_harvest_lb = sum(weight)*0.00220462) %>%
  mutate(cum_harvest_lb = cumsum(daily_harvest_lb)) %>%
  gt(
    groupname_col = "date"
  ) %>%
  tab_header(
    title = "Daily harvest of Lettuce, peas, and spinach",
    subtitle = md("Cumulative weights harvested of leafy greens")
  ) %>%
  cols_label(
    vegetable = "Vegetable",
    daily_harvest_lb = "Daily Harvest (lb)",
    cum_harvest_lb= "Cumulative Harvest (lb)"
  ) %>%
  data_color(columns = vars(cum_harvest_lb),
             colors =  scales::col_numeric(palette = "magma",
                                           domain = NULL)) %>%
  tab_options(column_labels.background.color = "navy")

g2
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#xzlqgnrhxz .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#xzlqgnrhxz .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#xzlqgnrhxz .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#xzlqgnrhxz .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#xzlqgnrhxz .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xzlqgnrhxz .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#xzlqgnrhxz .gt_col_heading {
  color: #FFFFFF;
  background-color: navy;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#xzlqgnrhxz .gt_column_spanner_outer {
  color: #FFFFFF;
  background-color: navy;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#xzlqgnrhxz .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#xzlqgnrhxz .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#xzlqgnrhxz .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#xzlqgnrhxz .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#xzlqgnrhxz .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#xzlqgnrhxz .gt_from_md > :first-child {
  margin-top: 0;
}

#xzlqgnrhxz .gt_from_md > :last-child {
  margin-bottom: 0;
}

#xzlqgnrhxz .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#xzlqgnrhxz .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#xzlqgnrhxz .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#xzlqgnrhxz .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#xzlqgnrhxz .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#xzlqgnrhxz .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#xzlqgnrhxz .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#xzlqgnrhxz .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xzlqgnrhxz .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#xzlqgnrhxz .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#xzlqgnrhxz .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#xzlqgnrhxz .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#xzlqgnrhxz .gt_left {
  text-align: left;
}

#xzlqgnrhxz .gt_center {
  text-align: center;
}

#xzlqgnrhxz .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#xzlqgnrhxz .gt_font_normal {
  font-weight: normal;
}

#xzlqgnrhxz .gt_font_bold {
  font-weight: bold;
}

#xzlqgnrhxz .gt_font_italic {
  font-style: italic;
}

#xzlqgnrhxz .gt_super {
  font-size: 65%;
}

#xzlqgnrhxz .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="xzlqgnrhxz" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="3" class="gt_heading gt_title gt_font_normal" style>Daily harvest of Lettuce, peas, and spinach</th>
    </tr>
    <tr>
      <th colspan="3" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style>Cumulative weights harvested of leafy greens</th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">Vegetable</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">Daily Harvest (lb)</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">Cumulative Harvest (lb)</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-06-06</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.04409240</td>
      <td class="gt_row gt_right" style="background-color: #000004; color: #FFFFFF;">0.04409240</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-06-08</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.03306930</td>
      <td class="gt_row gt_right" style="background-color: #010005; color: #FFFFFF;">0.07716170</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-06-09</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.02204620</td>
      <td class="gt_row gt_right" style="background-color: #010005; color: #FFFFFF;">0.09920790</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-06-11</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.02645544</td>
      <td class="gt_row gt_right" style="background-color: #010106; color: #FFFFFF;">0.12566334</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.01984158</td>
      <td class="gt_row gt_right" style="background-color: #000004; color: #FFFFFF;">0.01984158</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-06-13</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.04188778</td>
      <td class="gt_row gt_right" style="background-color: #010106; color: #FFFFFF;">0.16755112</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.03086468</td>
      <td class="gt_row gt_right" style="background-color: #000004; color: #FFFFFF;">0.05070626</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-06-17</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.10582176</td>
      <td class="gt_row gt_right" style="background-color: #020109; color: #FFFFFF;">0.27337288</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">peas</td>
      <td class="gt_row gt_right">0.28439598</td>
      <td class="gt_row gt_right" style="background-color: #020109; color: #FFFFFF;">0.28439598</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.12786796</td>
      <td class="gt_row gt_right" style="background-color: #010107; color: #FFFFFF;">0.17857422</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-06-18</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.10361714</td>
      <td class="gt_row gt_right" style="background-color: #02020C; color: #FFFFFF;">0.37699002</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.13007258</td>
      <td class="gt_row gt_right" style="background-color: #02010A; color: #FFFFFF;">0.30864680</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-06-19</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.16975574</td>
      <td class="gt_row gt_right" style="background-color: #030312; color: #FFFFFF;">0.54674576</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.12786796</td>
      <td class="gt_row gt_right" style="background-color: #02020E; color: #FFFFFF;">0.43651476</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-06-20</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.08818480</td>
      <td class="gt_row gt_right" style="background-color: #040414; color: #FFFFFF;">0.63493056</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">peas</td>
      <td class="gt_row gt_right">0.48281178</td>
      <td class="gt_row gt_right" style="background-color: #060518; color: #FFFFFF;">0.76720776</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.05511550</td>
      <td class="gt_row gt_right" style="background-color: #03030F; color: #FFFFFF;">0.49163026</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-06-21</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.20943890</td>
      <td class="gt_row gt_right" style="background-color: #06051B; color: #FFFFFF;">0.84436946</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.26896364</td>
      <td class="gt_row gt_right" style="background-color: #060518; color: #FFFFFF;">0.76059390</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-06-22</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.15432340</td>
      <td class="gt_row gt_right" style="background-color: #09071F; color: #FFFFFF;">0.99869286</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">peas</td>
      <td class="gt_row gt_right">0.13007258</td>
      <td class="gt_row gt_right" style="background-color: #07061C; color: #FFFFFF;">0.89728034</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.08157094</td>
      <td class="gt_row gt_right" style="background-color: #06051B; color: #FFFFFF;">0.84216484</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-06-24</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.26896364</td>
      <td class="gt_row gt_right" style="background-color: #0D0A28; color: #FFFFFF;">1.26765650</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">peas</td>
      <td class="gt_row gt_right">0.07495708</td>
      <td class="gt_row gt_right" style="background-color: #100B2D; color: #FFFFFF;">1.42418452</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-06-25</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.06613860</td>
      <td class="gt_row gt_right" style="background-color: #0E0B2A; color: #FFFFFF;">1.33379510</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.04850164</td>
      <td class="gt_row gt_right" style="background-color: #08071F; color: #FFFFFF;">0.98105590</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-06-27</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.31085142</td>
      <td class="gt_row gt_right" style="background-color: #130D35; color: #FFFFFF;">1.64464652</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">peas</td>
      <td class="gt_row gt_right">0.73413846</td>
      <td class="gt_row gt_right" style="background-color: #331067; color: #FFFFFF;">3.09528648</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.13227720</td>
      <td class="gt_row gt_right" style="background-color: #0A0823; color: #FFFFFF;">1.11333310</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-06-28</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.24471282</td>
      <td class="gt_row gt_right" style="background-color: #180F3D; color: #FFFFFF;">1.88935934</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">peas</td>
      <td class="gt_row gt_right">1.74826366</td>
      <td class="gt_row gt_right" style="background-color: #5E177F; color: #FFFFFF;">4.84355014</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.21825738</td>
      <td class="gt_row gt_right" style="background-color: #0E0B2A; color: #FFFFFF;">1.33159048</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-06-29</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.35935306</td>
      <td class="gt_row gt_right" style="background-color: #1F114A; color: #FFFFFF;">2.24871240</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">peas</td>
      <td class="gt_row gt_right">2.61467932</td>
      <td class="gt_row gt_right" style="background-color: #9C2E7F; color: #FFFFFF;">7.45822946</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-01</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.13227720</td>
      <td class="gt_row gt_right" style="background-color: #21114F; color: #FFFFFF;">2.38098960</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-02</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.31746528</td>
      <td class="gt_row gt_right" style="background-color: #29115A; color: #FFFFFF;">2.69845488</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">peas</td>
      <td class="gt_row gt_right">3.39731942</td>
      <td class="gt_row gt_right" style="background-color: #E95562; color: #000000;">10.85554888</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.03527392</td>
      <td class="gt_row gt_right" style="background-color: #120D31; color: #FFFFFF;">1.54323400</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-03</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.95460046</td>
      <td class="gt_row gt_right" style="background-color: #410F74; color: #FFFFFF;">3.65305534</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-04</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.32407914</td>
      <td class="gt_row gt_right" style="background-color: #491078; color: #FFFFFF;">3.97713448</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">peas</td>
      <td class="gt_row gt_right">1.63582804</td>
      <td class="gt_row gt_right" style="background-color: #FA7F5E; color: #000000;">12.49137692</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-06</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.41667318</td>
      <td class="gt_row gt_right" style="background-color: #53137D; color: #FFFFFF;">4.39380766</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">peas</td>
      <td class="gt_row gt_right">1.06042222</td>
      <td class="gt_row gt_right" style="background-color: #FE9D6C; color: #000000;">13.55179914</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-07</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.17636960</td>
      <td class="gt_row gt_right" style="background-color: #57157E; color: #FFFFFF;">4.57017726</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-08</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.25132668</td>
      <td class="gt_row gt_right" style="background-color: #5D177F; color: #FFFFFF;">4.82150394</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">peas</td>
      <td class="gt_row gt_right">0.72091074</td>
      <td class="gt_row gt_right" style="background-color: #FEB179; color: #000000;">14.27270988</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-09</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.13448182</td>
      <td class="gt_row gt_right" style="background-color: #601880; color: #FFFFFF;">4.95598576</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-11</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.17416498</td>
      <td class="gt_row gt_right" style="background-color: #651A80; color: #FFFFFF;">5.13015074</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.04188778</td>
      <td class="gt_row gt_right" style="background-color: #120D32; color: #FFFFFF;">1.58512178</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-12</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.18298346</td>
      <td class="gt_row gt_right" style="background-color: #691C81; color: #FFFFFF;">5.31313420</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-13</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.41887780</td>
      <td class="gt_row gt_right" style="background-color: #732081; color: #FFFFFF;">5.73201200</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">peas</td>
      <td class="gt_row gt_right">0.08818480</td>
      <td class="gt_row gt_right" style="background-color: #FEB47B; color: #000000;">14.36089468</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-16</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.13448182</td>
      <td class="gt_row gt_right" style="background-color: #762181; color: #FFFFFF;">5.86649382</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-20</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.27116826</td>
      <td class="gt_row gt_right" style="background-color: #7C2382; color: #FFFFFF;">6.13766208</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">peas</td>
      <td class="gt_row gt_right">0.74075232</td>
      <td class="gt_row gt_right" style="background-color: #FCFDBF; color: #000000;">17.02628026</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-22</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.05070626</td>
      <td class="gt_row gt_right" style="background-color: #7D2382; color: #FFFFFF;">6.18836834</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-23</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.28660060</td>
      <td class="gt_row gt_right" style="background-color: #842681; color: #FFFFFF;">6.47496894</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-24</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.03527392</td>
      <td class="gt_row gt_right" style="background-color: #852681; color: #FFFFFF;">6.51024286</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-26</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.17857422</td>
      <td class="gt_row gt_right" style="background-color: #892881; color: #FFFFFF;">6.68881708</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-27</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.21825738</td>
      <td class="gt_row gt_right" style="background-color: #8F2A81; color: #FFFFFF;">6.90707446</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-28</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.20062042</td>
      <td class="gt_row gt_right" style="background-color: #932B80; color: #FFFFFF;">7.10769488</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-29</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.16093726</td>
      <td class="gt_row gt_right" style="background-color: #972D80; color: #FFFFFF;">7.26863214</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-30</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.20723428</td>
      <td class="gt_row gt_right" style="background-color: #9C2E7F; color: #FFFFFF;">7.47586642</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-31</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.23589434</td>
      <td class="gt_row gt_right" style="background-color: #A2307E; color: #FFFFFF;">7.71176076</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.06834322</td>
      <td class="gt_row gt_right" style="background-color: #150F39; color: #FFFFFF;">1.78574220</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-08-03</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.14330030</td>
      <td class="gt_row gt_right" style="background-color: #A5317E; color: #FFFFFF;">7.85506106</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-08-04</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.12345872</td>
      <td class="gt_row gt_right" style="background-color: #A9327D; color: #FFFFFF;">7.97851978</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.09700328</td>
      <td class="gt_row gt_right" style="background-color: #180F3D; color: #FFFFFF;">1.88274548</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-08-06</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.21605276</td>
      <td class="gt_row gt_right" style="background-color: #AE347B; color: #FFFFFF;">8.19457254</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-08-07</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.04188778</td>
      <td class="gt_row gt_right" style="background-color: #AE347B; color: #FFFFFF;">8.23646032</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-08-11</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.20282504</td>
      <td class="gt_row gt_right" style="background-color: #B3367A; color: #FFFFFF;">8.43928536</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-08-12</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.16093726</td>
      <td class="gt_row gt_right" style="background-color: #B83779; color: #FFFFFF;">8.60022262</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-08-14</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.17636960</td>
      <td class="gt_row gt_right" style="background-color: #BC3978; color: #FFFFFF;">8.77659222</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-08-15</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.12345872</td>
      <td class="gt_row gt_right" style="background-color: #BF3A77; color: #FFFFFF;">8.90005094</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-08-16</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.09920790</td>
      <td class="gt_row gt_right" style="background-color: #C13B75; color: #FFFFFF;">8.99925884</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-08-17</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.14770954</td>
      <td class="gt_row gt_right" style="background-color: #C53C74; color: #FFFFFF;">9.14696838</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.06613860</td>
      <td class="gt_row gt_right" style="background-color: #19103F; color: #FFFFFF;">1.94888408</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-08-18</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.19180194</td>
      <td class="gt_row gt_right" style="background-color: #C93E72; color: #FFFFFF;">9.33877032</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.08598018</td>
      <td class="gt_row gt_right" style="background-color: #1A1042; color: #FFFFFF;">2.03486426</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-08-20</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.92814502</td>
      <td class="gt_row gt_right" style="background-color: #DF4A68; color: #FFFFFF;">10.26691534</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-08-23</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.24471282</td>
      <td class="gt_row gt_right" style="background-color: #E34E65; color: #000000;">10.51162816</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-08-24</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.29541908</td>
      <td class="gt_row gt_right" style="background-color: #E95462; color: #000000;">10.80704724</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-08-27</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.03086468</td>
      <td class="gt_row gt_right" style="background-color: #E95462; color: #000000;">10.83791192</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-08-28</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.18739270</td>
      <td class="gt_row gt_right" style="background-color: #EC5860; color: #000000;">11.02530462</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-09-16</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.01763696</td>
      <td class="gt_row gt_right" style="background-color: #EC5960; color: #000000;">11.04294158</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-09-26</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.20943890</td>
      <td class="gt_row gt_right" style="background-color: #EF5E5E; color: #000000;">11.25238048</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-09-27</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.30644218</td>
      <td class="gt_row gt_right" style="background-color: #F3655C; color: #000000;">11.55882266</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-10-07</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">lettuce</td>
      <td class="gt_row gt_right">0.03747854</td>
      <td class="gt_row gt_right" style="background-color: #F4665C; color: #000000;">11.59630120</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-06-23</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">peas</td>
      <td class="gt_row gt_right">0.45194710</td>
      <td class="gt_row gt_right" style="background-color: #0E0B2B; color: #FFFFFF;">1.34922744</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.09038942</td>
      <td class="gt_row gt_right" style="background-color: #08071D; color: #FFFFFF;">0.93255426</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-06-26</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">peas</td>
      <td class="gt_row gt_right">0.93696350</td>
      <td class="gt_row gt_right" style="background-color: #21114E; color: #FFFFFF;">2.36114802</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-14</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">peas</td>
      <td class="gt_row gt_right">1.61598646</td>
      <td class="gt_row gt_right" style="background-color: #FDE1A2; color: #000000;">15.97688114</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-19</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">peas</td>
      <td class="gt_row gt_right">0.30864680</td>
      <td class="gt_row gt_right" style="background-color: #FDE9AA; color: #000000;">16.28552794</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-06-30</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.17636960</td>
      <td class="gt_row gt_right" style="background-color: #110C30; color: #FFFFFF;">1.50796008</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-15</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.08598018</td>
      <td class="gt_row gt_right" style="background-color: #140E36; color: #FFFFFF;">1.67110196</td>
    </tr>
    <tr class="gt_group_heading_row">
      <td colspan="3" class="gt_group_heading">2020-07-21</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">spinach</td>
      <td class="gt_row gt_right">0.04629702</td>
      <td class="gt_row gt_right" style="background-color: #140E37; color: #FFFFFF;">1.71739898</td>
    </tr>
  </tbody>
  
  
</table></div><!--/html_preserve-->

  
  6. Use `patchwork` operators and functions to combine at least two graphs using your project data or `garden_harvest` data if your project data aren't read.


```r
graph1 <- garden_harvest %>%
  filter(vegetable == "tomatoes") %>%
  mutate(tomatoes_title = str_to_title(variety)) %>%
  mutate(weightlbs = weight * .00220462) %>% #creating a new variable that converts the weight to pounds
  mutate(tomatoes2 = fct_reorder(tomatoes_title, weightlbs, .desc = FALSE)) %>% #reordering tomatoes in increasing median weight
  ggplot(aes(x = weightlbs, y = tomatoes2)) + 
  geom_boxplot() + # Specifying that I want to build boxplots
  theme_classic() + # Choosing a theme
  theme(plot.title.position = "plot",
        plot.caption = element_text(size = 10, face = "italic")) +
  labs(title = "Tomato Harvest Weight Distributions (lbs)",
       caption = "Visualization Created by Brian Lee",
       x = "", y = "") +
  geom_vline(aes(xintercept = median(weightlbs, na.rm = TRUE)), color = "royalblue") # Adding a vertical line indicating the median weight for all tomatoes

graph2 <- garden_harvest %>%
  mutate(weightlb = weight * .00220462) %>%
    filter(vegetable == "beets",
           variety %in% c("Sweet Merlin", "Gourmet Golden")) %>%
  group_by(variety, date) %>%
  summarize(daily_weight = sum(weightlb)) %>%
  mutate(cumWeight = cumsum(daily_weight)) %>%
  ggplot(aes(x = date, y = cumWeight, color = variety)) +
  geom_line() +
  labs(title = "The Cumulative Weight (lb) of Gourmet Golden & Sweet Merlin beets", x = "", y = "")

graph1|graph2
```

![](06_exercises_files/figure-html/unnamed-chunk-4-1.png)<!-- -->


**DID YOU REMEMBER TO UNCOMMENT THE OPTIONS AT THE TOP?**
