# ⚙️ IT Operations & Infrastructure Automation

Este repositorio contiene una colección de scripts en **PowerShell** desarrollados para automatizar tareas repetitivas de administración de sistemas, gestión de usuarios (Nivel 2/Nivel 3) y mantenimiento preventivo en entornos **Windows Server** y **Active Directory**.

El objetivo de estas automatizaciones es reducir el error humano, estandarizar la configuración de equipos y agilizar la resolución de incidentes corporativos.

## 🚀 Scripts Incluidos

* **`New-ADUserOnboarding.ps1`**: Automatiza el alta de nuevos usuarios en Active Directory, incluyendo asignación de grupos de seguridad, creación de carpetas home y licencias base.
* **`Get-ServerHealthCheck.ps1`**: Script de mantenimiento preventivo que audita el espacio en disco, uso de CPU/RAM y estado de servicios críticos en múltiples servidores Windows, exportando un reporte en HTML/CSV.
* **`Clear-StaleADComputers.ps1`**: Herramienta de limpieza que identifica y deshabilita (o mueve de OU) equipos informáticos inactivos por más de 90 días en la red.

## 🛠️ Tecnologías Utilizadas
* **Lenguaje:** PowerShell (versión 5.1+)
* **Módulos:** ActiveDirectory
* **Entorno:** Windows Server, Active Directory Domain Services (AD DS)

## ⚠️ Nota Importante
*Todos los scripts han sido sanitizados. Cualquier dato sensible, nombre de dominio o credencial hardcodeada ha sido reemplazada por variables genéricas (ej. `contoso.com`). Por favor, revisa y ajusta las variables de entorno antes de ejecutar en producción.*
