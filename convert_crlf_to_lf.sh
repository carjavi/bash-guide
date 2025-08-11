#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-.}"

echo "Convirtiendo CRLF -> LF en '$TARGET_DIR'..."

find "$TARGET_DIR" -type f \( \
  -iname "*.txt" -o \
  -iname "*.md" -o \
  -iname "*.py" -o \
  -iname "*.js" -o \
  -iname "*.html" -o \
  -iname "*.css" -o \
  -iname "*.json" -o \
  -iname "*.xml" -o \
  -iname "*.yml" -o \
  -iname "*.yaml" -o \
  -iname "*.sh" -o \
  -iname "*.bat" -o \
  -iname "*.c" -o \
  -iname "*.cpp" -o \
  -iname "*.h" -o \
  -iname "*.java" -o \
  -iname "*.php" -o \
  -iname "*.rb" -o \
  -iname "*.go" -o \
  -iname "*.rs" -o \
  -iname "*.ts" -o \
  -iname "*.jsx" -o \
  -iname "*.tsx" -o \
  -iname "*.vue" -o \
  -iname "*.sql" -o \
  -iname "*.conf" -o \
  -iname "*.cfg" -o \
  -iname "*.ini" -o \
  -iname "*.log" \
\) -print0 | \
while IFS= read -r -d '' file; do
  sed -i 's/\r$//' "$file"
  echo "Procesado: $file"
done

echo "Conversión completada."

# Auto-eliminar el script después de terminar
SCRIPT_PATH="$(realpath "$0")"
SCRIPT_NAME="$(basename "$SCRIPT_PATH")"
if [[ "$SCRIPT_NAME" == "convert_crlf_to_lf.sh" || "$SCRIPT_NAME" == "convert_crlf_to_lf_robust.sh" ]]; then
  rm "$SCRIPT_PATH"
fi