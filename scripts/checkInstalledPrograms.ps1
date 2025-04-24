# Obtener programas instalados desde el Registro de Windows (tanto 64-bit como 32-bit)
$paths = @(
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
)

$programas = foreach ($path in $paths) {
    Get-ItemProperty $path | Select-Object DisplayName, DisplayVersion, Publisher, InstallLocation
}

# Filtrar programas con nombre no vacío
$programas = $programas | Where-Object { $_.DisplayName -ne $null }

# Generar contenido HTML
if ($programas) {
    $htmlOutput = '<section class="mb-6">
        <h2 class="font-semibold text-gray-700 mb-2">Programas Instalados</h2>
        <div class="overflow-x-auto">
            <table class="table-auto w-full border border-gray-300 text-left text-sm">
                <thead class="bg-gray-200">
                    <tr>
                        <th class="border px-2 py-1">Nombre</th>
                        <th class="border px-2 py-1">Versi&#243;n</th>
                        <th class="border px-2 py-1">Publicador</th>
                    </tr>
                </thead>
                <tbody>'

    foreach ($program in $programas) {
        $name = $program.DisplayName
        $version = $program.DisplayVersion
        $publisher = $program.Publisher

        $htmlOutput += "<tr>
            <td class='border px-2 py-1'>$name</td>
            <td class='border px-2 py-1'>$version</td>
            <td class='border px-2 py-1'>$publisher</td>
        </tr>"
    }

    $htmlOutput += '</tbody>
            </table>
        </div>
    </section>'
} else {
    $htmlOutput = '<section class="mb-4">
        <h2 class="font-semibold text-gray-700 mb-2">Programas Instalados</h2>
        <div class="p-4 bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 rounded-md shadow-sm">
            <p>No se encontraron programas instalados.</p>
        </div>
    </section>'
}

# Devuelve el resultado como HTML
Write-Output $htmlOutput
