# Obtiene el nombre del equipo
$computerName = $env:COMPUTERNAME

# Generar el contenido XML con el nombre del equipo
$xmlOutput = "<NombreEquipo>`n"
$xmlOutput += "  <Equipo>$computerName</Equipo>`n"
$xmlOutput += "</NombreEquipo>"

# Devolver el resultado como XML
Write-Output $xmlOutput
