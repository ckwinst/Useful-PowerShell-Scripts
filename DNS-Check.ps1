#Establish variable to grab IP address in the ServerAddresses Block

$ServerAddress = Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object {$_.interfaceAlias -like "Ethernet*"} | Select-Object -ExpandProperty ServerAddresses

#Establish variable to focus on just IPv4 Ethernet Interfaces 

$Ethernet = Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object {$_.interfaceAlias -like "Ethernet*"
} 

#Code to check for DNS IP on client machine and then assign a static default route if none exist 

If (!$Ethernet.ServerAddresses)
{
Write-Output "There is was no DNS Server Configured for this Device"

Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses ("172.16.0.10")

Write-Output "DNS set to Default static route 172.16.0.10"
}
Else
{
Write-Output "DNS Configured to $ServerAddress"
}
