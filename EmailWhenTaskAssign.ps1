
$web=Get-SPWeb $args[0] #<site>
$list=$web.Lists.TryGetList("Activities")
if($list -ne $null)
{
   $list.EnableAssignToEmail =$true
   $list.Update()
}