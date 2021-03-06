
#' let dropbox untrack `Rproj user` folder
#' Solve Dropbox conflicts with `Rproj.user`
#' revised base on:
#' https://community.rstudio.com/t/dropbox-conflicts-with-rproj-user/54059
#'
#' @importFrom usethis proj_get
#' @return NULL
#' @export dropbox_project_sync_off
dropbox_project_sync_off <- function() {
  this_project <- usethis::proj_get()

  if (grep("Dropbox", this_project) == 0) {warning("This project is not in a Dropbox folder")}

  dir_to_block <- normalizePath(file.path(this_project,"/.Rproj.user"))
  file_to_block <- normalizePath(list.files(this_project, pattern = ".Rproj", full.names = TRUE))

  # Powershell command examples:
  # These set flags to prevent syncing
  # Set-Content -Path C:\Users\myname\Dropbox\mywork\test\test.Rproj -Stream com.dropbox.ignored -Value 1
  # Set-Content -Path C:\Users\myname\Dropbox\mywork\test\.Rproj.user -Stream com.dropbox.ignored -Value 1

  s1 <- paste0('powershell -Command \"& {Set-Content -Path ', file_to_block, ' -Stream com.dropbox.ignored -Value 1}\"')
  s2 <- paste0('powershell -Command \"& {Set-Content -Path ', dir_to_block, ' -Stream com.dropbox.ignored -Value 1}\"')

  shell(s1)
  shell(s2)
}


