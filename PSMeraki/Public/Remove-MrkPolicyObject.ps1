function Remove-MrkPolicyObject {
    <#
    .SYNOPSIS
    Deletes a dashboard Admin
    .DESCRIPTION
    .EXAMPLE
    Remove-MrkPolicyObject -policyObjectId 6811694436398
    .PARAMETER orgId
    defaults to Get-MrkFirstOrgID, for admins who maintain multiple organizations, OrgID can be specified
    .PARAMETER policyObjectId
    Policy Object ID, to find it use Get-MrkPolicyObject
    #>
    [CmdletBinding()]
    Param (
        [Parameter()][String]$orgId = (Get-MrkFirstOrgID),
        [Parameter(Mandatory)][ValidateNotNullOrEmpty()][String]$policyObjectId
    )
    Invoke-MrkRestMethod -Method DELETE -ResourceID "/organizations/$orgId/policyObjects/$policyObjectId"
}