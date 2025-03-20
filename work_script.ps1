$project_url = $args[0]

$latest = (Invoke-RestMethod -Uri $project_url)

# $data = $latest | ConvertFrom-Json
$data = $latest

$asset_matches = @()

# Iterate through the list of fruits
foreach ($asset in $data.assets) {
    # Check if the asset title contains "x64" and "installer"
    $asset_url_string = [string]$asset.browser_download_url
    $asset_file_extension = $asset_url_string.Substring($asset.browser_download_url.Length - 4)
    if ($asset_file_extension -eq ".exe" -or $asset_file_extension -eq ".msi") {
        if ($asset -match "x64") { # -and $asset -match "installer") {
            $asset_matches += $asset.browser_download_url
            Write-Output "Valid install file found:"
            Write-Output $asset.browser_download_url    
        }
    }


}

$valid_asset_count = $false

# Output the matches or "none found"
if ($asset_matches.Count -gt 1) {
    $asset_matches | ForEach-Object { Write-Output "too many valid install files found, Match found: $_" }
} elseif ($asset_matches.Count -eq 0) {
    Write-Output "none found"
} elseif ($asset_matches.Count -eq 1) {
    $valid_asset_count = $true
} else {
    Write-Output "this should not happen"
}

if (-not $valid_asset_count) {
    Write-Output "Script stopped because `$valid is false."
    exit  # Stop the script
}

# ungoogled-chromium_installer_x64
$installer_download_url = [string]$asset_matches[0] 
$install_file_extension = $installer_download_url.Substring($installer_download_url.Length - 4)

$outputFile = "$env:TEMP\" + "temp_installer" + $install_file_extension

# Download the file
Write-Output "Downloading installer..."
Invoke-WebRequest -Uri $installer_download_url -OutFile $outputFile

# Install the file (assuming it's an executable installer)
try {
    $process = Start-Process -FilePath $outputFile -ArgumentList "/silent" -Wait -PassThru -ErrorAction Stop

    if ($process.ExitCode -eq 0) {
        Write-Output "Process completed successfully."
    } else {
        Write-Output "Process failed with exit code: $($process.ExitCode)"
    }

    Remove-Item -Path $outputFile -Force
    Write-Output "Temporary file removed."


} catch {
    Write-Output "Failed to start process: $_"
}