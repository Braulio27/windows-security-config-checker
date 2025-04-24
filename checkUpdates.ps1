# Obtiene el estado de las actualizaciones de Windows
$pendingUpdates = Get-WmiObject -Class "Win32_QuickFixEngineering" | Select-Object Description, HotFixID, InstalledOn

# Genera el contenido HTML
if ($pendingUpdates) {
    $htmlOutput = '<section class="mb-6">
        <h2 class="font-semibold text-gray-700 mb-2">Actualizaciones Pendientes</h2>
        <div class="overflow-x-auto">
            <table class="min-w-full border border-gray-300 text-left">
                <thead class="bg-gray-200">
                    <tr>
                        <th class="border px-2 py-1">Descripción</th>
                        <th class="border px-2 py-1">HotFix ID</th>
                        <th class="border px-2 py-1">Instalada el</th>
                    </tr>
                </thead>
                <tbody>'
    
    foreach ($update in $pendingUpdates) {
        $description = $update.Description
        $hotFixID = $update.HotFixID
        $installedOn = $update.InstalledOn

        # Formatea la fecha para mayor claridad
        $formattedDate = if ($installedOn) { $installedOn.ToString('yyyy-MM-dd') } else { "Desconocido" }

        $htmlOutput += "<tr><td class='border px-2 py-1'>$description</td><td class='border px-2 py-1'>$hotFixID</td><td class='border px-2 py-1'>$formattedDate</td></tr>"
    }

    $htmlOutput += '</tbody>
            </table>
        </div>
    </section>'
} else {
    $htmlOutput = '<section class="mb-4">
        <h2 class="font-semibold text-gray-700 mb-2">Actualizaciones Pendientes</h2>
        <div class="p-4 bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 rounded-md shadow-sm">
            <p>No se encontraron actualizaciones pendientes.</p>
        </div>
    </section>'
}

# Devuelve el resultado como HTML
Write-Output $htmlOutput
