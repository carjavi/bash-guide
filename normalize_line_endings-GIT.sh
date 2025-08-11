#!/bin/bash
set -e

# 1. Crear archivo .gitattributes en la raíz del repositorio
cat > .gitattributes << 'EOF'
# Normalización automática de archivos de texto
* text=auto

# Fuerza finales LF para scripts bash
*.sh text eol=lf
EOF

echo "✔ Archivo .gitattributes creado."

# 2. Agregarlo al control de versiones
git add .gitattributes

# 3. Aplicar renormalización a todos los archivos existentes
git add --renormalize .

echo "✔ Renormalización aplicada a todos los archivos (checkout + index)."

# 4. Mostrar estado actual de los archivos modificados
git status

echo
echo "Ahora revisa los cambios y, si todo está bien, commitea con:"
echo "  git commit -m \"Normalize line endings via .gitattributes\""
echo
echo "Con esto aseguras que todos los scripts .sh y archivos de texto usan finales de línea LF, evitando problemas en Linux."
