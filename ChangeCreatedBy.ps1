$url = "https://inseewisdom.siamcitycement.com/"
$listName = "KnowledgeAssets"
$itemID = "";
 
#Get the appropriate list from the web
$web = get-SPWeb $url
$list = $web.lists[$listName]
 
#Get the file using the filename
$item = $list.Items | ? {$_.ID -eq $itemID}
 
#Print out current Created by and Created date
Write-Output ("item created by {0} on {1}" -f $item["Author"].tostring(), $item["Created"] )
 
#Print out current Created by and Created date
Write-Output ("item last modified by {0} on {1}" -f $item["Editor"].tostring(), ($item["Modified"] -f "dd-MM-yyyy"))
 
#Set the created by values
$userLogin = "ap\weeracha"
$dateToStore = Get-Date "10/02/1984"
 
$user = $web.EnsureUser($userLogin) #$user = Get-SPUser -Web $web | ? {$_.userlogin -eq $userLogin}
$userString = "{0};#{1}" -f $user.ID, $user.UserLogin.Tostring()
 
 
#Sets the created by field
$item["Author"] = $userString
$item["Created"] = $dateToStore
 
#Set the modified by values
$item["Editor"] = $userString
$item["Modified"] = $dateToStore
 
 
#Store changes without overwriting the existing Modified details.
$item.UpdateOverwriteVersion()