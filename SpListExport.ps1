Add-PSSnapin Microsoft.SharePoint.PowerShell –ErrorAction SilentlyContinue
  
#Variables
$SiteUrl="http://eoffice-edoc.si.mahidol.ac.th/edoc"
$OutPutFile = "C:\Scripts\Export\ExList.csv"
  
#Get Web and User Information List
$web = Get-SPWeb $SiteUrl
$list = $web.Lists["QualityDocMgt"]
Write-host "Total Number of Items Found:"$list.Itemcount
 
#Array to Hold Result - PSObjects
$ListItemCollection = @()
   
 #Get All List items where Status is "In Progress"
 $list.Items | foreach {
 write-host "Processing Item ID:"$_["ID"]
  
   $ExportItem = New-Object PSObject
   #Get Each field
   foreach($Field in $_.Fields)
    {
        $ExportItem | Add-Member -MemberType NoteProperty -name $Field.InternalName -value $_[$Field.InternalName] 
    }
    #Add the object with property to an Array
    $ListItemCollection += $ExportItem
 
}   
#Export the result Array to CSV file
$ListItemCollection | Export-CSV $OutPutFile -NoTypeInformation -Encoding UTF8
Write-host "List items exported to $($OutputFile) for site $($SiteURL)"
  
$web.Dispose()