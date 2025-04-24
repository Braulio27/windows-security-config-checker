# Obtener las unidades de red conectadas
$networkDrives = Get-WmiObject -Class Win32_LogicalDisk | Where-Object { $_.DriveType -eq 4 }

# Generar contenido HTML
if ($networkDrives) {
    $htmlOutput = '<section class="mb-6">
        <h2 class="font-semibold text-gray-700 mb-2">Unidades de Red Conectadas</h2>
        <div class="overflow-x-auto">
            <table class="table-auto w-full border border-gray-300 text-left">
                <thead class="bg-gray-200">
                    <tr>
                        <th class="border px-2 py-1">Letra de Unidad</th>
                        <th class="border px-2 py-1">Ruta de Red</th>
                        <th class="border px-2 py-1">Espacio Total (GB)</th>
                        <th class="border px-2 py-1">Espacio Libre (GB)</th>
                    </tr>
                </thead>
                <tbody>'

    foreach ($drive in $networkDrives) {
        $letter = $drive.DeviceID
        $networkPath = $drive.ProviderName
        $totalSpace = [math]::Round($drive.Size / 1GB, 2)
        $freeSpace = [math]::Round($drive.FreeSpace / 1GB, 2)

        $htmlOutput += "<tr>
            <td class='border px-2 py-1'>$letter</td>
            <td class='border px-2 py-1'>$networkPath</td>
            <td class='border px-2 py-1'>$totalSpace</td>
            <td class='border px-2 py-1'>$freeSpace</td>
        </tr>"
    }

    $htmlOutput += '</tbody>
            </table>
        </div>
    </section>'
} else {
    $htmlOutput = '<section class="mb-4">
        <h2 class="font-semibold text-gray-700 mb-2">Unidades de Red Conectadas</h2>
        <div class="p-4 bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 rounded-md shadow-sm">
            <p>No se encontraron unidades de red conectadas en el equipo.</p>
        </div>
    </section>'
}

# Devolver el resultado como HTML
Write-Output $htmlOutput
