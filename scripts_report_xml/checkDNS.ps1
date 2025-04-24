# Obtiene la configuración de los servidores DNS
$dnsServers = Get-DnsClientServerAddress -AddressFamily IPv4 | Select-Object -ExpandProperty ServerAddresses

# Generar el contenido XML
if ($dnsServers) {
    $xmlOutput = "<VerificacionServidoresDNS>`n"

    foreach ($server in $dnsServers) {
        $xmlOutput += "  <ServidorDNS>$server</ServidorDNS>`n"
    }

    $xmlOutput += "</VerificacionServidoresDNS>"
} else {
    $xmlOutput = "<VerificacionServidoresDNS>`n"
    $xmlOutput += "  <Mensaje>No se encontraron servidores DNS configurados.</Mensaje>`n"
    $xmlOutput += "</VerificacionServidoresDNS>"
}

# Devolver el resultado como XML
Write-Output $xmlOutput
