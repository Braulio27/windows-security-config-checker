# Obtener las unidades de red conectadas
$networkDrives = Get-WmiObject -Class Win32_LogicalDisk | Where-Object { $_.DriveType -eq 4 }

# Generar contenido XML
if ($networkDrives) {
    $xmlOutput += "<UnidadesDeRedConectadas>`n"

    foreach ($drive in $networkDrives) {
        $letter = $drive.DeviceID
        $networkPath = $drive.ProviderName
        $totalSpace = [math]::Round($drive.Size / 1GB, 2)
        $freeSpace = [math]::Round($drive.FreeSpace / 1GB, 2)

        $xmlOutput += "  <Unidad>`n"
        $xmlOutput += "    <Letra>$letter</Letra>`n"
        $xmlOutput += "    <RutaDeRed>$networkPath</RutaDeRed>`n"
        $xmlOutput += "    <EspacioTotalGB>$totalSpace</EspacioTotalGB>`n"
        $xmlOutput += "    <EspacioLibreGB>$freeSpace</EspacioLibreGB>`n"
        $xmlOutput += "  </Unidad>`n"
    }

    $xmlOutput += "</UnidadesDeRedConectadas>"
} else {
    $xmlOutput += "<UnidadesDeRedConectadas>`n"
    $xmlOutput += "  <Mensaje>No se encontraron unidades de red conectadas en el equipo.</Mensaje>`n"
    $xmlOutput += "</UnidadesDeRedConectadas>"
}

# Devolver el resultado como XML
Write-Output $xmlOutput
