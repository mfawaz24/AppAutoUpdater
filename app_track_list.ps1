$track_list = @(
    "https://api.github.com/repos/Eugeny/tabby/releases/latest",
    "https://api.github.com/repos/ungoogled-software/ungoogled-chromium-windows/releases/latest"
)

# Set location of where you have the other script
$work_script_location = "C:\Users\USERNAME\Documents\test.ps1"

# Don't touch anything below this line.
####################
####################
####################

foreach ($project in $track_list) {
    & $work_script_location $project
}

Read-Host -Prompt "Press Enter to exit"