#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-.}"

echo "Convertiendo archivos de CRLF a LF en '$TARGET_DIR'..."

# Extensiones de texto comunes (ajusta según necesites)
TEXT_EXTENSIONS="\.(txt|md|py|js|html|css|json|xml|yml|yaml|sh|bat|c|cpp|h|java)$"

# Buscar solo archivos de texto que contengan CRLF
find "$TARGET_DIR" -type f -regex ".*$TEXT_EXTENSIONS" -print0 | \
while IFS= read -r -d '' file; do
  # Verificar si tiene CRLF antes de procesar
  if grep -q $'\r' "$file" 2>/dev/null; then
    sed -i 's/\r$//' "$file"
    echo "Procesado: $file"
  fi
done

echo "Conversión completada."