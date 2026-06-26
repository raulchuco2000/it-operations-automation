<#
.SYNOPSIS
    Identifica y deshabilita cuentas de equipos inactivos en Active Directory.
.DESCRIPTION
    Busca en el AD los equipos que no han iniciado sesión en la red en los últimos 90 días,
    los deshabilita por seguridad (Zero Trust) y añade una nota en la descripción.
#>

$DiasInactividad = 90
$FechaLimite = (Get-Date).AddDays(-$DiasInactividad)

Write-Host "Buscando equipos inactivos desde antes del $FechaLimite..." -ForegroundColor Yellow

# Buscar equipos que superen el límite de inactividad
$EquiposInactivos = Get-ADComputer -Filter {LastLogonDate -lt $FechaLimite -and Enabled -eq $true} -Properties LastLogonDate, Description

if ($EquiposInactivos) {
    foreach ($Equipo in $EquiposInactivos) {
        Write-Host "Deshabilitando equipo: $($Equipo.Name) (Último inicio: $($Equipo.LastLogonDate))" -ForegroundColor Cyan
        
        # Deshabilita el equipo y actualiza la descripción para auditoría
        Set-ADComputer -Identity $Equipo -Enabled $false -Description "Deshabilitado por inactividad ($DiasInactividad dias) - $(Get-Date -Format 'dd/MM/yyyy')"
    }
    Write-Host "✅ Proceso completado. Se deshabilitaron $($EquiposInactivos.Count) equipos." -ForegroundColor Green
} else {
    Write-Host "✅ No se encontraron equipos inactivos. La red está limpia." -ForegroundColor Green
}
