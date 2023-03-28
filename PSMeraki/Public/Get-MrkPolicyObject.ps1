function Get-MrkPolicyObject {
    <#
    .SYNOPSIS
    Retrieves all Meraki policy objects for an organization
    .DESCRIPTION
    Gets a list of all Meraki policy objects configured in an organization.
    .EXAMPLE
    Get-MrkPolicyObject
    .EXAMPLE
    Get-MrkPolicyObject -OrgId 111222
    .PARAMETER orgId
    optional specify a org Id, default it will take the first OrgId retrieved from Get-MrkOrganizations
    #>
    [CmdletBinding()]
    Param (
        [Parameter()][String]$orgId = (Get-MrkFirstOrgID)
    )
    Invoke-MrkRestMethod -Method GET -ResourceID "/organizations/$orgId/policyObjects"
}