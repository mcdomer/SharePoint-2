$siteurl = $args[0]
$itemid = $args[1]
$likescount = $args[2]

$spWeb = Get-SPWeb -Identity $siteurl #https://inseewisdom.siamcitycement.com/sites/library
$spList = $spWeb.Lists["Inventory"]
$spItem = $spList.GetItemById($itemid) #or another way that you prefer.
$spItem["LikesCount"] = $likescount
$spItem.Update()