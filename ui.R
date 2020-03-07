# Sunday 16 February 2020

source("data_loader.R")


ui = argonDashPage(
    
    title = "University Comparison Dashboard",
    description = "Choosing the right degree to study in Singapore",
    author = "Joanna Khek Cuina",
    sidebar = argonDashSidebar(
        vertical = TRUE,
        skin = 'light',
        background = 'white',
        size = 'md',
        side = 'left',
        id = 'sidebar',
        img(src = "logo1.png", height = 185),
        br(),
        br(),
        argonSidebarMenu(
            argonSidebarItem(
                tabName = 'overview',
                icon = argonIcon('book-bookmark'),
                'Eligible Courses'
            ),
            
            argonSidebarItem(
                tabName = 'ranking',
                icon = argonIcon('trophy'),
                'Ranking'
            ),
            
            argonSidebarItem(
                tabName = 'graduates',
                icon = argonIcon('hat-3'),
                'Graduates'
            ),
            
            argonSidebarItem(
                tabName = "employment",
                icon = argonIcon('briefcase-24'),
                'Employment'
            ),
            
            argonSidebarItem(
                tabName = "grades",
                icon = argonIcon('books'),
                'Grades'
            ),
            
            argonSidebarItem(
                tabName = "about",
                icon = argonIcon('single-02'),
                'About'
            )
        )
        
    ),
    
    header = argonDashHeader(
        gradient=FALSE,
        color = 'info',
        h2("University Comparison Dashboard", style='font-color:#5D6D7E;text-align:center;font-size:3em;font-weight:bold;')
        #h3("Singapore Universities Comparison Dashboard", style = 'color:white;text-align:center;font-size:2em;')
    ),
    
    body = argonDashBody(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
            ),
        argonTabItems(
            argonTabItem(
                tabName = "overview",
                argonCard(
                    title = "Find your Eligible Courses",
                    width = 12,
                    
                    argonTabSet(
                        id="tabset1",
                        card_wrapper=FALSE,
                        horizontal=TRUE,
                        circle=FALSE,
                        size="md",
                        width=12,
                        iconList = list(
                            argonIcon("book-bookmark"),
                            argonIcon("book-bookmark")
                        ),
                        
                        
                        argonTab(
                            tabName = "A Levels",
                            active=TRUE,
                            argonColumn(
                                width = 3,
                                radioGroupButtons(
                                    inputId = "input1",
                                    label = "Select H2 Grade",
                                    choices = c("A", "B", "C", "D", "E"),
                                    selected = "A",
                                    justified = TRUE,
                                    individual = TRUE
                                ),
                                
                                radioGroupButtons(
                                    inputId = "input2",
                                    label = "Select H2 Grade",
                                    choices = c("A", "B", "C", "D", "E"),
                                    selected = "A",
                                    justified = TRUE,
                                    individual = TRUE
                                ),
                                
                                radioGroupButtons(
                                    inputId = "input3",
                                    label = "Select H2 Grade",
                                    choices = c("A", "B", "C", "D", "E"),
                                    selected = "A",
                                    justified = TRUE,
                                    individual = TRUE
                                ),
                                
                                radioGroupButtons(
                                    inputId = "input4",
                                    label = "Select H1 Grade",
                                    choices = c("A", "B", "C", "D", "E"),
                                    selected = "A",
                                    justified = TRUE,
                                    individual = TRUE
                                ),
                                
                                textOutput("total_grade_points"),
                                h5("Note: Total Grade Point is assuming a C in both General Paper and Project Work")
                                
                            ),
                            
                            argonColumn(
                                width=9,
                                argonTabSet(
                                    id="tabset2",
                                    card_wrapper=FALSE,
                                    horizontal=TRUE,
                                    circle=FALSE,
                                    size="md",
                                    width=12,
                                    iconList = list(
                                        argonIcon("single-copy-04"),
                                        argonIcon("single-copy-04"),
                                        argonIcon("single-copy-04")
                                        ),
                                    
                                    argonTab(
                                        tabName = "National University of Singapore",
                                        active=TRUE,
                                        argonColumn(
                                            width=3,
                                            img(src='nus_logo.png', align = "left", height=100, width=200)
                                        ),
                                        argonColumn(
                                            width=9,
                                            reactableOutput(outputId = "table1")
                                        )
                                    ),
                                    
                                    argonTab(
                                        tabName = "Nanyang Technologlocal University",
                                        active=FALSE,
                                        argonColumn(
                                            width=3,
                                            img(src='ntu_logo.png', align = "left", height=80, width=225)
                                        ),
                                        argonColumn(
                                            width=9,
                                            reactableOutput(outputId = "table2")
                                        )
                                    ),
                                    
                                    argonTab(
                                        tabName = "Singapore Management University",
                                        active=FALSE,
                                        argonColumn(
                                            width=3,
                                            img(src='smu_logo.png', align = "left", height=90, width=225)
                                        ),
                                        argonColumn(
                                            width=9,
                                            reactableOutput(outputId = "table3")
                                        )
                                    )
                                )
                            )
                        ),
                        
                        argonTab(
                            tabName = "Diploma",
                            active=FALSE,
                            argonColumn(
                                width=3,
                                useShinyFeedback(),
                                numericInput("input5", "Enter CGPA", value=4, min=0, max=4, step=0.01)
                            ),
                            argonColumn(
                                width=9,
                                argonTabSet(
                                    id="tabset3",
                                    card_wrapper=FALSE,
                                    horizontal=TRUE,
                                    circle=FALSE,
                                    size="md",
                                    width=12,
                                    iconList = list(
                                        argonIcon("single-copy-04"),
                                        argonIcon("single-copy-04"),
                                        argonIcon("single-copy-04")
                                    ),
                                    
                                    argonTab(
                                        tabName = "National University of Singapore",
                                        active=TRUE,
                                        argonColumn(
                                            width=3,
                                            img(src='nus_logo.png', align = "left", height=100, width=200)
                                        ),
                                        argonColumn(
                                            width=9,
                                            reactableOutput(outputId = "table4")
                                        )
                                    ),
                                    
                                    argonTab(
                                        tabName = "Nanyang Technologlocal University",
                                        active=FALSE,
                                        argonColumn(
                                            width=3,
                                            img(src='ntu_logo.png', align = "left", height=80, width=225)
                                        ),
                                        argonColumn(
                                            width=9,
                                            reactableOutput(outputId = "table5")
                                        )
                                    ),
                                    
                                    argonTab(
                                        tabName = "Singapore Management University",
                                        active=FALSE,
                                        argonColumn(
                                            width=3,
                                            img(src='smu_logo.png', align = "left", height=90, width=225)
                                        ),
                                        argonColumn(
                                            width=9,
                                            reactableOutput(outputId = "table6")
                                    )
                                )
                            )
                        )
                    )
                )
                )
            ),
        
                   
            argonDash::argonTabItem(
                tabName = "ranking",
                argonRow(
                    argonCard(
                        title = "World Ranking",
                        width = 12,
                        
                        argonTabSet(
                            id="tabset4",
                            card_wrapper=FALSE,
                            horizontal=TRUE,
                            circle=FALSE,
                            size="sm",
                            width=12,
                            iconList = list(
                                argonIcon("trophy"),
                                argonIcon("chart-bar-32")
                            ),
                            
                            argonTab(
                                tabName = "Ranking",
                                active=TRUE,
                                argonColumn(
                                    width = 4,
                                    argonAlert(
                                        icon = argonIcon("notification-70"),
                                        status = "success",
                                        "NUS data is available",
                                        closable = TRUE
                                    )
                                ),
                                
                                argonColumn(
                                    width = 4,
                                    argonAlert(
                                        icon = argonIcon("notification-70"),
                                        status = "success",
                                        "NTU data is available",
                                        closable = TRUE
                                    )
                                ),
                                
                                argonColumn(
                                    width = 4,
                                    argonAlert(
                                        icon = argonIcon("notification-70"),
                                        status = "danger",
                                        "SMU data not available",
                                        closable = TRUE
                                    )
                                ),
                                
                                argonColumn(highchartOutput(outputId = "hc1"), width=12)
                            ),
                            
                            argonTab(
                                tabName = "Survey Indices",
                                active=FALSE,
                                
                                argonColumn(highchartOutput(outputId ="hc2"), width=6),
                                argonColumn(highchartOutput(outputId = "hc3"), width=6)
                            )
                            
                        )

                    )
                ),
                
                argonRow(
                    argonCard(
                        title = "Asia Ranking",
                        width = 12,
                        
                        argonTabSet(
                            id="tabset5",
                            card_wrapper=FALSE,
                            horizontal=TRUE,
                            circle=FALSE,
                            size="md",
                            width=12,
                            iconList = list(
                                argonIcon("trophy"),
                                argonIcon("chart-bar-32")
                            ),
                            
                            argonTab(
                                tabName = "Ranking",
                                active=TRUE,
                                argonColumn(
                                    width = 4,
                                    argonAlert(
                                        icon = argonIcon("notification-70"),
                                        status = "success",
                                        "NUS data is available",
                                        closable = TRUE
                                    )
                                ),
                                
                                argonColumn(
                                    width = 4,
                                    argonAlert(
                                        icon = argonIcon("notification-70"),
                                        status = "success",
                                        "NTU data is available",
                                        closable = TRUE
                                    )
                                ),
                                
                                argonColumn(
                                    width = 4,
                                    argonAlert(
                                        icon = argonIcon("notification-70"),
                                        status = "danger",
                                        "SMU data not available",
                                        closable = TRUE
                                    )
                                ),

                                argonColumn(highchartOutput(outputId = "hc4"), width=12)
                            ),
                            
                            argonTab(
                                tabName = "Survey Indices",
                                active=FALSE,
                                argonColumn(highchartOutput(outputId = "hc5"), width=6),
                                argonColumn(highchartOutput(outputId = "hc6"), width=6)
                            )
                        )

                    )
                )
            ),
            
            argonDash::argonTabItem(
                tabName = "graduates",
                argonR::argonRow(
                    argonR::argonCard(
                        width=12,
                        title ="Intake and Graduates",
                        argonColumn(highchartOutput(outputId = "hc7"), width=6),
                        argonColumn(highchartOutput(outputId = "hc8"), width=6)
                    )
                )
            ),
                
            
            argonDash::argonTabItem(
                tabName = "employment",
                argonR::argonRow(
                    argonR::argonCard(
                        title = "National University of Singapore",
                        width = 12,
                        argonColumn(width=6,
                            selectInput(inputId="nus_school_Input", "Select a School", choices = sort(unique(employment_data_nus$school)), width="600px")
                        ),
                        argonColumn(width=6,
                            selectInput(inputId="nus_degree_Input", "Select a Degree", choices = NULL, width="600px")
                        ),
                        argonColumn(highchartOutput(outputId = "hc9"), width=4),
                        argonColumn(highchartOutput(outputId = "hc10"), width=4),
                        argonColumn(highchartOutput(outputId = "hc11"), width=4)
                    ),
                
                    
                    argonR::argonCard(
                        title = "Nanyang Technological University",
                        width = 12,
                        argonColumn(width=6,
                                    selectInput(inputId="ntu_school_Input", "Select a School", choices = sort(unique(employment_data_ntu$school)), width="600px")
                        ),
                        argonColumn(width=6,
                                    selectInput(inputId="ntu_degree_Input", "Select a Degree", choices = NULL, width="600px")
                        ),
                        
                        argonColumn(highchartOutput(outputId = "hc12"), width=4),
                        argonColumn(highchartOutput(outputId = "hc13"), width=4),
                        argonColumn(highchartOutput(outputId = "hc14"), width=4)
                        
                    ),
                    
                    argonR::argonCard(
                        title = "Singapore Management University",
                        width = 12,
                        argonColumn(width=6,
                                    selectInput(inputId="smu_school_Input", "Select a School", choices = sort(unique(employment_data_smu$school)), width="600px")
                        ),
                        argonColumn(width=6,
                                    selectInput(inputId="smu_degree_Input", "Select a Degree", choices = NULL, width="600px")
                        ),
                       
                        argonColumn(highchartOutput(outputId = "hc15"), width=4),
                        argonColumn(highchartOutput(outputId = "hc16"), width=4),
                        argonColumn(highchartOutput(outputId = "hc17"), width=4)
                        )
                    )
            ),
            
            argonTabItem(
                tabName = "grades",
                argonR::argonRow(
                    argonR::argonCard(
                        title = "National University of Singapore",
                        width = 12,
                        argonColumn(width=6,
                                    selectInput(inputId="nus_school_grade_Input", "Select a School", choices = sort(unique(grades_data_nus$School)), width="600px")
                        ),
                        argonColumn(width=6,
                                    selectInput(inputId="nus_faculty_grade_Input", "Select a Faculty", choices = NULL, width="600px")
                        ),
                        argonColumn(highchartOutput(outputId = "hc18"), width=4),
                        argonColumn(highchartOutput(outputId = "hc19"), width=4),
                        argonColumn(reactableOutput(outputId = "table7"), width=4)
                        ),
                    
                    argonR::argonCard(
                        title = "Nanyang Technological University",
                        width=12,
                        argonColumn(width=6,
                                    selectInput(inputId="ntu_school_grade_Input", "Select a School", choices = sort(unique(grades_data_ntu$School)), width="600px")
                        ),
                        argonColumn(width=6,
                                    selectInput(inputId="ntu_faculty_grade_Input", "Select a Faculty", choices = NULL, width="600px")
                        ),
                        argonColumn(highchartOutput(outputId = "hc20"), width=4),
                        argonColumn(highchartOutput(outputId = "hc21"), width=4),
                        argonColumn(reactableOutput(outputId = "table8"), width=4)
                                    
                    ),
                    
                    argonR::argonCard(
                        title = "Singapore Management University",
                        width=12,
                        argonColumn(width=6,
                                    selectInput(inputId="smu_school_grade_Input", "Select a School", choices = sort(unique(grades_data_smu$School)), width="600px")
                        ),
                        argonColumn(width=6,
                                    selectInput(inputId="smu_faculty_grade_Input", "Select a Faculty", choices = NULL, width="600px")
                        ),
                        argonColumn(highchartOutput(outputId = "hc22"), width=4),
                        argonColumn(highchartOutput(outputId = "hc23"), width=4),
                        argonColumn(reactableOutput(outputId = "table9"), width=4)            
                    )
                )
            ),
           
            
            argonTabItem(
                tabName = "about",
                argonSocialButton(
                    src = "https://www.linkedin.com/in/joannakhek/",
                    status = "default",
                    icon = icon("linkedin")
                ),
                argonSocialButton(
                    src = "https://joanna-khek.github.io/",
                    status = "default",
                    icon = icon("github")
                ),
                argonUser(
                    title = "Joanna Khek Cuina",
                    subtitle = "Singapore",
                    "Hi there. My name is Joanna Khek Cuina and this is my submission for Rshiny Competition 2020. With the recent release of A Level results, i was motivated
                    to build a informative dashboard to help my fellow Singaporeans with their university course choice. There are many factors to consider when choosing a university and
                    such information are often scattered around the different websites. Hence, I thought it would be a good idea to consolidate all useful information into one dashboard.
                    In this web application, i have only compared National University of Singapore, Nanyang Technological University and Singapore Management University as 
                    there are more readily available data from them given their relatively longer history in Singapore. 
                    Some of the main packages used for building this web application are argonDash, highcharter, reactable and shinywidgets.
                    It has truly been an enjoyable experience building this dashboard and i've learnt a lot during the process."
                
                )

            )
        )
    )
)




