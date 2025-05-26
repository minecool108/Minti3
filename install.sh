#!/bin/bash

# ==========================================
# Автоматический установщик i3wm + Polybar
# ==========================================

# --- Настройки (можно менять) ---
CONFIG_SOURCE_DIR="./configs"         # Папка с вашими конфигами
MONITOR="Virtual-1"                      # Ваш основной монитор

# --- Цвета для вывода ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# --- Проверка прав ---
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Запустите скрипт с sudo!${NC}"
  exit 1
fi

# --- Шаг 1: Установка зависимостей ---
echo -e "${YELLOW}[1/5] Устанавливаем пакеты...${NC}"
apt update && apt install -y \
  i3 polybar rofi feh picom \
  fonts-jetbrains-mono fonts-font-awesome \
  x11-xkb-utils zenity xdotool lm-sensors \
  pulseaudio-utils network-manager-gnome \
  mint-themes mint-y-icons mint-x-icons \
  dunst blueman xfce4-power-manager \
  gnome-terminal nemo xed firefox pavucontrol

# --- Шаг 2: Создаем структуру папок ---
echo -e "${YELLOW}[2/5] Создаем директории...${NC}"
mkdir -p ~/.config/{i3,polybar,picom,rofi}

# --- Шаг 3: Копируем конфиги ---
echo -e "${YELLOW}[3/5] Копируем файлы...${NC}"

# i3wm
cp "$CONFIG_SOURCE_DIR/i3.config" ~/.config/i3/config
sed -i "s/HDMI-A-1/$MONITOR/g" ~/.config/i3/config

# Polybar
cp "$CONFIG_SOURCE_DIR/polybar.ini" ~/.config/polybar/config.ini
cp "$CONFIG_SOURCE_DIR/keyboard-layout.sh" ~/.config/polybar/
cp "$CONFIG_SOURCE_DIR/power-menu.sh" ~/.config/polybar/

# Picom
cp "$CONFIG_SOURCE_DIR/picom.conf" ~/.config/picom/

# Rofi
cp "$CONFIG_SOURCE_DIR/rofi.rasi" ~/.config/rofi/config.rasi

# --- Шаг 4: Права доступа ---
echo -e "${YELLOW}[4/5] Настраиваем права...${NC}"
chmod +x ~/.config/polybar/*.sh
chown -R $SUDO_USER:$SUDO_USER ~/.config

# --- Шаг 5: Финал ---
echo -e "${YELLOW}[5/5] Завершаем настройку...${NC}"
sudo -u $SUDO_USER gsettings set org.cinnamon.desktop.interface gtk-theme 'Mint-Y-Dark'
sudo -u $SUDO_USER gsettings set org.cinnamon.desktop.interface icon-theme 'Mint-Y'

echo -e "${GREEN}
===================================
Всё готово! Перезагрузите i3 (Mod+Shift+R)
Или перезапустите систему.
===================================${NC}"