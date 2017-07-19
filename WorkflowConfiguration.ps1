Add-PSSnapin "Microsoft.SharePoint.PowerShell"

$delimeter = ","
$filePath = "WorkflowConfiguration.csv"
$listName = "WorkflowConfiguration"
$status = ""
$oldDocNo = ""

$logFileName = ".\log\" + $listName + "_" + $(Get-Date -Format "yyyyMMddHHmmss") + '.txt'
$csvData = Import-Csv $filePath -Delimiter $delimeter -Encoding UTF8
$web = Get-SPWeb "<site>"
$list = $web.Lists[$listName]

$SubjectList = $web.Lists["Subject"]
$OfficeList = $web.Lists["Office"]
$SectorList = $web.Lists["Sector"]
$RoleList = $web.Lists["Role"]
$ContributorTypeList = $web.Lists["ContributorType"]

$filePath | Out-File $logFileName -Append

foreach ($line in $csvData)
{
    # variables
    $output = $(Get-Date -Format "yyyy'-'MM'-'dd HH':'mm':'ss")
    $match = 0

    $newItem = $list.AddItem() 
    $newItem["InOut"] = $line.InOut
    $newItem["State"] = $line.State
    $newItem["GroupOrder"] = $line.GroupOrder
    $newItem["ToStateIfApproved"] = $line.ToStateIfApproved
    $newItem["ToStateIfRejected"] = $line.ToStateIfRejected
    $newItem["Dependency"] = $line.Dependency
    $newItem["SubjectID"] = $line.SubjectID
    $newItem["IsLast"] = $line.IsLast
    $newItem["SkipTo"] = $line.SkipTo
    $newItem["LineName"] = $line.LineName
    $newItem["Phase"] = $line.Phase
    $newItem["ConfigurationID"] = $line.ConfigurationID
    $newItem["CloseState"] = $line.CloseState

    # Lookup fields
    $targetSubject = $null
    foreach ($subject in $SubjectList.Items)
    {
        if( $subject["Subject"] -eq $line.SubjectName)
        {
            $targetSubject = $subject.ID
        }
    }

    $newItem["SubjectName"] = $targetSubject


    $targetFromOffice = $null
    $targetToOffice = $null
    foreach ($office in $OfficeList.Items)
    {
        if( $office["OfficeName"] -eq $line.FromOffice)
        {
            $targetFromOffice = $office.ID
        }

        if( $office["OfficeName"] -eq $line.ToOffice)
        {
            $targetToOffice = $office.ID
        }
    }

    $newItem["FromOffice"] = $targetFromOffice
    $newItem["ToOffice"] = $targetToOffice


    $targetFromSector = $null
    $targetToSector = $null
    foreach ($sector in $SectorList.Items)
    {
        if( $sector["SectorName"] -eq $line.FromSector)
        {
            $targetFromSector = $sector.ID
        }

        if( $sector["SectorName"] -eq $line.ToSector)
        {
            $targetToSector = $sector.ID
        }
    }

    $newItem["FromSector"] = $targetFromSector
    $newItem["ToSector"] = $targetToSector


    $roleLookup = $null
    [Microsoft.SharePoint.SPFieldLookupValueCollection] $targetRoles = New-Object Microsoft.SharePoint.SPFieldLookupValueCollection

    $csvRole = $null
    if($line.RoleName -ne '')
    {
        $csvRole = $line.RoleName.Replace('#', '')
        $csvRoles = $csvRole.Split(';')

        $pureCsvRoles = $csvRoles | where {(-not ($_ -match '^[1-9]')) -and ($_ -ne '')}

        foreach ($pureCsvRolesItem in $pureCsvRoles)
        {
            foreach ($role in $RoleList.Items)
            {
                if( $role["Role"] -eq $pureCsvRolesItem )
                {
                    $roleLookup = New-Object Microsoft.Sharepoint.SPFieldLookupValue($role["ID"],$role["Role"])
                    $targetRoles.Add($roleLookup)
                }
            }
        }

        $newItem["RoleName"] = $targetRoles
    }

    $targetContributorType = $null
    foreach ($contributorType in $ContributorTypeList.Items)
    {
        if( $contributorType["ContributorType"] -eq $line.ContributorType)
        {
            $targetContributorType = $contributorType.ID
        }
    }

    $newItem["ContributorType"] = $targetContributorType
    $newItem.Update();

    # Stamp ConfigurationID
    $newItem["ConfigurationID"] = $newItem.ID
    $newItem.Update();
        
    $status = " - Added ( Source ID: " + $line.ID + ")"

    
    $output = $output + $status
    echo $output
    $output | Out-File $logFileName -Append

    $status = ""
    $output = ""
}

Write-Output  "========= Completed ========="
Write-Output  "=============================" | Out-File $logFileName -Append