function Get-MrkPolicyObjectGroup {
    <#
    .SYNOPSIS
    Retrieves all Meraki policy object groups for an organization
    .DESCRIPTION
    Gets a list of all Meraki policy object groups configured in an organization.
    .EXAMPLE
    Get-MrkPolicyObjectGroup
    .EXAMPLE
    Get-MrkPolicyObjectGroup -OrgId 111222
    .PARAMETER orgId
    optional specify a org Id, default it will take the first OrgId retrieved from Get-MrkOrganizations
    #>
    [CmdletBinding()]
    Param (
        [Parameter()][String]$orgId = (Get-MrkFirstOrgID)
    )
    Invoke-MrkRestMethod -Method GET -ResourceID "/organizations/$orgId/policyObjects/groups"
}