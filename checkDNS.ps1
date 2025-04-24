# Obtiene la configuración de los servidores DNS
$dnsServers = Get-DnsClientServerAddress -AddressFamily IPv4 | Select-Object -ExpandProperty ServerAddresses

# Verifica si hay servidores DNS configurados
if ($dnsServers) {
    $htmlOutput = '<section class="mb-6">
        <h2 class="font-semibold text-gray-700 mb-2">Verificaci&#243;n de Servidores DNS</h2>
        <div class="bg-white border border-blue-400 rounded-md shadow-sm">
            <ul class="divide-y divide-gray-200">'
    foreach ($server in $dnsServers) {
        $htmlOutput += "<li class='px-4 py-2 text-sm text-gray-800'><strong class='text-gray-600'>Servidor DNS:</strong> $server</li>"
    }
    $htmlOutput += '</ul>
        </div>
    </section>'
} else {
    $htmlOutput = '<section class="mb-4">
        <h2 class="font-semibold text-gray-700 mb-2">Verificaci&#243;n de Servidores DNS</h2>
        <div class="p-4 bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 rounded-md shadow-sm">
            <p>No se encontraron servidores DNS configurados.</p>
        </div>
    </section>'
}

# Devuelve el resultado como HTML
Write-Output $htmlOutput
