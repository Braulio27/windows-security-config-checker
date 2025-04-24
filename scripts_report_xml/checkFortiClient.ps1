# Ejecutar el comando de FortiClient y capturar la salida
$command = "& 'C:\Program Files\Fortinet\FortiClient\FortiESNAC.exe' -d"
$output = Invoke-Expression $command 2>&1

# Generar el contenido XML
if ($output) {
    $xmlOutput = "<EstadoFortiClient>`n"

    foreach ($line in $output) {
        $xmlOutput += "  <Linea>$line</Linea>`n"
    }

    $xmlOutput += "</EstadoFortiClient>"
} else {
    $xmlOutput = "<EstadoFortiClient>`n"
    $xmlOutput += "  <Mensaje>No se obtuvo ninguna salida del comando.</Mensaje>`n"
    $xmlOutput += "</EstadoFortiClient>"
}

# Devolver el resultado como XML
Write-Output $xmlOutput
