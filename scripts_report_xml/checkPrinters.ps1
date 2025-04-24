# Obtiene la lista de impresoras configuradas en el equipo
$printers = Get-Printer | Select-Object Name, DriverName, PrinterStatus

# Genera el contenido XML
if ($printers) {
    $xmlOutput += "<ImpresorasConfiguradas>`n"

    foreach ($printer in $printers) {
        $name = $printer.Name
        $driver = $printer.DriverName
        $status = $printer.PrinterStatus

        # Traducción de los estados más comunes
        switch ($status) {
            0 { $status = "Desconocido" }
            1 { $status = "Otros" }
            2 { $status = "Listo" }
            3 { $status = "Imprimiendo" }
            4 { $status = "En pausa" }
            5 { $status = "Sin papel" }
            6 { $status = "Sin tóner" }
            7 { $status = "No disponible" }
            8 { $status = "Eliminando" }
            9 { $status = "Error" }
            10 { $status = "Inicializando" }
            11 { $status = "Apagado" }
            12 { $status = "Offline" }
            default { $status = "Estado desconocido" }
        }

        $xmlOutput += "  <Impresora>`n"
        $xmlOutput += "    <Nombre>$name</Nombre>`n"
        $xmlOutput += "    <Controlador>$driver</Controlador>`n"
        $xmlOutput += "    <Estado>$status</Estado>`n"
        $xmlOutput += "  </Impresora>`n"
    }

    $xmlOutput += "</ImpresorasConfiguradas>"
} else {
    $xmlOutput += "<ImpresorasConfiguradas>`n"
    $xmlOutput += "  <Mensaje>No se encontraron impresoras configuradas en el equipo.</Mensaje>`n"
    $xmlOutput += "</ImpresorasConfiguradas>"
}

# Devuelve el resultado como XML
Write-Output $xmlOutput
