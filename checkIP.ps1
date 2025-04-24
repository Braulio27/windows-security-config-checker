# Obtiene las direcciones IP del equipo y filtra únicamente para el adaptador "Ethernet"
$networkAdapters = Get-NetIPAddress | Where-Object { 
    ($_.InterfaceAlias -like "Ethernet") -and ($_.AddressFamily -eq "IPv4" -or $_.AddressFamily -eq "IPv6")
}

# Genera el contenido HTML
if ($networkAdapters) {
    $htmlOutput = '<section class="mb-6">
        <h2 class="font-semibold text-gray-700 mb-2">Direcciones IP del Adaptador Ethernet</h2>
        <div class="overflow-x-auto">
            <table class="table-auto w-full border border-gray-300 text-left">
                <thead class="bg-gray-200">
                    <tr>
                        <th class="border px-2 py-1">Adaptador</th>
                        <th class="border px-2 py-1">Tipo</th>
                        <th class="border px-2 py-1">Direcci&#243;n IP</th>
                        <th class="border px-2 py-1">Estado</th>
                    </tr>
                </thead>
                <tbody>'

    foreach ($adapter in $networkAdapters) {
        $interfaceAlias = $adapter.InterfaceAlias
        $addressFamily = if ($adapter.AddressFamily -eq "IPv4") { "IPv4" } else { "IPv6" }
        $ipAddress = $adapter.IPAddress
        $state = if ($adapter.PrefixOrigin -eq "WellKnown") { "Est&#225;tico" } else { "Din&#225;mico" }

        $htmlOutput += "<tr>
            <td class='border px-2 py-1'>$interfaceAlias</td>
            <td class='border px-2 py-1'>$addressFamily</td>
            <td class='border px-2 py-1'>$ipAddress</td>
            <td class='border px-2 py-1'>$state</td>
        </tr>"
    }

    $htmlOutput += '</tbody>
            </table>
        </div>
    </section>'
} else {
    $htmlOutput = '<section class="mb-4">
        <h2 class="font-semibold text-gray-700 mb-2">Direcciones IP del Adaptador Ethernet</h2>
        <div class="p-4 bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 rounded-md shadow-sm">
            <p>No se encontraron direcciones IP configuradas para el adaptador Ethernet.</p>
        </div>
    </section>'
}

# Devuelve el resultado como HTML
Write-Output $htmlOutput
