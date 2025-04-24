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
    $xmlOutput = "<ProgramasInstalados>`n"

    foreach ($program in $programas) {
        $name = $program.DisplayName
        $version = $program.DisplayVersion
        $publisher = $program.Publisher

        $xmlOutput += "<ProgramaInstalado>`n
            <Nombre>$name</Nombre>`n
            <Version>$version</Version>`n
            <Editor>$publisher</Editor>`n
            </ProgramaInstalado>`n"
    }

    $xmlOutput += '</ProgramasInstalados>'
} else {
    $xmlOutput = '<ProgramasInstalados>`n'
    $xmlOutput = '<Mensaje>No se encontraron programas instalados en el equipo.</Mensaje>`n'
    $xmlOutput += '</ProgramasInstalados>`n'
}

# Devuelve el resultado como HTML
Write-Output $xmlOutput
