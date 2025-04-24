# Ruta del archivo XML final
$outputFile = "report.xml"

# Lista de scripts a invocar
$scripts = @(
    ".\serialNumber.ps1",
    ".\checkDNS.ps1",
    ".\checkIP.ps1",
    ".\checkNetworkInfo.ps1",
    ".\checkADDomain.ps1",
    ".\checkComputerName.ps1",
    ".\checkInstalledPrograms.ps1",
    ".\checkPrinters.ps1",
    ".\checkUpdates.ps1",
    ".\checkFortiClient.ps1",
    ".\checkNetworkDrives.ps1",
    ".\checkOSVersion.ps1",
    ".\checkServiceTag.ps1",
    ".\checkLicense.ps1",
    ".\checkGPOsApplied.ps1",

)

# Crear objeto XML como string
$xmlContent = @"
<?xml version="1.0" encoding="UTF-8"?>
<ReporteConfiguracion>
"@

# Ejecuta cada script y añade su salida como nodo XML
foreach ($script in $scripts) {
    $scriptName = [System.IO.Path]::GetFileNameWithoutExtension($script)
    if (Test-Path $script) {
        $result = & $script
        # Escapar caracteres especiales para XML
        $escapedResult = [System.Security.SecurityElement]::Escape($result)
        $xmlContent += "    <$scriptName>$escapedResult</$scriptName>`n"
    } else {
        $xmlContent += "    <$scriptName>Error: No se encontró el script</$scriptName>`n"
    }
}

# Cierra el XML
$xmlContent += "</ReporteConfiguracion>"

# Guarda el contenido en el archivo XML
$xmlContent | Out-File -FilePath $outputFile -Encoding UTF8

# Muestra un mensaje de confirmación
Write-Output "El reporte XML se ha generado exitosamente en: $outputFile"
