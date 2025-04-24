function Get-WindowsKey {
    $KeyPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform'
    $DigitalProductId = (Get-ItemProperty -Path $KeyPath).BackupProductKeyDefault
    return $DigitalProductId
}

Get-WindowsKey
