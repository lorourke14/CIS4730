#install.packages("shinydashboard")
library("shinydashboard")
library(shiny)
library(patentsview)

result001 <- search_pv(
  qry_funs$gte(patent_date = "2016-01-01"),
  qry_funs$lte(patent_date = "2016-03-31"),
  fields = c("nber_total_num_patents", "nber_total_num_assignees", "nber_total_num_inventors"), 
  endpoint = "nber_subcategories",
  subent_cnts = TRUE,
  mtchd_subent_only = TRUE,
  page = 1,
  per_page = 25,
  all_pages = TRUE,
  sort = NULL,
  method = "GET"
)

result001
result001$data$nber_subcategories[1, 1]

Num_Patents = result001$data$nber_subcategories$nber_total_num_patents[1]
Num_Assignee = result001$data$nber_subcategories$nber_total_num_assignees[1]
Num_Inventor = result001$data$nber_subcategories$nber_total_num_inventors[1]

Num_Patents
Num_Assignee
Num_Inventor


mydates <- as.Date(c("2016-01-01", "2016-03-31"))
# number of days between 6/22/07 and 2/13/04 
days <- mydates[1]
days

project_ui = dashboardPage(
  dashboardHeader(title = "Final Project"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Objective 1", tabName = "Objective_1", icon = icon("list")),
      menuItem("Objective 2", tabName = "Objective_2", icon = icon("table")),
      menuItem("Objective 3", tabName = "Objective_3", icon = icon("bar-chart"))
    )),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "Objective_1",
              h2("Objective 1"),
              fluidRow(
                box(
                  width = 14, background = "black",
                  "Show the following summary statistics:
                  the nubmer of patents, 
                  the number of unique assignees,
                  and the number of unique inventors"
                ) #box
              ),#Fluid row
              sidebarLayout(
                sidebarPanel(
                  selectInput("dataset", "Choose a Dataset:", 
                              choices = c("Number of Patents", 
                                          "Number of Unique Assignees", 
                                          "Number of Unique Inventors")), 
                  #dateRangeInput('dateRange',
                                # label = 'Date range input: yyyy-mm-dd',
                                # start = Sys.Date(), end = Sys.Date()
                                #start = date(2016-01-01), end = date(2016-03-31)
                  #),
                  helpText("Note:while the data view will show only the specified", 
                           "number of observations, the summary will stil be based", 
                           "on the full dataset."),
                  actionButton("goButton", "Go!")
           
                ),
                mainPanel(
                  h2("Summary"),
                  verbatimTextOutput("summary")
                  
                )
              )
              ), #tab item 1
      tabItem(tabName = "Objective_2",
              h2("Objective 4&5"),
              fluidRow(
                box(
                  width = 14, background = "black",
                  "Represent patents in a data table with at least the following columns:
                  patent_number, patent_date, inventor_last_name, inventor_city,
                  assignee_organization, and assignee_lastknown_state"
                ) #box
                ), #fuild row
              fluidPage( #look over this...it gets weird. 
                titlePanel("Patent Data"),
                fluidRow(
                  column(6, 
                         textInput("last_name", "Inventor's last name contains (e.g., Favire)")),
                  column(6,
                         selectInput("ass",
                                     "State of Assignee Organization:",
                                     c("All",
                                       unique(as.character(objective_2$assignee_lastknown_state))))
                         )),
                mainPanel(
                  h2("Objective 2"),
                  dataTableOutput("Table1")
                )
              ) # fluidPage 1
              ), #tab item 2
      tabItem(tabName = "Objective_3",
              h2("Objective 3"),
              fluidRow(
                box(
                  width = 14, background = "black",
                  "Use a bar plot to show the top 5 assignee organizations 
                  in term of number of granted patents"
                ),#box
                  mainPanel(
                    plotOutput("df")  
                  )
              )
                ) #fuild row
              ) #tab item 3
      ) #tabItems
    ) #dashboard Body
 #dashboard Page
    


test_server = function (input, output) {
  
  
  output$summary <- renderPrint({
    
    v = paste("The number of patents:",Num_Patents, 
              "The number of Assignees:", Num_Assignee, 
              "The number of Inventors:", Num_Inventor)
    
    return(v)
  })
  
  output$table1 <- renderDataTable({
    
    test_table = objective_2
    
    return(test_table)
  })
}

shinyApp(project_ui, test_server)

