function Remove-MrkPolicyObjectGroup {
    <#
    .SYNOPSIS
    Removes a policy object group from an organization
    .EXAMPLE
    Remove-MrkPolicyObjectGroup -GroupId '1234'
    .PARAMETER orgId
    Defaults to Get-MrkFirstOrgID, for admins who maintain multiple organizations, OrgID can be specified
    .PARAMETER GroupId
    ID of the policy object group to be removed
    #>
    [CmdletBinding()]
    Param (
        [Parameter()][String]$orgId = (Get-MrkFirstOrgID),
        [Parameter(Mandatory)][ValidateNotNullOrEmpty()][String]$GroupId
    )

    Invoke-MrkRestMethod -Method DELETE -ResourceID "/organizations/$orgId/policyObjects/groups/$GroupId"
}
