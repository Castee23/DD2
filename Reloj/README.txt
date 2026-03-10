🚀 GUÍA RÁPIDA DE GIT - DD2
Sigue este orden exacto para que el proyecto de ModelSim y los archivos de hardware estén sincronizados.

1. Clonar y Crear Proyecto (Solo la primera vez)
El repositorio es la carpeta principal. Primero se clona, luego se crea el proyecto.

Clonar: Abre la terminal en tu carpeta de la universidad y escribe:

Bash
git clone [URL_DEL_REPOSITORIO]
cd [NOMBRE_DEL_REPO]
Crear Proyecto en ModelSim: Abre ModelSim y selecciona File > New > Project.

Project Location: Selecciona la carpeta que acabas de clonar.

Project Name: reloj_programable.

Añadir archivos: Dale a Add Existing File y selecciona los archivos .vhd que ya están en la carpeta. Importante: Elige la opción "Reference from current location".

2. Uso de las Ramas
Trabajamos por separado para no romper el código común.

Moverte a tu rama: git checkout tu-nombre

Si no existe aún: git checkout -b tu-nombre

Comprobar dónde estás: git status (siempre hazlo antes de editar nada).

3. Sincronizar y Actualizar (Pull y Push)
TRAER cambios (PULL)
Si un compañero ha subido algo a main y lo necesitas en tu proyecto:

git pull origin main (Esto descarga los archivos nuevos a tu carpeta).

En ModelSim, los archivos se actualizarán solos. Solo tienes que darles a Compile.

SUBIR tus cambios (PUSH)
Cuando tu bloque (cnt_seg, ctrl_reloj, etc.) funcione:


Preparar: git add . (El .gitignore ya evita que subas basura de ModelSim).

Guardar: git commit -m "Explicacion de lo que has hecho"

Subir: git push origin tu-nombre

⚠️ NOTA IMPORTANTE
Cualquier archivo .vhd nuevo que crees, hazlo dentro de la carpeta del repositorio. Así, cuando hagas push, se subirá correctamente y tus compañeros lo recibirán al hacer pull.