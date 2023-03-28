function Set-MrkPolicyObject {
    <#
    .SYNOPSIS
    Updates an existing Policy Object
    .DESCRIPTION
    .EXAMPLE
    Set-MrkPolicyObject -policyObjectId '1234abcd' -Name 'UpdatedPolicyObject' -cidr '10.11.12.1/24' -groupIds @('groupId1', 'groupId2')
    .PARAMETER orgId
    Defaults to Get-MrkFirstOrgID, for admins who maintain multiple organizations, OrgID can be specified
    .PARAMETER policyObjectId
    ID of the Policy Object to update
    .PARAMETER Name
    Name of the policy object, unique within the organization
    .PARAMETER cidr
    CIDR Value of a policy object (e.g. 10.11.12.1/24)
    .PARAMETER fqdn
    Fully qualified domain name of policy object (e.g. "example.com")
    .PARAMETER ip
    IP Address of a policy object (e.g. "1.2.3.4")
    .PARAMETER mask
    Mask of a policy object (e.g. "255.255.0.0")
    .PARAMETER groupIds
    The IDs of policy object groups the policy object belongs to
    #>
    [CmdletBinding()]
    Param (
        [Parameter()][String]$orgId = (Get-MrkFirstOrgID),
        [Parameter(Mandatory)][String]$policyObjectId,
        [Parameter()][String]$Name,
        [Parameter()][String]$cidr,
        [Parameter()][String]$fqdn,
        [Parameter()][String]$ip,
        [Parameter()][String]$mask,
        [Parameter()][Array]$groupIds
    )

    $body = @{}

    if ($Name) { $body["name"] = $Name }
    if ($cidr) { $body["cidr"] = $cidr }
    if ($fqdn) { $body["fqdn"] = $fqdn }
    if ($ip) { $body["ip"] = $ip }
    if ($mask) { $body["mask"] = $mask }
    if ($groupIds) { $body["groupIds"] = $groupIds }

    Invoke-MrkRestMethod -Method PUT -ResourceID "/organizations/$orgId/policyObjects/$policyObjectId" -Body $body
}
