$track_list = @(
    # "https://api.github.com/repos/Eugeny/tabby/releases/latest",
    # "https://api.github.com/repos/ungoogled-software/ungoogled-chromium-windows/releases/latest"
)

# Set location of where you have the other script
$work_script_location = "C:\Users\USERNAME\Documents\work_script.ps1"






# Leave everything below this line.
####################
####################
####################

foreach ($project in $track_list) {
    & $work_script_location $project
}