$siteurl = $args[0]
$itemid = $args[1]
$likescount = $args[2]

$spWeb = Get-SPWeb -Identity $siteurl #<site>
$spList = $spWeb.Lists["<list>"]
$spItem = $spList.GetItemById($itemid) #or another way that you prefer.
$spItem["LikesCount"] = $likescount
$spItem.Update()