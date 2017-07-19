# Change List Schema to unhide order field.
$siteUrl = $args[0];    #"https://inseewisdom.siamcitycement.com";
$listTitle = $args[1];  #"IDCSession";

$site = Get-SPSite -Identity $siteUrl;
$web = $site.OpenWeb();
$list = $web.Lists[$listTitle];
$field=$list.Fields["Order"];
$field.SchemaXml = $field.SchemaXml.Replace("Hidden=""TRUE""","Hidden=""FALSE""");
Write-Host "-------------------------------------"
Write-Host "Order field is set to visible in
list :  " $list.Title -foregroundcolor Green -nonewline
Write-Host " in the site  : " $site.Url -foregroundcolor Green
Write-Host "-------------------------------------"
$web.Dispose();
$site.Dispose();