# Obtiene el nombre del dominio al que el equipo está unido
$domainInfo = (Get-WmiObject -Class Win32_ComputerSystem).Domain
$workgroupInfo = (Get-WmiObject -Class Win32_ComputerSystem).Workgroup

# Verifica si el equipo está unido a un dominio
if ($domainInfo -and $domainInfo -ne $env:COMPUTERNAME) {
    $xmlOutput = "<EstadoDominio>`n"
    $xmlOutput += "  <Union>El equipo está unido al dominio: $domainInfo</Union>`n"
    $xmlOutput += "</EstadoDominio>"
} else {
    $xmlOutput = "<EstadoDominio>`n"
    $xmlOutput += "  <Union>El equipo no está unido a ningún dominio. Está en el grupo de trabajo: $workgroupInfo</Union>`n"
    $xmlOutput += "</EstadoDominio>"
}

# Devolver el resultado como XML
Write-Output $xmlOutput
