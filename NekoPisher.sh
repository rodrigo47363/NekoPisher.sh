#!/bin/bash

# Script de Phishing para pruebas de seguridad

set -e

# Configuración de variables
REPO_URL="https://github.com/rodrigo47363/NekoPisher.sh/raw/main/NekoPisher.sh"
SCRIPT_NAME="NekoPisher.sh"
LOCAL_PATH="/usr/local/bin/$SCRIPT_NAME"

# Colores para el output
RED="\033[0;31m"
GREEN="\033[0;32m"
NC="\033[0m" # Sin color

# Función para mostrar la ayuda
function show_help() {
    echo -e "${GREEN}Uso:${NC} sudo ./NekoPisher.sh [opción]"
    echo -e "Opciones disponibles:"
    echo -e "  --email   : Iniciar una campaña de phishing por correo electrónico."
    echo -e "  --web     : Iniciar una campaña de phishing con páginas de inicio de sesión falsas."
    echo -e "  --update  : Actualizar NekoPisher.sh desde GitHub."
    echo -e "  --help    : Mostrar esta ayuda."
}

# Función para verificar y instalar dependencias
function check_and_install_dependencies() {
    local missing_deps=()
    for dep in curl git wget php; do
        if ! command -v $dep &> /dev/null; then
            echo -e "${RED}Error:${NC} La dependencia ${dep} no está instalada."
            missing_deps+=($dep)
        fi
    done
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo -e "${GREEN}Instalando dependencias faltantes...${NC}"
        sudo apt update
        sudo apt install -y "${missing_deps[@]}"
    fi
}

# Función para mostrar el menú principal
function mostrar_menu() {
    clear
    echo "#############################################################"
    echo "#                                                           #"
    echo "#             NekoPisher.sh                                 #"
    echo "#             Versión 1.0                                   #"
    echo "#             https://github.com/rodrigo47363/NekoPisher.sh #"
    echo "#############################################################"
    echo
    echo "Seleccione una opción:"
    echo "1. Iniciar phishing por correo electrónico"
    echo "2. Iniciar phishing con páginas de inicio de sesión falsas"
    echo "3. Actualizar NekoPisher.sh desde GitHub"
    echo "4. Salir"
    read -p "Opción: " option
    case $option in
        1)
            echo -e "${GREEN}Iniciando phishing por correo electrónico...${NC}"
            # Aquí puedes implementar el código para iniciar el phishing por correo electrónico
            ;;
        2)
            web_phishing
            ;;
        3)
            update_script
            ;;
        4)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo -e "${RED}Opción no válida.${NC}"
            mostrar_menu
            ;;
    esac
}

# Función para actualizar el script desde GitHub
function update_script() {
    echo -e "${GREEN}Actualizando NekoPisher.sh desde GitHub...${NC}"
    wget -q "$REPO_URL" -O "$LOCAL_PATH"
    echo -e "${GREEN}Actualización completada.${NC}"
}

# Función para configurar la campaña de phishing con páginas falsas
function web_phishing() {
    echo -e "${GREEN}Configurando campaña de phishing con páginas falsas...${NC}"
    # Aquí puedes implementar el código para clonar páginas de inicio de sesión y lanzarlas
}

# Función de manejo de señales
function trap_ctrl_c() {
    echo -e "${RED}\nInterrupción detectada. Saliendo...${NC}"
    exit 1
}

# Configurar manejo de señales
trap trap_ctrl_c SIGINT

# Verificar que el script se ejecute como root
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}Este script debe ejecutarse como root.${NC}"
    exit 1
fi

# Verificar y instalar dependencias
check_and_install_dependencies

# Manejar argumentos pasados al script
if [ $# -gt 0 ]; then
    case $1 in
        --email)
            echo -e "${GREEN}Iniciando phishing por correo electrónico...${NC}"
            # Aquí puedes implementar el código para iniciar el phishing por correo electrónico
            ;;
        --web)
            web_phishing
            ;;
        --update)
            update_script
            ;;
        --help)
            show_help
            ;;
        *)
            echo -e "${RED}Opción no válida.${NC}"
            show_help
            exit 1
            ;;
    esac
else
    mostrar_menu
fi
