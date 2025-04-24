# Obtiene el número de serie del equipo
$serialNumber = Get-WmiObject -Class Win32_BIOS | Select-Object -ExpandProperty SerialNumber

# Genera el contenido XML
if ($serialNumber) {
    $xmlOutput = "<Equipo>
    <Estado>OK</Estado>
    <NumeroSerie>$serialNumber</NumeroSerie>
</Equipo>"
} else {
    $xmlOutput = "<Equipo>
    <Estado>Error</Estado>
    <Mensaje>No se pudo obtener el número de serie del equipo.</Mensaje>
</Equipo>"
}

# Devuelve el resultado como XML
Write-Output $xmlOutput
