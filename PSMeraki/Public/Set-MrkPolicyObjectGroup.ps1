function Set-MrkPolicyObjectGroup {
    <#
    .SYNOPSIS
    Updates an existing Policy Object Group
    .DESCRIPTION
    .EXAMPLE
    Set-MrkPolicyObjectGroup -policyObjectGroupId '1234abcd' -Name 'UpdatedPolicyObjectGroup' -objectIds @('policyObjId1', 'policyObjId2')
    .PARAMETER orgId
    Defaults to Get-MrkFirstOrgID, for admins who maintain multiple organizations, OrgID can be specified
    .PARAMETER policyObjectGroupId
    ID of the Policy Object Group to update
    .PARAMETER Name
    A name for the group of network addresses, unique within the organization
    .PARAMETER objectIds
    A list of Policy Object ID's that this NetworkObjectGroup should be associated with
    #>
    [CmdletBinding()]
    Param (
        [Parameter()][String]$orgId = (Get-MrkFirstOrgID),
        [Parameter(Mandatory)][String]$policyObjectGroupId,
        [Parameter()][String]$Name,
        [Parameter()][Array]$objectIds
    )

    $body = @{}

    if ($Name) { $body["name"] = $Name }
    if ($objectIds) { $body["objectIds"] = $objectIds }

    Invoke-MrkRestMethod -Method PUT -ResourceID "/organizations/$orgId/policyObjects/groups/$policyObjectGroupId" -Body $body
}
