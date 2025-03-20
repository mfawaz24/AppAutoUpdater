# AppAutoUpdater
Similar to Obtainium, but for Windows. Use this to enable automatic updates for software releases from GitHub which don't automatically update by themselves 

# How to Use
* Download both .ps1 scripts.
* Add GitHub repo releases for software you want to automatically update to ```config.ps1```
* Set the ```work_script.ps1``` location in ```config.ps1```
* Set update frequency:
* * To install latest version with every startup of the PC, place the ```config.ps1``` in the _startup_ folder
* * * ```%AppData%\Microsoft\Windows\Start Menu\Programs\Startup``` for all users or ```%USERPROFILE%\Desktop\``` for a single user
* * If you want a more specific schedule, use Windows Scheduler
