function Add-MrkNetworkVLAN { # UNTESTED
    <#
    .SYNOPSIS
    Adds a VLAN to a Meraki network
    .DESCRIPTION
    Adds a VLAN to a Meraki network, identifying the network with the Network ID, to find an id use get-MrkNetwork
    .EXAMPLE
    Add-MrkNetworkVLAN -Networkid X_111122223639801111 -id 500 -Name DATA -subnet 10.11.12.0 -applianceIP 10.11.12.254
    .PARAMETER Networkid 
    id of a network (get-MrkNetworks)[0].id
    .PARAMETER id
    VLAN is, a number between 1 and 4094
    .PARAMETER Name
    The Name of the new VLAN
    .PARAMETER subnet
    The subnet of the VLAN 
    .PARAMETER applianceIP
    The local IP of the appliance on the VLAN 
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)][ValidateNotNullOrEmpty()][String]$Networkid,
        [Parameter(Mandatory)][ValidateNotNullOrEmpty()][String]$Id,
        [Parameter(Mandatory)][ValidateNotNullOrEmpty()][String]$Name,
        [Parameter(Mandatory)][ValidateNotNullOrEmpty()][String]$Subnet,
        [Parameter(Mandatory)][ValidateNotNullOrEmpty()][String]$applicanceIP
    )
    $body  = @{
        "id" = $Id
        "networkId" = $Networkid
        "name" = $Name
        "applianceIp" = $applicanceIP
        "subnet" = $Subnet
    }
    $request = Invoke-MrkRestMethod -Method POST -ResourceID ('/networks/' + $Networkid + '/vlans') -Body $body  
    return $request
}