# Ejecutar el comando de FortiClient y capturar la salida
$command = "& 'C:\Program Files\Fortinet\FortiClient\FortiESNAC.exe' -d"
$output = Invoke-Expression $command 2>&1

# Generar el contenido HTML
if ($output) {
    $htmlOutput = '<section class="mb-6">
        <h2 class="font-semibold text-gray-700 mb-2">Estado de FortiClient</h2>
        <div class="bg-gray-100 border border-gray-300 rounded-md p-4 overflow-x-auto text-sm">
            <pre class="whitespace-pre-wrap font-mono text-gray-800">'

    foreach ($line in $output) {
        $htmlOutput += "$line`n"
    }

    $htmlOutput += '</pre>
        </div>
    </section>'
} else {
    $htmlOutput = '<section class="mb-4">
        <h2 class="font-semibold text-gray-700 mb-2">Estado de FortiClient</h2>
        <div class="p-4 bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 rounded-md shadow-sm">
            <p>No se obtuvo ninguna salida del comando.</p>
        </div>
    </section>'
}

# Devolver el resultado como HTML
Write-Output $htmlOutput
