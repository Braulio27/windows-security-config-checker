# Obtiene las direcciones IP del equipo y filtra únicamente para el adaptador "Ethernet"
$networkAdapters = Get-NetIPAddress | Where-Object { 
    ($_.InterfaceAlias -like "Ethernet") -and ($_.AddressFamily -eq "IPv4" -or $_.AddressFamily -eq "IPv6")
}

# Genera el contenido XML
if ($networkAdapters) {
    $xmlOutput = "<DireccionesIPAdaptadorEthernet>`n"

    foreach ($adapter in $networkAdapters) {
        $interfaceAlias = $adapter.InterfaceAlias
        $addressFamily = if ($adapter.AddressFamily -eq "IPv4") { "IPv4" } else { "IPv6" }
        $ipAddress = $adapter.IPAddress
        $state = if ($adapter.PrefixOrigin -eq "WellKnown") { "Estático" } else { "Dinámico" }

        $xmlOutput += "  <Adaptador>`n"
        $xmlOutput += "    <Nombre>$interfaceAlias</Nombre>`n"
        $xmlOutput += "    <Tipo>$addressFamily</Tipo>`n"
        $xmlOutput += "    <DireccionIP>$ipAddress</DireccionIP>`n"
        $xmlOutput += "    <Estado>$state</Estado>`n"
        $xmlOutput += "  </Adaptador>`n"
    }

    $xmlOutput += "</DireccionesIPAdaptadorEthernet>"
} else {
    $xmlOutput = "<DireccionesIPAdaptadorEthernet>`n"
    $xmlOutput += "  <Mensaje>No se encontraron direcciones IP configuradas para el adaptador Ethernet.</Mensaje>`n"
    $xmlOutput += "</DireccionesIPAdaptadorEthernet>"
}

# Devolver el resultado como XML
Write-Output $xmlOutput
