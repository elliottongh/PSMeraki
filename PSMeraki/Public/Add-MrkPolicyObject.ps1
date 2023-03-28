function Add-MrkPolicyObject {
    <#
    .SYNOPSIS
    Adds a Policy Object to an organization
    .DESCRIPTION
    .EXAMPLE
    Add-MrkPolicyObject -Name 'TestPolicyObject' -type 'cidr' -category 'network' -cidr '10.11.12.1/24'
    .PARAMETER orgId
    Defaults to Get-MrkFirstOrgID, for admins who maintain multiple organizations, OrgID can be specified
    .PARAMETER Name
    Name of the policy object, unique within the organization
    .PARAMETER type
    Type of a policy object (one of: adaptivePolicyIpv4Cidr, cidr, fqdn, ipAndMask)
    .PARAMETER category
    Category of a policy object (one of: adaptivePolicy, network)
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
        [Parameter(Mandatory)][ValidateNotNullOrEmpty()][String]$Name,
        [Parameter(Mandatory)][ValidateNotNullOrEmpty()][String]$type,
        [Parameter(Mandatory)][ValidateNotNullOrEmpty()][String]$category,
        [Parameter()][String]$cidr,
        [Parameter()][String]$fqdn,
        [Parameter()][String]$ip,
        [Parameter()][String]$mask,
        [Parameter()][Array]$groupIds
    )

    $body = @{
        "name" = $Name
        "type" = $type
        "category" = $category
    }

    if ($cidr) { $body["cidr"] = $cidr }
    if ($fqdn) { $body["fqdn"] = $fqdn }
    if ($ip) { $body["ip"] = $ip }
    if ($mask) { $body["mask"] = $mask }
    if ($groupIds) { $body["groupIds"] = $groupIds }

    Invoke-MrkRestMethod -Method POST -ResourceID "/organizations/$orgId/policyObjects/" -Body $body
}
