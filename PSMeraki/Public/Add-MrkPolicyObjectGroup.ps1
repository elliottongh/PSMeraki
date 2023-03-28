function Add-MrkPolicyObjectGroup {
    <#
    .SYNOPSIS
    Adds a policy object group to an organization
    .DESCRIPTION
    .EXAMPLE
    Add-MrkPolicyObjectGroup -Name 'TestPolicyObjectGroup' -category 'NetworkObjectGroup'
    .PARAMETER orgId
    Defaults to Get-MrkFirstOrgID, for admins who maintain multiple organizations, OrgID can be specified
    .PARAMETER Name
    Name of the policy object group, unique within the organization
    .PARAMETER category
    Category of a policy object group (one of: NetworkObjectGroup, GeoLocationGroup, PortObjectGroup, ApplicationGroup)
    .PARAMETER objectIds
    A list of Policy Object ID's that this NetworkObjectGroup should be associated with
    #>
    [CmdletBinding()]
    Param (
        [Parameter()][String]$orgId = (Get-MrkFirstOrgID),
        [Parameter(Mandatory)][ValidateNotNullOrEmpty()][String]$Name,
        [Parameter()][String]$category,
        [Parameter()][Array]$objectIds
    )

    $body = @{
        "name" = $Name
    }

    if ($category) { $body["category"] = $category }
    if ($objectIds) { $body["objectIds"] = $objectIds }

    Invoke-MrkRestMethod -Method POST -ResourceID "/organizations/$orgId/policyObjects/groups/" -Body $body
}
