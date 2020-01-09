- dashboard: sys_act_performance_dashboard
  title: Sys Act Performance Dashboard
  layout: newspaper
  elements:
  - name: ''
    type: text
    title_text: ''
    body_text: "<center>\n<p class=\"alert alert-success\" role=\"alert\"> \n<font\
      \  color=\"navy\">Queries Per Source</font>\n</p></center>\n\nThis tells us\
      \ the bulk of the usage comes from. \n\nSource = Biggest chunk of usage\nHourly\
      \ = get more granular\n\nWe are looking for bunched schedules, PDT rebuilds\
      \ etc that can tell us when and what is causing system bottlenecks"
    row: 0
    col: 0
    width: 13
    height: 6
  - name: ''
    type: text
    body_text: "<center><p class=\"alert alert-success\" role=\"alert\"> \n<font color=\"\
      navy\">Dashboard Refresh and Downloads</font>\n</p></center>\nDashboards with\
      \ a refresh interval are best used in a privately embedded context where live\
      \ data is streaming or being displayed on a scren for live updates. Refresh\
      \ intervals miss the query cache by default, meaning you may be running queries\
      \ unnecessarily against your database. Consider turning Auto Refresh off to\
      \ save on query cost.\n<ul>\n<li><a href=\"https://docs.looker.com/dashboards/editing-user-dashboards#auto_refresh\"\
      >Dashboard Refresh Inteval</li>\n</ul>\n<br>\n<br>\n<br><br>\n<br>\n<br>"
    row: 23
    col: 0
    width: 13
    height: 7
  - title: Scheduled jobs by source
    name: Scheduled jobs by source
    model: system__activity
    explore: scheduled_plan
    type: looker_line
    fields: [scheduled_job.created_date, source, scheduled_job.count]
    pivots: [source]
    fill_fields: [scheduled_job.created_date]
    filters:
      scheduled_plan.run_once: 'no'
      scheduled_job.created_date: 14 days
    sorts: [scheduled_job.created_date desc, source]
    limit: 500
    dynamic_fields: [{dimension: source, label: Source, expression: "if(NOT is_null(${scheduled_job.look_id}),\
          \ \"look\",\n  if(NOT is_null(${scheduled_job.dashboard_id}),\"dashboard\"\
          ,\"other\"\n    )\n  )", value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: string}]
    query_timezone: UTC
    color_application:
      collection_id: b6347139-8179-43dd-9c1b-edf08aba97e0
      palette_id: 64711cb9-7c31-47af-ab1a-7772bc773b5f
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    listen: {}
    row: 41
    col: 13
    width: 11
    height: 8
  - title: Unlimited Downloads
    name: Unlimited Downloads
    model: system__activity
    explore: history
    type: table
    fields: [history.created_time, query.link, user.id, user.name, query.limit]
    filters:
      query.limit: "%-1%"
    sorts: [history.created_time desc]
    limit: 500
    column_limit: 50
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    listen: {}
    row: 30
    col: 13
    width: 11
    height: 6
  - title: dashboard with refresh interval
    name: dashboard with refresh interval
    model: system__activity
    explore: history
    type: table
    fields: [dashboard.title, history.real_dash_id, dashboard.refresh_interval]
    filters:
      dashboard.refresh_interval: "-NULL"
    sorts: [dashboard.refresh_interval desc]
    limit: 50
    show_view_names: true
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting: [{type: low to high, value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"]}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen: {}
    row: 30
    col: 0
    width: 13
    height: 6
  - title: query per user -hourly today
    name: query per user -hourly today
    model: system__activity
    explore: history
    type: table
    fields: [history.query_run_count, user.name, history.created_hour_of_day]
    pivots: [history.created_hour_of_day]
    fill_fields: [history.created_hour_of_day]
    filters:
      history.created_date: 1 days
    sorts: [user.name 0, history.created_hour_of_day]
    limit: 500
    dynamic_fields: [{table_calculation: name, label: Name, expression: 'if(is_null(${user.name}),
          "PDT Regenerator", ${user.name})', value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: string}]
    show_view_names: true
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"]}, bold: false, italic: false, strikethrough: false,
        fields: [history.query_run_count], color_application: {collection_id: legacy,
          custom: {id: 4843ba73-6e60-e9d2-a6b6-750160e2cf50, label: Custom, type: continuous,
            stops: [{color: "#F36254", offset: 0}, {color: "#FCF758", offset: 50},
              {color: "#4FBC89", offset: 100}]}, options: {steps: 5, reverse: true}}}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [user.name]
    listen: {}
    row: 6
    col: 13
    width: 11
    height: 8
  - title: query per user -daily last 7days
    name: query per user -daily last 7days
    model: system__activity
    explore: history
    type: looker_grid
    fields: [history.query_run_count, user.name, history.created_day_of_week]
    pivots: [history.created_day_of_week]
    fill_fields: [history.created_day_of_week]
    filters:
      history.created_date: 7 days
    sorts: [user.name 0, history.created_day_of_week]
    limit: 500
    dynamic_fields: [{table_calculation: name, label: Name, expression: 'if(is_null(${user.name}),
          "PDT Regenerator", ${user.name})', value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: string}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    series_cell_visualizations:
      history.query_run_count:
        is_active: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"]}, bold: false, italic: false, strikethrough: false,
        fields: !!null '', color_application: {collection_id: legacy, custom: {id: 7988f312-ac63-66b7-89a9-36b8df3117f5,
            label: Custom, type: continuous, stops: [{color: "#f23737", offset: 0},
              {color: "#FCF758", offset: 50}, {color: "#4FBC89", offset: 100}]}, options: {
            steps: 5, reverse: true}}}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    truncate_column_names: false
    hidden_fields: [user.name]
    series_types: {}
    listen: {}
    row: 14
    col: 12
    width: 12
    height: 9
  - title: query per source -hourly today
    name: query per source -hourly today
    model: system__activity
    explore: history
    type: table
    fields: [history.query_run_count, history.source, history.created_hour_of_day]
    pivots: [history.source]
    fill_fields: [history.created_hour_of_day]
    filters:
      history.created_date: 1 days
    sorts: [history.source 0, history.created_hour_of_day]
    limit: 500
    show_view_names: true
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"]}, bold: false, italic: false, strikethrough: false,
        fields: [history.query_run_count], color_application: {collection_id: legacy,
          custom: {id: 2120bd97-6bf2-0ed4-e64f-9959eccf6cc2, label: Custom, type: continuous,
            stops: [{color: "#F36254", offset: 0}, {color: "#FCF758", offset: 50},
              {color: "#4FBC89", offset: 100}]}, options: {steps: 5, reverse: true}}}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen: {}
    row: 14
    col: 0
    width: 12
    height: 9
  - title: query per source -daily last 7days
    name: query per source -daily last 7days
    model: system__activity
    explore: history
    type: table
    fields: [history.query_run_count, history.source, history.created_day_of_week]
    pivots: [history.source]
    fill_fields: [history.created_day_of_week]
    filters:
      history.created_date: 7 days
    sorts: [history.source 0, history.created_day_of_week]
    limit: 500
    show_view_names: true
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"]}, bold: false, italic: false, strikethrough: false,
        fields: !!null '', color_application: {collection_id: legacy, custom: {id: 35adb615-92f6-1be9-0c85-5f578df91827,
            label: Custom, type: continuous, stops: [{color: "#F36254", offset: 0},
              {color: "#FCF758", offset: 50}, {color: "#4FBC89", offset: 100}]}, options: {
            steps: 5, reverse: true}}}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen: {}
    row: 6
    col: 0
    width: 13
    height: 8
  - title: Content Recommended for Deletion. No accessed in > 90 Days, Not scheduled
    name: Content Recommended for Deletion. No accessed in > 90 Days, Not scheduled
    model: system__activity
    explore: content_usage
    type: table
    fields: [content_usage.content_id, content_usage.embed_total, content_usage.favorites_total,
      content_usage.schedule_total, content_usage.other_total, content_usage.content_title,
      content_usage.content_type, content_usage.last_accessed_date, content_usage.schedule_count]
    filters:
      content_usage.days_since_last_accessed: ">90"
      content_usage.schedule_count: '0'
    sorts: [content_usage.other_total desc]
    limit: 1000
    dynamic_fields: [{table_calculation: content_title, label: Content Title, expression: 'concat(coalesce(${dashboard.title},
          ""), coalesce(${look.title}, ""))', value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: string, is_disabled: true}]
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting: [{type: low to high, value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: White to Green, colors: ["#FFFFFF",
            "#4FBC89"]}, bold: false, italic: false, strikethrough: false, fields: []},
      {type: low to high, value: !!null '', background_color: !!null '', font_color: !!null '',
        palette: {name: White to Green, colors: ["#FFFFFF", "#4FBC89"]}, bold: false,
        italic: false, strikethrough: false, fields: []}, {type: low to high, value: !!null '',
        background_color: !!null '', font_color: !!null '', palette: {name: White
            to Green, colors: ["#FFFFFF", "#4FBC89"]}, bold: false, italic: false,
        strikethrough: false, fields: []}, {type: low to high, value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: White to Green, colors: ["#FFFFFF",
            "#4FBC89"]}, bold: false, italic: false, strikethrough: false, fields: []},
      {type: low to high, value: !!null '', background_color: !!null '', font_color: !!null '',
        palette: {name: White to Green, colors: ["#FFFFFF", "#4FBC89"]}, bold: false,
        italic: false, strikethrough: false, fields: []}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [content_usage.content_id]
    note_state: collapsed
    note_display: hover
    note_text: All time counts for content that have been accessed within the last
      30 days.
    y_axes: []
    listen: {}
    row: 84
    col: 0
    width: 13
    height: 7
  - title: Dashboards With > 25 Elements
    name: Dashboards With > 25 Elements
    model: system__activity
    explore: dashboard
    type: looker_grid
    fields: [dashboard.id, dashboard.link, dashboard_element.count, query.count_of_explores,
      dashboard_element.count_text]
    filters:
      dashboard_element.count: ">25"
      dashboard.deleted_date: 'NULL'
      dashboard_element.type: "-text"
    sorts: [element_count_without_text desc]
    limit: 500
    dynamic_fields: [{table_calculation: element_count_without_text, label: Element
          count (Without Text), expression: "${dashboard_element.count} - ${dashboard_element.count_text}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/New_York
    hidden_fields: [dashboard_element.count_text]
    y_axes: []
    series_types: {}
    listen: {}
    row: 84
    col: 13
    width: 11
    height: 7
  - title: Explores not Queried in > 60 Days
    name: Explores not Queried in > 60 Days
    model: system__activity
    explore: history
    type: looker_grid
    fields: [history.count, history.most_recent_query_date, query.view]
    filters:
      history.most_recent_query_date: before 60 days ago
    sorts: [history.count desc]
    limit: 500
    query_timezone: UTC
    hidden_fields: []
    y_axes: []
    series_types: {}
    listen: {}
    row: 56
    col: 13
    width: 11
    height: 8
  - title: Failed Schedules
    name: Failed Schedules
    model: system__activity
    explore: scheduled_plan
    type: table
    fields: [scheduled_job.status_detail, look.title, dashboard.title, scheduled_job.count]
    filters:
      scheduled_job.status: failure
    sorts: [scheduled_job.count desc]
    limit: 500
    dynamic_fields: [{table_calculation: content_name, label: Content Name, expression: "if(is_null(${look.title}),\
          \ \n  concat(\"Dashboard title:  \", ${dashboard.title}),\n  concat(\"Look\
          \ title:  \", ${look.title})\n  )", value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: string}]
    query_timezone: UTC
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: [look.title, dashboard.title]
    y_axes: []
    listen: {}
    row: 41
    col: 0
    width: 13
    height: 8
  - title: Most Used Explores
    name: Most Used Explores
    model: system__activity
    explore: history
    type: looker_grid
    fields: [query.view, query.model, user.count, history.query_run_count, history.average_runtime]
    filters:
      history.source: Explore
    sorts: [history.query_run_count desc, query.model 0]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    series_labels:
      user.count: User Count
    series_cell_visualizations:
      history.query_run_count:
        is_active: false
        palette:
          palette_id: 04aea65e-1372-4c50-ae0e-e1687bfdf103
          collection_id: 0a5cba20-3b6e-4739-b9e3-ba1d442d992d
      user.count:
        is_active: false
      history.average_runtime:
        is_active: false
        palette:
          palette_id: 56b9d528-ab62-436e-a74d-7a44fc9d45c7
          collection_id: 0a5cba20-3b6e-4739-b9e3-ba1d442d992d
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#2196F3",
        font_color: !!null '', color_application: {collection_id: 0a5cba20-3b6e-4739-b9e3-ba1d442d992d,
          palette_id: 56b9d528-ab62-436e-a74d-7a44fc9d45c7, options: {steps: 5}},
        bold: false, italic: false, strikethrough: false, fields: [user.count]}, {
        type: along a scale..., value: !!null '', background_color: "#2196F3", font_color: !!null '',
        color_application: {collection_id: 0a5cba20-3b6e-4739-b9e3-ba1d442d992d, palette_id: 56b9d528-ab62-436e-a74d-7a44fc9d45c7,
          options: {steps: 5}}, bold: false, italic: false, strikethrough: false,
        fields: [history.query_run_count]}, {type: along a scale..., value: !!null '',
        background_color: "#2196F3", font_color: !!null '', color_application: {collection_id: 0a5cba20-3b6e-4739-b9e3-ba1d442d992d,
          palette_id: 56b9d528-ab62-436e-a74d-7a44fc9d45c7, options: {steps: 5}},
        bold: false, italic: false, strikethrough: false, fields: [history.average_runtime]}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    truncate_column_names: false
    hidden_fields: []
    y_axes: []
    series_types: {}
    listen: {}
    row: 56
    col: 0
    width: 13
    height: 8
  - name: ''
    type: text
    body_text: "<center>\n<p class=\"alert alert-success\" role=\"alert\"> \n<font\
      \ color=\"navy\">Explores</font>\n</p></center>\n<center><b>Your most popular\
      \ Explores</b></center><br>\nYour most frequently used explores are those which\
      \ you may need to apply some optimisation best practises. Consider removing\
      \ explroe definitions that are rarely queried. Be sure to run the content validator\
      \ after making any changes to ensure all content is working as expected.\n\n\
      <ul>\n<li> <a href=\"https://help.looker.com/hc/en-us/articles/360001847227-Best-Practice-Optimize-Looker-Performance\"\
      > Optimise your Explores</li>\n<li> <a href=\"https://docs.looker.com/data-modeling/getting-started/look-validation#using_the_content_validator_to_fix_errors\"\
      >The Content Validator</li></ul>\n<br>\n<br>\n<br>\n<br>"
    row: 49
    col: 0
    width: 13
    height: 7
  - name: ''
    type: text
    body_text: "<center>\n<p class=\"alert alert-success\" role=\"alert\"> \n<font\
      \  color=\"navy\">Persisted Derived Tables</font>\n</p></center>\n<center><b>Failing\
      \ PDT Builds</b></center><br>\nPersisted derived tables can fail for many reasons;\
      \ Incorret SQL Syntax, Trigger Failure or incorrect use of CTE's.\n<li><a href=\"\
      https://docs.looker.com/data-modeling/learning-lookml/derived-tables#monitoring_and_troubleshooting_persistent_derived_tables\"\
      >Troubleshooting Derived Tables</a></li>\n<li><a href=\"https://docs.looker.com/admin-options/database/pdts#using_the_pdt_panel\"\
      >Using the PDT Panel</a></li>\n<li><a href=\"https://docs.looker.com/admin-options/database/queries\"\
      >Troubleshooting Queries</a></li>\n<br>\n<br>\n<br>\n<br>\n<br>"
    row: 64
    col: 0
    width: 13
    height: 6
  - title: Long Running PDT Builds
    name: Long Running PDT Builds
    model: system__activity
    explore: history
    type: looker_grid
    fields: [history.source, history.created_time, history.connection_name, history.total_runtime,
      history.message]
    filters:
      history.created_date: 24 hours
      user.name: 'NULL'
      history.message: "%Building derived Table%"
    sorts: [history.total_runtime desc]
    limit: 500
    hidden_fields: [history.source]
    series_types: {}
    listen: {}
    row: 70
    col: 13
    width: 11
    height: 8
  - name: ''
    type: text
    body_text: "<center>\n<p class=\"alert alert-success\" role=\"alert\"> \n<font\
      \  color=\"navy\">Unlimited Downloads</font>\n</p></center>\nUnlimited Downloads\
      \ pose a threat to the health of your Looker instance. When queries with > 50,00\
      \ are stored in memory (cache) they consume a lot of space on the server and\
      \ can potentially cause an outage as well as crashing your browser when trying\
      \ to render the data. Looker imposes row limits bu default. The rules of thumb\
      \ are:\n<li>If being displayed in the browser, the limit is 5000\n<li>If results\
      \ are being exported from Looker, users can choose to export All Results as\
      \ long as the results stream.\n<br>\nIf you have table calculations or row totals,\
      \ consider downloading with a Custom Limit to export.\n<br>\n<li><a href=\"\
      https://help.looker.com/hc/en-us/articles/360001285567-What-are-all-the-Row-Limits-in-Looker-\"\
      >Row Limits in Looker</a></li>\n<li><a href=\"https://docs.looker.com/sharing-and-publishing/downloading\"\
      >Downloading and Streaming Data</a></li>"
    row: 23
    col: 13
    width: 11
    height: 7
  - title: Failing PDT Builds
    name: Failing PDT Builds
    model: system__activity
    explore: pdt_event_log
    type: table
    fields: [pdt_event_log.view_name, pdt_event_log.connection, pdt_event_log.pdt_create_failures,
      pdt_event_log.pdt_trigger_failures, pdt_event_log.successful_pdt_builds]
    filters:
      pdt_event_log.view_name: "-NULL"
      pdt_event_log.created_date: 7 days
    sorts: [pdt_event_log.pdt_create_failures desc]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      pdt_event_log.pdt_create_failures: Create Failures
      pdt_event_log.pdt_trigger_failures: Trigger Failures
      pdt_event_log.successful_pdt_builds: Successful Builds
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting: [{type: greater than, value: 0, background_color: !!null '',
        font_color: red, palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"]}, bold: false, italic: false, strikethrough: false,
        fields: [pdt_event_log.pdt_create_failures, pdt_event_log.pdt_trigger_failures]},
      {type: greater than, value: 0, background_color: !!null '', font_color: green,
        palette: {name: Red to Yellow to Green, colors: ["#F36254", "#FCF758", "#4FBC89"]},
        bold: false, italic: false, strikethrough: false, fields: [pdt_event_log.successful_pdt_builds]}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen: {}
    row: 70
    col: 0
    width: 13
    height: 8
  - name: ''
    type: text
    body_text: "<center>\n<p class=\"alert alert-success\" role=\"alert\"> \n<font\
      \  color=\"navy\">Persisted Derived Tables</font>\n</p></center>\n<center><b>Long\
      \ Running Derive Table Builds</b></center><br>\nLong-running (P)DT builds can\
      \ cause a query backlog in your database as looker can only write one table\
      \ at a time. Consider checking whether indexes have been defined on the table,\
      \ whether it has a primary key, whether there are cross joins or date transformation\
      \ in the ON clause or any other operation that may be costly. \n<li> When builds\
      \ take > 1 hour, consider moving it to the ETL process</li>\n<li><a href=\"\
      https://docs.looker.com/data-modeling/learning-lookml/derived-tables\">Using\
      \ Derived Tables</a></li>\n<li><a href=\"https://help.looker.com/hc/en-us/articles/360001847227-Best-Practice-Optimize-Looker-Performance\"\
      >Optomize Query Performance</a></li>"
    row: 64
    col: 13
    width: 11
    height: 6
  - name: ''
    type: text
    body_text: "<center>\n<p class=\"alert alert-success\" role=\"alert\"> \n<font\
      \  color=\"navy\">Explores</font>\n</p></center>\n<center><b>Explores that have\
      \ not been queried in 60 days</b></center><br>\nExplores that have not been\
      \ queried in > 60 days may be good candidates for removal. Top Tip: Comment\
      \ out explore definitions and run the content validator to see if this affects\
      \ any dashboards or looks. Explores with a large history run count mean that\
      \ they are/have been used for analytical purposes and possibly schedules. Contact\
      \ the key stakeholder for the business unit the explore belongs to and ask if\
      \ it is required or can be joined to another explore. \n\n<li><a href=\"https://help.looker.com/hc/en-us/articles/360001766908-Best-Practice-Create-a-Positive-Experience-for-Looker-Users\"\
      >Reducing Model Bloat</a></li>\n<li> <a href=\"https://docs.looker.com/data-modeling/getting-started/look-validation#using_the_content_validator_to_fix_errors\"\
      >The Content Validator</li>"
    row: 49
    col: 13
    width: 11
    height: 7
  - name: ''
    type: text
    body_text: "<center>\n<p class=\"alert alert-success\" role=\"alert\"> \n<font\
      \  color=\"navy\">Content</font>\n</p></center>\n<center><b>Content Recommended\
      \ for Deletion</b></center><br>\nThe dashboards and looks listed here have not\
      \ been opened in > 90 days and are also not scheduled for delivery. They may\
      \ not be business critical and are recommended for removal. Remember, and admin\
      \ can always retrieve them from the trash.\n<li><a href=\"https://discourse.looker.com/t/considerations-when-building-performant-looker-dashboards/3370?version=6.24\"\
      >Building Performant Dashboards</a></li>\n<li><a href=\"https://docs.looker.com/sharing-and-publishing/admin-spaces#trash\"\
      >Retrieving content from trash</a></li>"
    row: 78
    col: 0
    width: 13
    height: 6
  - name: ''
    type: text
    body_text: "<center>\n<p class=\"alert alert-success\" role=\"alert\"> \n<font\
      \  color=\"navy\">Content</font>\n</p></center>\n<center><b>Dashboards with\
      \ > 25 Tiles</b></center><br>\nThe dashboards and looks listed here have not\
      \ been opened in > 90 days and are also not scheduled for delivery. They may\
      \ not be business critical and are recommended for removal. Remember, and admin\
      \ can always retrieve them from the trash.\n<li><a href=\"https://discourse.looker.com/t/considerations-when-building-performant-looker-dashboards/3370?version=6.24\"\
      >Building Performant Dashboards</a></li>\n<li><a href=\"https://docs.looker.com/sharing-and-publishing/admin-spaces#trash\"\
      >Retrieving content from trash</a></li>"
    row: 78
    col: 13
    width: 11
    height: 6
  - name: ''
    type: text
    body_text: "<center>\n<p class=\"alert alert-success\" role=\"alert\"> \n<font\
      \  color=\"navy\">Queries Per User</font>\n</p></center>\n\nThis tells us the\
      \ bulk of the usage comes from. \n\nSource = Biggest chunk of usage\nHourly\
      \ = get more granular\n\nWe are looking for unusual query pattens that can tell\
      \ us when and what is causing system bottlenecks"
    row: 0
    col: 13
    width: 11
    height: 6
  - name: ''
    type: text
    body_text: "<center>\n<p class=\"alert alert-success\" role=\"alert\"> \n<font\
      \ color=\"navy\">Schedules</font>\n</p></center>\nSchedules that are bunched\
      \ together pose a threat to the health of your Looker instance. When there are\
      \ many schedules happening concurrently at similar hour on the same day, consider\
      \ the level of stress this can place on your database and how this will affect\
      \ the query queue and cost. \n<li>Consider running your schedules from a datagroup\
      \ tied to your ETL process  \n<li> Space schedules out to 15 minutes intervals\n\
      <br>"
    row: 36
    col: 0
    width: 24
    height: 5
