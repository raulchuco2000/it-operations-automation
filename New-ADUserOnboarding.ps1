<#
.SYNOPSIS
    Automatiza la creación de nuevos usuarios en Active Directory.
.DESCRIPTION
    Este script solicita los datos básicos del usuario, genera el sAMAccountName, 
    crea la cuenta en la OU correspondiente y lo añade a los grupos por defecto.
#>

param (
    [Parameter(Mandatory=$true)][string]$Nombre,
    [Parameter(Mandatory=$true)][string]$Apellidos,
    [Parameter(Mandatory=$true)][string]$Departamento,
    [string]$Dominio = "@empresa.local"
)

# Construcción de variables
$sAMAccountName = ($Nombre.Substring(0,1) + $Apellidos.Split(' ')[0]).ToLower()
$UserPrincipalName = $sAMAccountName + $Dominio
$OUPath = "OU=$Departamento,OU=Usuarios,DC=empresa,DC=local"
$Password = ConvertTo-SecureString "TempPass123!" -AsPlainText -Force

Write-Host "Iniciando despliegue para el usuario: $UserPrincipalName" -ForegroundColor Cyan

# Crear usuario en AD
try {
    New-ADUser -Name "$Nombre $Apellidos" `
               -GivenName $Nombre `
               -Surname $Apellidos `
               -SamAccountName $sAMAccountName `
               -UserPrincipalName $UserPrincipalName `
               -Path $OUPath `
               -AccountPassword $Password `
               -Enabled $true `
               -ChangePasswordAtLogon $true
    
    Write-Host "✅ Usuario $sAMAccountName creado exitosamente en $OUPath" -ForegroundColor Green
}
catch {
    Write-Error "❌ Error al crear el usuario. Verifique permisos o si el usuario ya existe."
}
