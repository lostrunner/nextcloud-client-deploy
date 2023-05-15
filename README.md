# nextcloud-client-deploy
Deploy nextcloud client in windows env with right user and server + folder sync.
This script in batch can be used as a basic template to deploy in AD environment the nextcloud client. A very versatile tool for sync, backup or file sharing based on webdav.

The template presented above can be tweaked for folder sync, deploy an app, backup, etc.
I will describe the actions for those who are not familiar with the commands.

* First it prints a message to any user logged on to notifiy start of the instalation.
* Second the script ends any nextcloud client, if started.
* Then it will search under https://download.nextcloud.com/desktop/releases/Windows/ for the last stable nextcloud client that will be downloaded.
* Installation is started silently for all users. (Program Files will be used as path and a shortcut of nextcloud will be created on desktop for all users). 
* After installation the downloaded file is deleted.
* The template is acting as deploy/update for an app and it searches for all users that are non default(like Administrator, localadmin, Public). For each user a folder of the app is created, a shortcut on the Desktop and in /AppData/Roaming/Nextcloud a config file that will take the username found locally with the path to app folder and write them in the file. (the script assumes the local user is the same as the cloud user in AD/Ldap nextcloud environments. At the same time, because I use the script with groups in AD and the info for acces gets updated with delay, I will also download the app from cloud and extract the archive to the folder, so that the app will be availible right away.
* After writing all the info to the file the script will delete the downloaded content and print the message to notify the logged user.
* It is necessary for the user to complete the nextcloud login via web by pressing the login button in the app.
* After login the nextcloud app needs to be closed by exit form the taskbar and reopen to load proper configuration.

Nextcloud is a great tool that can be used in different scenarios depending of the needs.
Take the script and adapt it to your needs.

These days you can ask ChatGPT to rewrite it based on your scenarios, for those who are not expert with batch scripts.
Good luck !!!
