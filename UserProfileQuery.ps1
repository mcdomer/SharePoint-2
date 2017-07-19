$mySiteUrl = $args[0] #"<site>"

#Get site objects and connect to User Profile Manager service
$site = Get-SPSite $mySiteUrl
$context = Get-SPServiceContext $site
$profileManager = New-Object Microsoft.Office.Server.UserProfiles.UserProfileManager($context)

$profiles = $profileManager.GetEnumerator()

#foreach ($up in $profiles) {$up["scccempfunction"]}
#$profiles | where { $_["scccempfunction"] -like "*Saraburi*"}