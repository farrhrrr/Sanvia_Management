print("=== STARTING TEST APP ===")
print(Sys.getenv(c("PORT", "DB_HOST", "DB_NAME", "DB_USER", "DB_PASSWORD")))

library(shiny)
ui <- fluidPage(h2("✅ Shiny berhasil jalan"))
server <- function(input, output, session) {}
shinyApp(ui, server)
