# Obtiene el número de serie del equipo
$serialNumber = Get-WmiObject -Class Win32_BIOS | Select-Object -ExpandProperty SerialNumber

# Genera el contenido HTML
if ($serialNumber) {
    $htmlOutput = '<div class="p-4 bg-blue-100 border border-blue-300 rounded-md shadow-sm">
        <h2 class="font-semibold text-gray-700 mb-2">Número de Serie del Equipo</h2>
        <p><strong>Serial:</strong> ' + $serialNumber + '</p>
    </div>'
} else {
    $htmlOutput = '<div class="p-4 bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 rounded-md shadow-sm">
        <h2 class="font-semibold mb-1">Número de Serie</h2>
        <p>No se pudo obtener el número de serie del equipo.</p>
    </div>'
}

# Devuelve el resultado como HTML
Write-Output $htmlOutput
