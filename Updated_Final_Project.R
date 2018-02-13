#Group 2: Leah O'Rourke, Amber Johnson, Jayro Perez

install.packages("tidyverse")
install.packages("shiny")
install.packages("patentsview")
install.packages("shinydashboard")
install.packages("DT")
install.packages("dplyr")
install.packages("tidyr")

library(tidyverse)
library(shiny)
library(patentsview)
library(shinydashboard)
library(DT)
library(dplyr)
library(tidyr)


#Objective 1 - summarize statistics
patent_id = search_pv(
  qry_funs$gte(patent_date = "2016-01-01"),
  qry_funs$lte(patent_date = "2016-03-31"),
  fields = "patent_id",
  endpoint = "patents",
  subent_cnts = TRUE,
  mtchd_subent_only = TRUE,
  page = 1,
  per_page = 25,
  all_pages = TRUE,
  sort = NULL,
  method = "GET"
)
patent_id

assignee_id = search_pv(
  qry_funs$gte(patent_date = "2016-01-01"),
  qry_funs$lte(patent_date = "2016-03-31"),
  fields = "assignee_id",
  endpoint = "assignees",
  subent_cnts = TRUE,
  mtchd_subent_only = TRUE,
  page = 1,
  per_page = 25,
  all_pages = TRUE,
  sort = NULL,
  method = "GET"
)

inventor_id = search_pv(
  qry_funs$gte(patent_date = "2016-01-01"),
  qry_funs$lte(patent_date = "2016-03-31"),
  fields = "inventor_id",
  endpoint = "inventors",
  subent_cnts = TRUE,
  mtchd_subent_only = TRUE,
  page = 1,
  per_page = 25,
  all_pages = TRUE,
  sort = NULL,
  method = "GET"
)

#These list the total number of unique patents, assignee, and inventors
total_assignee = assignee_id$query_results$total_assignee_count
total_patent =patent_id$query_results$total_patent_count
total_inventor = inventor_id$query_results$total_inventor_count

#test print statistics
cat("The number of patents is:",total_patent, "The number of assignees is:", total_assignee,
    "The number of inventors is:", total_inventor, sep ="\n")

#Objective 2  - create a table 
patent = search_pv(
  query = qry_funs$and(
    qry_funs$gte(patent_date = "2016-01-01"),
    qry_funs$lte(patent_date = "2016-03-31")),
  fields = c("patent_id", "patent_date", "inventor_last_name", "inventor_city", "assignee_organization",
             "assignee_lastknown_state" ),
  all_pages = TRUE
)

#run it to count the number of results 
patent

#print results
patent$data$patents

#unnest results
unnest_patent = patent$data$patents %>%
  unnest(inventors, .drop = FALSE) %>%
  unnest(assignees, .drop = FALSE)

#run unnest_patent
unnest_patent

#check the class of unnest_patent
class(unnest_patent)

#Used for Objectives 4&5
object_45 = unnest_patent[complete.cases(unnest_patent), ]

#Objective 3 - create a bar plot

topFive <- search_pv(
  qry_funs$gte(patent_date = "2016-01-01"),
  qry_funs$lte(patent_date = "2016-03-31"),
  fields = c("assignee_organization","assignee_total_num_patents"), 
  endpoint = "assignees",
  subent_cnts = TRUE,
  mtchd_subent_only = TRUE,
  page = 1,
  per_page = 25,
  all_pages = TRUE,
  sort = c("assignee_total_num_patents" = "desc"),
  method = "GET"
)

topFive
tabTop = topFive$data$assignees
tabTop

#List top 5 results
top = head(topFive$data$assignees, 5)
top

#Create the bar plot use the results from the top 5 
top_5_results = c(111916, 72139, 65779, 47267,46384)
names(top_5_results) = c("IBM", "Samsung", "Canon", "Sony","Toshiba")

