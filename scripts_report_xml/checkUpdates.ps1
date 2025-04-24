# Obtiene el estado de las actualizaciones de Windows
$pendingUpdates = Get-WmiObject -Class "Win32_QuickFixEngineering" | Select-Object Description, HotFixID, InstalledOn

# Genera el contenido XML
if ($pendingUpdates) {
    $xmlOutput += "<ActualizacionesPendientes>`n"

    foreach ($update in $pendingUpdates) {
        $description = $update.Description
        $hotFixID = $update.HotFixID
        $installedOn = $update.InstalledOn

        # Formatea la fecha para mayor claridad
        $formattedDate = if ($installedOn) { $installedOn.ToString('yyyy-MM-dd') } else { "Desconocido" }

        $xmlOutput += "  <Actualizacion>`n"
        $xmlOutput += "    <Descripcion>$description</Descripcion>`n"
        $xmlOutput += "    <HotFixID>$hotFixID</HotFixID>`n"
        $xmlOutput += "    <InstaladaEl>$formattedDate</InstaladaEl>`n"
        $xmlOutput += "  </Actualizacion>`n"
    }

    $xmlOutput += "</ActualizacionesPendientes>"
} else {
    $xmlOutput = "<?xml version='1.0' encoding='UTF-8'?>`n"
    $xmlOutput += "<ActualizacionesPendientes>`n"
    $xmlOutput += "  <Mensaje>No se encontraron actualizaciones pendientes.</Mensaje>`n"
    $xmlOutput += "</ActualizacionesPendientes>"
}

# Devuelve el resultado como XML
Write-Output $xmlOutput
