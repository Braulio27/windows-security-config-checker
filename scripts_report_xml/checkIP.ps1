# Obtiene las direcciones IP del equipo y filtra únicamente para el adaptador "Ethernet"
$networkAdapters = Get-NetIPAddress | Where-Object { 
    ($_.InterfaceAlias -like "Ethernet") -and ($_.AddressFamily -eq "IPv4" -or $_.AddressFamily -eq "IPv6")
}

# Genera el contenido HTML
if ($networkAdapters) {
    $xmlOutput = "<AdapatadoresRed>`n"

    foreach ($adapter in $networkAdapters) {
        $interfaceAlias = $adapter.InterfaceAlias
        $addressFamily = if ($adapter.AddressFamily -eq "IPv4") { "IPv4" } else { "IPv6" }
        $ipAddress = $adapter.IPAddress
        $state = if ($adapter.PrefixOrigin -eq "WellKnown") { "Est&#225;tico" } else { "Din&#225;mico" }

        $xmlOutput += "<AdaptadorRed>`n
            <Nombre>$interfaceAlias</Nombre>`n
            <FamiliaDeDirecciones>$addressFamily</FamiliaDeDirecciones>`n
            <DireccionIP>$ipAddress</DireccionIP>`n
            <Estado>$state</Estado>`n
        </AdaptadorRed>`n"
    }

    $xmlOutput += '</AdapatadoresRed>'
} else {
    $xmlOutput = '<AdapatadoresRed>`n
        <Mensaje>No se encontraron direcciones IP configuradas para el adaptador Ethernet.</Mensaje>`n
    </AdapatadoresRed>'
}

# Devuelve el resultado como HTML
Write-Output $xmlOutput