#test the bar plot
color = c("blue", "orange", "green", "yellow", "red")
barplot(top_5_results, col = color)
#-----------------------------------------------------Menu Objectives ---------------------------------------------------------------------------------------------------------
#Menu Objective 2
invent_5 <- search_pv(
  qry_funs$gte(patent_date = "2016-01-01"),
  qry_funs$lte(patent_date = "2016-03-31"),
  fields = c("inventor_first_name","inventor_last_name", "inventor_total_num_patents" ), 
  endpoint = "inventors",
  subent_cnts = TRUE,
  mtchd_subent_only = TRUE,
  page = 1,
  per_page = 25,
  all_pages = FALSE,
  sort = c("inventor_total_num_patents" = "desc"),
  method = "GET"
)

invent_5
invent5 = invent_5$data$inventors
invent5


top_inventors = head(invent_5$data$inventors, 5)
top_inventors

#Menu Objective 3 - look at the fields and fix!
country_5 <- search_pv(
  qry_funs$gte(patent_date = "2016-01-01"),
  qry_funs$lte(patent_date = "2016-03-31"),
  fields = c("inventor_lastknown_country", "inventor_total_num_patents" ), 
  endpoint = "inventors",
  subent_cnts = TRUE,
  mtchd_subent_only = TRUE,
  page = 1,
  per_page = 25,
  all_pages = FALSE,
  sort = c("inventor_total_num_patents" = "desc"),
  method = "GET"
)

country_5
top_country = country_5$data$inventors
top_country


top_country_5 = head(country_5$data$inventors, 5)
top_country_5

#Menu Objective 4 - look at per page and also try to arrange in descending order! 

menu_query = qry_funs$and(
  qry_funs$gte(patent_date = "2016-01-01"),
  qry_funs$lte(patent_date = "2016-03-31"),
  qry_funs$gt(assignee_total_num_patents = 10)
)

menu_fields = c("assignee_organization", "assignee_total_num_patents")

w = search_pv(
  query = menu_query,
  fields = menu_fields,
  endpoint = "assignees",
  subent_cnts = TRUE,
  mtchd_subent_only = TRUE,
  page = 1,
  per_page = 10000,
  all_pages = TRUE,
  sort = c("assignee_total_num_patents" = "desc"),
  method = "GET"
)

w
class(w)
nrow(w)

w$data$assignees

w$data

assignee_organizations = w$data$assignees
assignee_organizations

#Menu Objective 5
citation_result = search_pv(
  query = qry_funs$and(
    qry_funs$gte(patent_date = "2016-01-01"),
    qry_funs$lte(patent_date = "2016-03-31"),
    qry_funs$gte(patent_num_us_patent_citations = 10)
  ),
  fields = c("patent_title","patent_num_us_patent_citations"),
  endpoint = "patents",
  all_pages= TRUE,
  sort = c("patent_num_us_patent_citations" = "desc")
)

result_query = citation_result$data$patents
result_query

#Menu Objective 6
Processing_Time = search_pv(
  qry_funs$gte(patent_date = "2016-01-01"),
  qry_funs$lte(patent_date = "2016-03-31"),
  fields = c("patent_processing_time"),
  endpoint = "patents",
  subent_cnts = TRUE,
  mtchd_subent_only = TRUE,
  page = 1,
  per_page = 25,
  all_pages = TRUE,
  sort = NULL,
  method = "GET")

Patent_Processing_Time = Processing_Time$data$patents$patent_processing_time


Patent_Time = as.numeric(Patent_Processing_Time)
average_time = mean(Patent_Time)

