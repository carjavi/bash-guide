#!/usr/bin/env bash
set -Eeuo pipefail

# Si ocurre un error, muestra el comando que falló y sale.
trap 'echo "Error en la línea $LINENO ejecutando: $BASH_COMMAND"; exit 1' ERR

# Verifica que estamos dentro de un repo git
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: este directorio no es un repositorio Git."
  exit 1
fi

# 1) Forzar LF en todos los archivos de texto mediante .gitattributes
printf '* text eol=lf\n' > .gitattributes
echo "Agregando .gitattributes..."
git add .gitattributes

# 2) Renormalizar el contenido ya rastreado (convierte CRLF -> LF en el índice)
echo "Renormalizando archivos rastreados... (esto puede tardar)"
git add --renormalize .

# 3) Crear commit solo si hay cambios
if git diff --cached --quiet; then
  echo "No hay cambios para commitear."
else
  echo "Creando commit de normalización..."
  git commit -m "Enforce LF line endings"
fi

# 4) Configuración global recomendada para evitar CRLF en commits
echo "Configurando Git globalmente: core.autocrlf=input, core.safecrlf=true"
git config --global core.autocrlf input   # convierte CRLF->LF al commitear, no toca el checkout
git config --global core.safecrlf true    # rechaza commits con finales de línea inseguros

# 5) Verificación rápida (working tree)
if command -v file >/dev/null 2>&1; then
  echo "Verificando archivos con CRLF en el working tree..."
  if git ls-files -z | xargs -0 file | grep -q CRLF; then
    echo "Advertencia: algunos archivos rastreados aún reportan CRLF en el working tree."
    echo "Si necesitas convertirlos, usa sed/dos2unix y vuelve a commitear."
  else
    echo "OK: no hay CRLF en archivos rastreados."
  fi
else
  echo "Nota: 'file' no está disponible; omito la verificación del working tree."
fi

# 6) Push automático al remoto
current_branch="$(git rev-parse --abbrev-ref HEAD)"
if git rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1; then
  echo "Haciendo push a la rama upstream configurada..."
  git push
else
  default_remote="$(git remote 2>/dev/null | head -n1 || true)"
  if [[ -n "$default_remote" && "$current_branch" != "HEAD" ]]; then
    echo "No hay upstream. Haciendo push con -u a '$default_remote' $current_branch..."
    git push -u "$default_remote" "$current_branch"
  else
    echo "No hay remoto configurado o estás en detached HEAD. Omite push."
    echo "Configura un remoto y ejecuta: git push -u origin <rama>"
  fi
fi

echo "Listo."