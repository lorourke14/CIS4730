# CIS4730
Final project for CIS4730

Overview
The rapid advancement of technology and explosion of knowledge-based economy over the last decades
have intensified the use of patents. Patent data analysis is important to the business community as
it sheds light on competitive intelligence, technological progress, and R&D opportunities.
Our final project involves patient data analysis. It integrates several topics covered in our course:
  1. Retrieve patent data using Web APIs
  2. Query NoSQL patent database
  3. Manipulate and process patent data (title, abstract, inventor, assignee, etc.)
  4. Analyze patterns in patent data
  5. Summarize and visualize results

You will need to use several R packages for this project, including patentsview, tidyverse, shiny,
and so on. Make your own assumptions/decisions along the way of your data processing and analysis.
There is no correct answer when it comes to that! You are fine if your assumptions/decisions are
well reasoned and explained.

The project requires team work. Ideally, each team should consist of 3 students. Students are free
to choose their own teammates, but the instructor will intervene when necessary. Once you decide
your team, go to the course website on iCollge and self-enroll yourself to a group.
Specific Instructions

It would require a very powerful machine to be able to analyze the entire patent database. As such,
we will only consider a small subset of patents that were granted in the first quarter of 2016 (from
1/1/2016 to 3/31/2016). The patentsview package allows you to query and retrieve patents issued
in a particular time frame.

You will develop and present your project using a shiny web app. There are several core and menu
objectives. A project needs to achieve all the core objectives and at least half of the menu objectives.
Core objectives (achieve all of these)
  1. Show the following summary statistics: the number of patents, the number of unique assignees,
     and the number of unique inventors (similar example)
  2. Represent the patents in a data table with at least the following columns: patent_number,
     patent_date, patent_title, inventor_last_name, assignee_organization, and assignee_
     lastknown_state (similar example)
  3. Use a bar plot to show the top 5 assignee organizations in term of the number of granted
     patents (similar example)
  4. Use a dropdown box to select the state of assignee organizations (similar example)
  5. Use a text box to query inventor’s last name (similar example: Director name contains . . . : )

Menu objectives (achieve at least 3 of these)
Each menu objective is a business question. Your shiny app should be able to display answers to at
least 3 of the following questions. During the project presentation you need to explain how you
reach your answers.
  1. What are the ten most common words (excluding stop words) in patent titles?
  2. Who are the five most prolific inventors?
  3. Which five countries are most interested in obtaining patents?
  4. Which assignee organizations have more than 10 patents?
  5. Which patents have been cited by more than 10 patents?
  6. What is the average length between the date a patent application was filed and the date
     patent was granted?

Please note that you should consider and use only the subset of patents (between
1/1/2016 and 3/31/2016) when answering these questions.

Project Evaluations
Final project consists of the following 300 points:
  • Presentation and live demo: 200 points
    – Whether the core and menu objectives are met?
    – Whether the app is functioning correctly during the live demo?
    – Whether the presentation is professional and providing useful/interesting conclusions?
  • Project report: 50 points
    – The core and menu objectives achieved by your shiny app
    – Screenshots of your shiny app
    – Main findings and conclusions from your analysis
  • Peer evaluation: 50 points
    – Whether your are a good team player? (evaluated by your teammates)

Expectations
For project presentation and live demo:
  • Each team will have 5 minutes in total for their presentation and live demo.
  • You will use your own laptop for the demo.
For project report:
  • The length of your report plays no role on your grade. In terms of grading, the most important
    part of the report is the main findings and conclusions section.
  • Each team will designate a student to submit the project report and codes for the team.
