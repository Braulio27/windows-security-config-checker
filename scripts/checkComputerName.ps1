# Obtiene el nombre del equipo
$computerName = $env:COMPUTERNAME

# Genera el contenido HTML con el nombre del equipo
$htmlOutput = '<section class="mb-6">
    <h2 class="font-semibold text-gray-700 mb-2">Nombre del Equipo</h2>
    <div class="bg-white border border-blue-400 rounded-md shadow-sm p-4">
        <p class="text-sm text-gray-800">El nombre del equipo es: <strong class="text-gray-900">' + $computerName + '</strong></p>
    </div>
</section>'

# Devuelve el resultado como HTML
Write-Output $htmlOutput
