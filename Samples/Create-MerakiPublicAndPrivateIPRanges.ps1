$privateCidrs = @(
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16"
)

$publicCidrs = @(
    "0.0.0.0/5",
    "8.0.0.0/7",
    "11.0.0.0/8",
    "12.0.0.0/6",
    "16.0.0.0/4",
    "32.0.0.0/3",
    "64.0.0.0/2",
    "128.0.0.0/3",
    "160.0.0.0/5",
    "168.0.0.0/6",
    "172.0.0.0/12",
    "173.0.0.0/8",
    "174.0.0.0/7",
    "176.0.0.0/4",
    "192.0.0.0/9",
    "192.128.0.0/11",
    "192.160.0.0/13",
    "192.169.0.0/16",
    "192.170.0.0/15",
    "192.172.0.0/14",
    "192.176.0.0/12",
    "192.192.0.0/10",
    "193.0.0.0/8",
    "194.0.0.0/7",
    "196.0.0.0/6",
    "200.0.0.0/5",
    "208.0.0.0/4"
)

$Organizations = Get-MrkOrganization

foreach ($Organization in $Organizations) {
    $PolicyObjects = Get-MrkPolicyObject -orgId $Organization.id
    $PolicyObjectGroups = Get-MrkPolicyObjectGroup -orgId $Organization.id

    $PolicyObjectsChanged = $false
    # Create Private Policy Objects
    for ($i = 0; $i -lt $privateCidrs.length; $i++) {
        $PolicyObjectName = "Private IP Range $($i + 1)"
        if ($PolicyObjectName -notin $PolicyObjects.name) {
            Add-MrkPolicyObject -orgId $Organization.id -name $PolicyObjectName -category "network" -type "cidr" -cidr $privateCidrs[$i]
            $PolicyObjectsChanged = $true
        } else {
            Write-Host "Private Range name already exists"
        }
    }

    # Create Public Policy Objects
    for ($i = 0; $i -lt $publicCidrs.length; $i++) {
        $PolicyObjectName = "Public IP Range $($i + 1)"
        if ($PolicyObjectName -notin $PolicyObjects.name) {
            Add-MrkPolicyObject -orgId $Organization.id -name $PolicyObjectName -category "network" -type "cidr" -cidr $publicCidrs[$i]
            $PolicyObjectsChanged = $true
        } else {
            Write-Host "Public Range name already exists"
        }
    }

    # Update $PolicyObjects to get IDs if updated
    if ($PolicyObjectsChanged) {
        $PolicyObjects = Get-MrkPolicyObject -orgId $Organization.id
    }

    #Create Private Policy Object Group
    $PrivateIPRangeIDs = $PolicyObjects | Where-Object { $_.name -match "Private IP Range \d+" } | Select-Object -ExpandProperty id
    if ("Private IP Ranges" -notin $PolicyObjectGroups.name) {
        Add-MrkPolicyObjectGroup -orgId $Organization.id -name "Private IP Ranges" -objectIds $PrivateIPRangeIDs
    } else {
        $PolicyObjectGroupID = $PolicyObjectGroups | Where-Object { $_.name -eq "Private IP Ranges" } | Select-Object -ExpandProperty id
        Set-MrkPolicyObjectGroup -orgId $Organization.id -policyObjectGroupId $PolicyObjectGroupID -name "Private IP Ranges" -objectIds $PrivateIPRangeIDs
    }

    #Create Public Policy Object Group
    $PublicIPRangeIDs = $PolicyObjects | Where-Object { $_.name -match "Public IP Range \d+" } | Select-Object -ExpandProperty id
    if ("Public IP Ranges" -notin $PolicyObjectGroups.name) {
        Add-MrkPolicyObjectGroup -orgId $Organization.id -name "Public IP Ranges" -objectIds $PublicIPRangeIDs
    } else {
        $PolicyObjectGroupID = $PolicyObjectGroups | Where-Object { $_.name -eq "Public IP Ranges" } | Select-Object -ExpandProperty id
        Set-MrkPolicyObjectGroup -orgId $Organization.id -policyObjectGroupId $PolicyObjectGroupID -name "Public IP Ranges" -objectIds $PublicIPRangeIDs
    }

    #Update $PolicyObjectGroups to get IDs if updated
    if ($PolicyObjectGroupsChanged) {
        $PolicyObjectGroups = Get-MrkPolicyObjectGroup -orgId $Organization.id
    }
}
