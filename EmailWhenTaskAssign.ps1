
$web=Get-SPWeb $args[0] #https://inseewisdom.siamcitycement.com/sites/inseecommunity/ictest10
$list=$web.Lists.TryGetList("Activities")
if($list -ne $null)
{
   $list.EnableAssignToEmail =$true
   $list.Update()
}