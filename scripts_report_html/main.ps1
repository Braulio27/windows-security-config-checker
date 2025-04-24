# Ruta del archivo HTML final
$outputFile = "report.html"

# Lista de scripts a invocar
$scripts = @(
    ".\checkServiceTag.ps1",
    ".\checkDNS.ps1",
    ".\checkIP.ps1",
    ".\checkNetworkInfo.ps1",
    ".\checkADDomain.ps1",
    ".\checkComputerName.ps1",
    ".\checkInstalledPrograms.ps1",
    ".\checkPrinters.ps1",
    ".\checkUpdates.ps1",
    ".\checkFortiClient.ps1",
    ".\checkNetworkDrives.ps1"
    ".\checkOSVersion.ps1",
    ".\checkLicence.ps1",
    ".\checkGPOsApplied.ps1"
)

# Variable para almacenar el contenido HTML
$htmlContent = @"
<!DOCTYPE html>
<html lang='es'>
<head>
    <meta charset='UTF-8'></meta>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'></meta>
    <title>Reporte de Configuración del Equipo</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-900">
    <div class="max-w-7xl mx-auto p-6">
        <div class="bg-white p-6 rounded-lg shadow-md">
            <h1 class="text-3xl font-bold text-blue-600 mb-6">Reporte de Configuraci&#243;n del Equipo</h1>
"@

# Ejecuta cada script y añade su salida al contenido HTML
foreach ($script in $scripts) {
    if (Test-Path $script) {
        $result = & $script
        $htmlContent += "<div class='mb-6'>$result</div>`n"
    } else {
        $htmlContent += "<div class='bg-red-100 text-red-800 border border-red-300 rounded-md p-4 mb-6'>
                            <p class='font-semibold'>Error: No se encontr&#243; el script $script</p>
                         </div>`n"
    }
}

# Cierra el HTML
$htmlContent += @"
        </div>
    </div>
</body>
</html>
"@

# Guarda el contenido en el archivo HTML
$htmlContent | Out-File -FilePath $outputFile -Encoding UTF8

# Muestra un mensaje de confirmación
Write-Output "El reporte se ha generado exitosamente en: $outputFile"
java -jar .\pdfconverter-1.0-SNAPSHOT.jar