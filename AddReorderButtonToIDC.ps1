
# Add "Change item Order" button at target List
$siteUrl = "<site>";
$listTitle = "IDCSession";
$site = Get-SPSite -Identity $siteUrl;
$web = $site.OpenWeb();
$list = $web.Lists[$listTitle];
$list.UserCustomActions.Clear();
$action = $list.UserCustomActions.Add();
$action.Location = "CommandUI.Ribbon";
$action.Sequence = 85;
$action.Title = "PS.OrderItems";
$action.CommandUIExtension =
[string]::Format(
"<CommandUIExtension>
<CommandUIDefinitions>
<CommandUIDefinition
  Location=""Ribbon.ListItem.Actions.Controls._children"">
<Button Id=""ReOrderAction.Button"" TemplateAlias=""o1""
  Command=""ReOrderCommand"" CommandType=""General""
  LabelText=""Change Item Order""
Image16by16=""/_layouts/1033/images/formatmap16x16.png""
  Image16by16Top=""-192"" Image16by16Left=""-144""
Image32by32=""/_layouts/1033/images/formatmap32x32.png""
  Image32by32Top=""-192"" Image32by32Left=""-288""/>
</CommandUIDefinition>
</CommandUIDefinitions>
  <CommandUIHandlers>
<CommandUIHandler Command =""ReOrderCommand""
  CommandAction=""{0}/_layouts/reorder.aspx?List={1}"" />
</CommandUIHandlers>
 </CommandUIExtension>",
$web.ServerRelativeUrl.TrimEnd('/'), $list.ID);
$action.Update();
$view = $list.DefaultView;
$view.Query = [string]::Format("<OrderBy><FieldRef Name=""Order""
Ascending=""TRUE""/></OrderBy>");
$view.Update();
Write-Host "-------------------------------------"
Write-Host "Change item order button added successfully for
the list :  " $list.Title -foregroundcolor Green -nonewline
Write-Host " in the site  : " $site.Url -foregroundcolor Green
Write-Host "-------------------------------------"
$web.Dispose();
$site.Dispose();