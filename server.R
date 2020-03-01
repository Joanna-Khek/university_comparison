# Sunday 16 February 2020


server = shinyServer( function(session, input, output) {
  
  observe({
    nus_degree = employment_data_nus %>% filter(school == input$nus_school_Input) %>% pull(degree)
    updateSelectInput(session, "nus_degree_Input", choices = unique(nus_degree))
    
    ntu_degree = employment_data_ntu %>% filter(school == input$ntu_school_Input) %>% pull(degree)
    updateSelectInput(session, "ntu_degree_Input", choices = unique(ntu_degree))
    
    smu_degree = employment_data_smu %>% filter(school == input$smu_school_Input) %>% pull(degree)
    updateSelectInput(session, "smu_degree_Input", choices = unique(smu_degree))
    
    nus_faculty = grades_data_nus %>% filter(School == input$nus_school_grade_Input) %>% pull(Faculty)
    updateSelectInput(session, "nus_faculty_grade_Input", choices = unique(nus_faculty))
    
    ntu_faculty = grades_data_ntu %>% filter(School == input$ntu_school_grade_Input) %>% pull(Faculty)
    updateSelectInput(session, "ntu_faculty_grade_Input", choices = unique(ntu_faculty))
    
    smu_faculty = grades_data_smu %>% filter(School == input$smu_school_grade_Input) %>% pull(Faculty)
    updateSelectInput(session, "smu_faculty_grade_Input", choices = unique(smu_faculty))
    
    
  })
  
  observe({
    point1 = h2_convert_to_points(input$input1)
    point2 = h2_convert_to_points(input$input2)
    point3 = h2_convert_to_points(input$input3)
    point4 = h1_convert_to_points(input$input4)
    total_points = point1 + point2 + point3 + point4 + 15
    output$total_grade_points = renderText({
      paste("Total Grade Point: ", total_points)
    })
  })
  
  cols = viridis(3)
  
  h2_convert_to_points = function(input){
    if (input == "A"){
      point = 20}
    else if (input == "B"){
      point = 17.5}
    else if (input == "C"){
      point = 15}
    else if (input == "D"){
      point = 12.5}
    else {
      point = 10}
  }
  
  h1_convert_to_points = function(input){
    if (input == "A"){
      point = 10}
    else if (input == "B"){
      point = 8.75}
    else if (input == "C"){
      point = 7.5}
    else if (input == "D"){
      point = 6.25}
    else {
      point = 5}
  }
  
   
   nus_courses_alevel = reactive({
     point1 = h2_convert_to_points(input$input1)
     point2 = h2_convert_to_points(input$input2)
     point3 = h2_convert_to_points(input$input3)
     point4 = h1_convert_to_points(input$input4)
     total_points = point1 + point2 + point3 + point4 + 15
     grades_data_nus %>% filter(A.Level.Points <= total_points) %>% filter(Year.Intake == "2019")
   })
   
   ntu_courses_alevel = reactive({
     point1 = h2_convert_to_points(input$input1)
     point2 = h2_convert_to_points(input$input2)
     point3 = h2_convert_to_points(input$input3)
     point4 = h1_convert_to_points(input$input4)
     total_points = point1 + point2 + point3 + point4 + 15
     grades_data_ntu %>% filter(A.Level.Points <= total_points) %>% filter(Year.Intake == "2019")
   })
   
   smu_courses_alevel = reactive({
     point1 = h2_convert_to_points(input$input1)
     point2 = h2_convert_to_points(input$input2)
     point3 = h2_convert_to_points(input$input3)
     point4 = h1_convert_to_points(input$input4)
     total_points = point1 + point2 + point3 + point4 + 15
     grades_data_smu %>% filter(A.Level.Points <= total_points) %>% filter(Year.Intake == "2019")
   })
  
   
   observeEvent(input$input5, {
     feedbackDanger(
       inputId = "input5",
       condition = input$input5 < 0,
       text = "CPGA cannot be less than 0")
     
     feedbackDanger(
       inputId = "input5",
       condition = input$input5 > 4,
       text = "CPGA cannot be more than 4"
     )
   })
   
   nus_courses_diploma = reactive({
     grades_data_nus %>% filter(CGPA <= input$input5) %>% filter(Year.Intake == "2019")
   })
   
   ntu_courses_diploma = reactive({
     grades_data_ntu %>% filter(CGPA <= input$input5) %>% filter(Year.Intake == "2019")
   })
   
   smu_courses_diploma = reactive({
     grades_data_smu %>% filter(CGPA <= input$input5) %>% filter(Year.Intake == "2019")
   })


  output$table1 = renderReactable({
    reactable(nus_courses_alevel() %>% select(c("Year.Intake", "School", "Faculty", "A.Level.Points")),
              compact = TRUE, 
              striped = TRUE, 
              borderless = TRUE,
              resizable = TRUE)
  })
  
  output$table2 = renderReactable({
    reactable(ntu_courses_alevel() %>% select(c("Year.Intake", "School", "Faculty", "A.Level.Points")),
              compact = TRUE, 
              striped = TRUE, 
              borderless = TRUE,
              resizable = TRUE)
  })
  
  output$table3 = renderReactable({
    reactable(smu_courses_alevel() %>% select(c("Year.Intake", "School", "Faculty", "A.Level.Points")),
              compact = TRUE, 
              striped = TRUE, 
              borderless = TRUE,
              resizable = TRUE)
  })
  
  output$table4 = renderReactable({
    reactable(nus_courses_diploma() %>% select(c("Year.Intake", "School", "Faculty", "CGPA")),
              compact = TRUE, 
              striped = TRUE, 
              borderless = TRUE,
              resizable = TRUE)
  })
  
  output$table5 = renderReactable({
    reactable(ntu_courses_diploma() %>% select(c("Year.Intake", "School", "Faculty", "CGPA")),
              compact = TRUE, 
              striped = TRUE, 
              borderless = TRUE,
              resizable = TRUE)
  })
  
  output$table6 = renderReactable({
    reactable(smu_courses_diploma() %>% select(c("Year.Intake", "School", "Faculty", "CGPA")),
              compact = TRUE, 
              striped = TRUE, 
              borderless = TRUE,
              resizable = TRUE)
  })

  output$hc1 = renderHighchart({
                        highchart() %>% 
                          hc_chart(type="line") %>% 
                          hc_xAxis(categories = world_rank_data_melt$Year, reversed=TRUE) %>%
                          hc_add_series((world_rank_data_melt %>% filter(variable == "NUS_Ranking"))$value, name = "NUS") %>%
                          hc_add_series((world_rank_data_melt %>% filter(variable == "NTU_Ranking"))$value, name = "NTU") %>%
                          hc_yAxis(title = list(text="Ranking"), reversed=TRUE) %>%
                          hc_colors(cols) %>%
                          hc_title(text = "<b>Ranking</b>")
                        })
  
  
  output$hc2 = renderHighchart({
                      highchart() %>%
                        hc_chart(type="bar") %>%
                        hc_xAxis(categories = world_survey_indices_data_melt$Survey_Indices) %>%
                        hc_add_series((world_survey_indices_data_melt %>% filter(variable == "NUS_Score"))$value, name="NUS") %>%
                        hc_add_series((world_survey_indices_data_melt %>% filter(variable == "NTU_Score"))$value, name="NTU") %>%
                        hc_add_series((world_survey_indices_data_melt %>% filter(variable == "SMU_Score"))$value, name="SMU") %>%
                        hc_yAxis(title = list(text="Score")) %>%
                        hc_tooltip(crosshairs=TRUE) %>%
                        hc_colors(cols) %>%
                        hc_title(text = "<b>Score</b>")
  })
  
  output$hc3 = renderHighchart({
                     highchart() %>%
                       hc_chart(type="scatter") %>%
                       hc_xAxis(categories = world_survey_indices_data_melt$Survey_Indices) %>%
                       hc_add_series((world_survey_indices_data_melt %>% filter(variable == "NUS_Ranking"))$value, name="NUS",
                                      tooltip = list(pointFormat = "Rank: {point.y}")) %>%
                       hc_add_series((world_survey_indices_data_melt %>% filter(variable == "NTU_Ranking"))$value, name="NTU",
                                     tooltip = list(pointFormat = "Rank: {point.y}")) %>%
                       hc_add_series((world_survey_indices_data_melt %>% filter(variable == "SMU_Ranking"))$value, name="SMU",
                                     tooltip = list(pointFormat = "Rank: {point.y}")) %>%
                       hc_yAxis(title=list(text="Ranking"), reversed=TRUE, tickInterval = 100) %>%
                       hc_colors(cols) %>%
                       hc_tooltip(crosshairs=TRUE) %>%
                       hc_title(text = "<b>Ranking</b>")
  })
  
  output$hc4 = renderHighchart({
                    highchart() %>%
                      hc_chart(type="line") %>%
                      hc_xAxis(categories = asia_rank_data_melt$Year, reversed=TRUE) %>%
                      hc_add_series((asia_rank_data_melt %>% filter(variable == "NUS_Ranking"))$value, name = "NUS") %>%
                      hc_add_series((asia_rank_data_melt %>% filter(variable == "NTU_Ranking"))$value, name = "NTU") %>%
                      hc_yAxis(title = list(text="Ranking"), reversed=TRUE) %>%
                      hc_tooltip(crosshairs=TRUE) %>%
                      hc_colors(cols) %>%
                      hc_title(text = "<b>Ranking</b>")
  })  
  
  
  output$hc5 = renderHighchart({
                    highchart() %>%
                      hc_chart(type="bar") %>%
                      hc_xAxis(categories = asia_survey_indices_data_melt$Survey_Indices) %>%
                      hc_add_series((asia_survey_indices_data_melt %>% filter(variable == "NUS_Score"))$value, name="NUS") %>%
                      hc_add_series((asia_survey_indices_data_melt %>% filter(variable == "NTU_Score"))$value, name="NTU") %>%
                      hc_add_series((asia_survey_indices_data_melt %>% filter(variable == "SMU_Score"))$value, name="SMU") %>%
                      hc_yAxis(title = list(text="Score")) %>%
                      hc_tooltip(crosshairs=TRUE) %>%
                      hc_colors(cols) %>%
                      hc_title(text = "<b>Score</b>")
  })
  
  output$hc6 = renderHighchart({
                    highchart() %>%
                      hc_chart(type="scatter") %>%
                      hc_xAxis(categories = asia_survey_indices_data_melt$Survey_Indices) %>%
                      hc_add_series((asia_survey_indices_data_melt %>% filter(variable == "NUS_Ranking"))$value, name="NUS",
                                    tooltip = list(pointFormat = "Rank: {point.y}")) %>%
                      hc_add_series((asia_survey_indices_data_melt %>% filter(variable == "NTU_Ranking"))$value, name="NTU",
                                    tooltip = list(pointFormat = "Rank: {point.y}")) %>%
                      hc_add_series((asia_survey_indices_data_melt %>% filter(variable == "SMU_Ranking"))$value, name="SMU",
                                    tooltip = list(pointFormat = "Rank: {point.y}")) %>%
                      hc_yAxis(title=list(text="Ranking"), reversed=TRUE, tickInterval = 100) %>%
                      hc_colors(cols) %>%
                      hc_tooltip(crosshairs=TRUE) %>%
                      hc_title(text = "<b>Ranking</b>")
  })
  
  output$hc7 = renderHighchart({
                    highchart() %>%
                      hc_chart(type="line") %>%
                      hc_xAxis(categories = intake_data_nus$year) %>%
                      hc_add_series(intake_data_nus$value, name = "NUS") %>%
                      hc_add_series(intake_data_ntu$value, name="NTU") %>%
                      hc_add_series(intake_data_smu$value, name="SMU") %>%
                      hc_yAxis(title=list(text="Intakes")) %>%
                      hc_colors(cols) %>%
                      hc_title(text=" <b>Intakes</b>") %>%
                      hc_tooltip(crosshairs=TRUE)
                      
  })                
  
  output$hc8 = renderHighchart({
                    highchart() %>%
                      hc_chart(type="line") %>%
                      hc_xAxis(categories = graduates_data_nus$year) %>%
                      hc_add_series(graduates_data_nus$value, name="NUS") %>%
                      hc_add_series(graduates_data_ntu$value, name="NTU") %>%
                      hc_add_series(graduates_data_smu$value, name="SMU") %>%
                      hc_yAxis(title=list(text="Graduates")) %>%
                      hc_colors(cols) %>%
                      hc_title(text ="<b>Graduates</b>") %>%
                      hc_tooltip(crosshairs=TRUE)
  })
  
  
  
  filtered_data_nus = reactive({
                   employment_data_nus %>% filter(school == input$nus_school_Input) %>% filter(degree == input$nus_degree_Input)
  })
  
  
  output$hc9 = renderHighchart({
                        highchart() %>%
                        hc_chart(type="line") %>%
                        hc_xAxis(categories = filtered_data_nus()$year) %>%
                        hc_add_series(filtered_data_nus()$employment_rate_overall, name="Overall Employment Rate") %>%
                        hc_yAxis(title=list(text="Employment")) %>%
                        hc_colors(cols) %>%
                        hc_title(text="<b>Overall Employment Rate</b>") %>%
                        hc_tooltip(crosshairs=TRUE)
  })
  
  
  output$hc10 = renderHighchart({
    highchart() %>%
      hc_chart(type="line") %>%
      hc_xAxis(categories = filtered_data_nus()$year) %>%
      hc_add_series(filtered_data_nus()$basic_monthly_mean, name="Basic Monthly Mean") %>%
      hc_yAxis(title=list(text="Employment")) %>%
      hc_colors(cols) %>%
      hc_title(text="<b>Basic Monthly Mean</b>") %>%
      hc_tooltip(crosshairs=TRUE)
  })
  
 
  output$hc11 = renderHighchart({
    highchart() %>%
      hc_chart(type="line") %>%
      hc_xAxis(categories = filtered_data_nus()$year) %>%
      hc_add_series(filtered_data_nus()$gross_monthly_mean, name="Gross Monthly Mean") %>%
      hc_yAxis(title=list(text="Employment")) %>%
      hc_colors(cols) %>%
      hc_title(text="<b>Gross Monthly Mean</b>") %>%
      hc_tooltip(crosshairs=TRUE)
  })
  

  filtered_data_ntu = reactive({
    employment_data_ntu %>% filter(school == input$ntu_school_Input) %>% filter(degree == input$ntu_degree_Input)
  })
  
  
  output$hc12 = renderHighchart({
    highchart() %>%
      hc_chart(type="line") %>%
      hc_xAxis(categories = filtered_data_ntu()$year) %>%
      hc_add_series(filtered_data_ntu()$employment_rate_overall, name="Overall Employment Rate") %>%
      hc_yAxis(title=list(text="Employment")) %>%
      hc_colors(cols[2]) %>%
      hc_title(text="<b>Overall Employment Rate</b>") %>%
      hc_tooltip(crosshairs=TRUE)
  })
  
  
  output$hc13 = renderHighchart({
    highchart() %>%
      hc_chart(type="line") %>%
      hc_xAxis(categories = filtered_data_ntu()$year) %>%
      hc_add_series(filtered_data_ntu()$basic_monthly_mean, name="Basic Monthly Mean") %>%
      hc_yAxis(title=list(text="Employment")) %>%
      hc_colors(cols[2]) %>%
      hc_title(text="<b>Basic Monthly Mean</b>") %>%
      hc_tooltip(crosshairs=TRUE)
  })
  
  
  output$hc14 = renderHighchart({
    highchart() %>%
      hc_chart(type="line") %>%
      hc_xAxis(categories = filtered_data_ntu()$year) %>%
      hc_add_series(filtered_data_ntu()$gross_monthly_mean, name="Gross Monthly Mean") %>%
      hc_yAxis(title=list(text="Employment")) %>%
      hc_colors(cols[2]) %>%
      hc_title(text="<b>Gross Monthly Mean</b>") %>%
      hc_tooltip(crosshairs=TRUE)
  })
  
  
  filtered_data_smu = reactive({
    employment_data_smu %>% filter(school == input$smu_school_Input) %>% filter(degree == input$smu_degree_Input)
  })
  
  
  output$hc15 = renderHighchart({
    highchart() %>%
      hc_chart(type="line") %>%
      hc_xAxis(categories = filtered_data_smu()$year) %>%
      hc_add_series(filtered_data_smu()$employment_rate_overall, name="Overall Employment Rate") %>%
      hc_yAxis(title=list(text="Employment")) %>%
      hc_colors(cols[3]) %>%
      hc_title(text="<b>Overall Employment Rate</b>") %>%
      hc_tooltip(crosshairs=TRUE)
  })
  
  output$hc16 = renderHighchart({
    highchart() %>%
      hc_chart(type="line") %>%
      hc_xAxis(categories = filtered_data_smu()$year) %>%
      hc_add_series(filtered_data_smu()$basic_monthly_mean, name="Basic Monthly Mean") %>%
      hc_yAxis(title=list(text="Employment")) %>%
      hc_colors(cols[3]) %>%
      hc_title(text="<b>Basic Monthly Mean</b>") %>%
      hc_tooltip(crosshairs=TRUE)
  })
  
  
  output$hc17 = renderHighchart({
    highchart() %>%
      hc_chart(type="line") %>%
      hc_xAxis(categories = filtered_data_smu()$year) %>%
      hc_add_series(filtered_data_smu()$gross_monthly_mean, name="Gross Monthly Mean") %>%
      hc_yAxis(title=list(text="Employment")) %>%
      hc_colors(cols[3]) %>%
      hc_title(text="<b>Gross Monthly Mean</b>") %>%
      hc_tooltip(crosshairs=TRUE)
  })
  
  
  filtered_data_grade_nus = reactive({
    grades_data_nus %>% filter(School == input$nus_school_grade_Input) %>% filter(Faculty == input$nus_faculty_grade_Input)
  })
  
  
  output$hc18 = renderHighchart({
    highchart() %>%
      hc_chart(type="line") %>%
      hc_xAxis(categories = filtered_data_grade_nus()$Year.Intake, reversed=TRUE) %>%
      hc_add_series(filtered_data_grade_nus()$A.Level.Points, name="A Level Grade Point") %>%
      hc_yAxis(title=list(text="Grade Point")) %>%
      hc_colors(cols[1]) %>%
      hc_title(text="<b>A Level Grade Point</b>") %>%
      hc_tooltip(crosshairs=TRUE)
  })
  
  
  output$hc19 = renderHighchart({
    highchart() %>%
      hc_chart(type="line") %>%
      hc_xAxis(categories = filtered_data_grade_nus()$Year.Intake, reversed=TRUE) %>%
      hc_add_series(filtered_data_grade_nus()$CGPA, name="Diploma CGPA") %>%
      hc_yAxis(title=list(text="CGPA")) %>%
      hc_colors(cols[1]) %>%
      hc_title(text="<b>Diploma CGPA</b>") %>%
      hc_tooltip(crosshairs=TRUE)
  })
  
  output$table7 = renderReactable({
    reactable(filtered_data_grade_nus() %>% select(c("Year.Intake","A.Level", "A.Level.Points", "CGPA")), compact = TRUE, striped = TRUE, borderless = TRUE)
  })
  
  
  filtered_data_grade_ntu = reactive({
    grades_data_ntu %>% filter(School == input$ntu_school_grade_Input) %>% filter(Faculty == input$ntu_faculty_grade_Input)
  })
  
  
  output$hc20 = renderHighchart({
    highchart() %>%
      hc_chart(type="line") %>%
      hc_xAxis(categories = filtered_data_grade_ntu()$Year.Intake, reversed=TRUE) %>%
      hc_add_series(filtered_data_grade_ntu()$A.Level.Points, name="A Level Grade Point") %>%
      hc_yAxis(title=list(text="Grade Point")) %>%
      hc_colors(cols[2]) %>%
      hc_title(text="<b>A Level Grade Point</b>") %>%
      hc_tooltip(crosshairs=TRUE)
  })
  
  
  output$hc21 = renderHighchart({
    highchart() %>%
      hc_chart(type="line") %>%
      hc_xAxis(categories = filtered_data_grade_ntu()$Year.Intake, reversed=TRUE) %>%
      hc_add_series(filtered_data_grade_ntu()$CGPA, name="Diploma CGPA") %>%
      hc_yAxis(title=list(text="CGPA")) %>%
      hc_colors(cols[2]) %>%
      hc_title(text="<b>Diploma CGPA</b>") %>%
      hc_tooltip(crosshairs=TRUE)
  })
  
  
  output$table8 = renderReactable({
    reactable(filtered_data_grade_ntu() %>% select(c("Year.Intake","A.Level", "A.Level.Points", "CGPA")), compact = TRUE, striped = TRUE, borderless = TRUE)
  })
  
  
  filtered_data_grade_smu = reactive({
    grades_data_smu %>% filter(School == input$smu_school_grade_Input) %>% filter(Faculty == input$smu_faculty_grade_Input)
  })
  
  
  output$hc22 = renderHighchart({
    highchart() %>%
      hc_chart(type="line") %>%
      hc_xAxis(categories = filtered_data_grade_smu()$Year.Intake, reversed=TRUE) %>%
      hc_add_series(filtered_data_grade_smu()$A.Level.Points, name="A Level Grade Point") %>%
      hc_yAxis(title=list(text="Grade Point")) %>%
      hc_colors(cols[3]) %>%
      hc_title(text="<b>A Level Grade Point</b>") %>%
      hc_tooltip(crosshairs=TRUE)
  })
  
  
  output$hc23 = renderHighchart({
    highchart() %>%
      hc_chart(type="line") %>%
      hc_xAxis(categories = filtered_data_grade_smu()$Year.Intake, reversed=TRUE) %>%
      hc_add_series(filtered_data_grade_smu()$CGPA, name="Diploma CGPA") %>%
      hc_yAxis(title=list(text="CGPA")) %>%
      hc_colors(cols[3]) %>%
      hc_title(text="<b>Diploma CGPA</b>") %>%
      hc_tooltip(crosshairs=TRUE)
  })
  
  
  output$table9 = renderReactable({
    reactable(filtered_data_grade_smu() %>% select(c("Year.Intake","A.Level", "A.Level.Points", "CGPA")), compact = TRUE, striped = TRUE, borderless = TRUE)
  })
  
})
