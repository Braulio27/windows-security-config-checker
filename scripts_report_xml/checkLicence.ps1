function Get-WindowsKey {
    $KeyPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform'

    # Intentar obtener la clave de producto
    try {
        $DigitalProductId = (Get-ItemProperty -Path $KeyPath -ErrorAction Stop).BackupProductKeyDefault
        if ($DigitalProductId) {
            # Crear el objeto XML
            $xmlOutput = New-Object -TypeName PSObject -Property @{
                KeyType = "BackupProductKeyDefault"
                ProductKey = $DigitalProductId
            }

            # Convertir el objeto en XML
            $xml = $xmlOutput | ConvertTo-Xml -As String -Depth 3
            return $xml
        } else {
            # Si no se encuentra la clave, devolver mensaje XML
            $xmlOutput = New-Object -TypeName PSObject -Property @{
                Error = "No se encontró la clave de producto."
            }
            return $xmlOutput | ConvertTo-Xml -As String -Depth 3
        }
    }
    catch {
        # Si hay un error al acceder al registro, devolver mensaje XML de error
        $xmlOutput = New-Object -TypeName PSObject -Property @{
            Error = "Error al obtener la clave de producto. Asegúrate de tener permisos elevados."
        }
        return $xmlOutput | ConvertTo-Xml -As String -Depth 3
    }
}

Get-WindowsKey