#-----------------------------------------------------Project UI ---------------------------------------------------------------------------------------------------------
project_ui = dashboardPage(
  dashboardHeader(title = "Final Project"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Core Objective 1", tabName = "Objective_1", icon = icon("list")),
      menuItem("Core Objective 2", tabName = "Objective_2", icon = icon("table")),
      menuItem("Core Objective 3", tabName = "Objective_3", icon = icon("bar-chart")),
      menuItem("Core objective 4", tabName = "Objective_4", icon=icon("mouse-pointer")),
      menuItem("Core Objective 5", tabName = "Objective_5", icon=icon("search")),
      menuItem("Menu Objective 2", tabName = "Menu_Objective_2", icon = icon("lightbulb-o")),
      menuItem("Menu Objective 4", tabName = "Menu_Objective_4", icon = icon("building")),
      menuItem("Menu Objective 6", tabName = "Menu_Objective_6", icon = icon("calendar")),
      menuItem("Extra Objectives", tabName = "Extra_Objectives", icon = icon("check")))),
  dashboardBody(
    tabItems(
      tabItem(tabName = "Objective_1",
              h2(strong("Objective 1")),
              h4("Show the following summary statistics:
                 the nubmer of patents, 
                 the number of unique assignees,
                 and the number of unique inventors"),
              mainPanel(
                fluidRow(
                  verbatimTextOutput("summary")))), 
      tabItem(tabName = "Objective_2",
              h2(strong("Objective 2")),
              h4("Represent patents in a data table with at least the following columns:
                 patent_number, patent_date, inventor_last_name, inventor_city,
                 assignee_organization, and assignee_lastknown_state"),
              mainPanel(
                h2("Patent Data Table"),
                dataTableOutput("Patent_Table"))), 
      tabItem(tabName = "Objective_3",
              h2(strong("Objective 3")),
              h4("Use a bar plot to show the top 5 assignee organizations 
                 in term of number of granted patents"),
              mainPanel(
                dataTableOutput("top5"),
                plotOutput("plot"))),
      tabItem(tabName = "Objective_4",
              h2(strong("Objective 4")),
              h4("Use a dropdown box to select the state of assignee organizations"),
              mainPanel(
                fluidRow(
                  selectInput("state","State:",
                              c("All",unique(as.character(unnest_patent$assignee_lastknown_state)))),
                  dataTableOutput("table")))),
      tabItem(tabName = "Objective_5",
              h2(strong("Objective 5")),
              h4("Use a text box to query inventor's last name"),
              mainPanel(
                fluidRow(
                  textInput("Last", "Inventor's last name contains"),
                  dataTableOutput("table1")))),
      tabItem(tabName = "Menu_Objective_6",
              h2(strong("Menu Objective 6")),
              h4("What is the average length between the date a patent application was filed
                 and the date the patent was granted?"),
              mainPanel(paste(average_time, "days"))),
      tabItem(tabName = "Menu_Objective_2",
              h2(strong("Menu Objective 2")),
              h4("Who are the five most prolific inventors?"),
              mainPanel(
                dataTableOutput("top5inv"))),
      tabItem(tabName = "Menu_Objective_4",
              h2(strong("Menu Objective 4")),
              h4("What assignee organizations have more than 10 patents?"), 
              mainPanel(
                dataTableOutput("Assignee10"))),
      tabItem(tabName = "Extra_Objectives",
              h2(strong("Extra Objectives")),
              h4("MO5: Which patents have been cited by more than 10 patents?"),
              mainPanel(dataTableOutput("Result_query")))
      )
      )
) 

#----------------------------------------------------Server---------------------------------------------------------------

test_server = function (input, output) {
  #Core Objective 1 Output
  output$summary = renderPrint({
    Object1 = cat("The number of patents is:",total_patent , "The number of assignees is:", total_assignee,
                  "The number of inventors is:", total_inventor, sep ="\n")
    return(Object1)
  })
  
  #Core Objective 2 Output
  output$Patent_Table = renderDataTable(
    return(unnest_patent))
  
  #Core Objective 3 Output
  output$top5 = renderDataTable(
    return(top))
  
  #Core Objective 3 Plot Output
  output$plot = renderPlot(
    barplot(top_5_results, col = color))
  
  #Core Objective 4 Output
  output$table = renderDataTable(datatable({
    data <- object_45
    if (input$state != "All") {
      data <- data[data$assignee_lastknown_state == input$state,]
    }
    data
  }))
  
  #core Objective 5 Output
  output$table1 <- renderDataTable(
    datatable({
      data2 <- object_45
      if (!is.null(input$Last) && input$Last != "") {
        data2 <- data2[data2$inventor_last_name == input$Last,]}
      data2
    }))
  
  #Menu Objective 2
  output$top5inv = renderDataTable(
    return(top_inventors))
  
  #Menu Objective 3
  #output$top5count = renderDataTable(
  # return(top_country_5))
  
  #Menu Objective 4
  output$Assignee10 = renderDataTable(
    return(assignee_organizations))
  
  #Menu Objective 5
  output$Result_query = renderDataTable({
    return(result_query)})
}

shinyApp(project_ui, test_server)

