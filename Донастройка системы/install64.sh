#!/bin/bash
#
# Актуальность: декабрь 2024г.
# Пример для OS Linux Mint 22 "Wilma" Cinnamon Edition (64-bit).
# $ lsb_release -a
#
# Сделать данный файл install64.sh исполняемым и запустить сразу после установки Linux Mint, 
# для установки нужных репозиториев, пакетов и удаления ненужных.
# 
# Заметка:
# В зависимости от скорости скачивания и количества установок/обновлений пакетов,
# время выполнения может затянутся и пароль суперпользователя снова может понадобится ввести,
# так как он действителен в течении 15 минутного сеанса.
# Команды записаны специально отдельно, чтобы было легко редактировать или удалить ненужное.
# Вообще это скелет, который можно модифицировать как вам угодно добавляя нужные утилиты,
# удаляя ненужные и т.п., тоесть автоматически донастраивать свежеустановленную систему так,
# как вам нужно, не делая это всё в ручную.
#
# 1. Удаляем предустановленные и ненужные (по усмотрению) утилиты с их настройками из системы:
##############################################################################################
# Поскольку нет необходимости больше пользоваться нижеследующими утилитами в будущем, то незачем оставлять
# в системе файлы их настроек, поэтому для удаления используем sudo apt purge вместо sudo apt remove
# 
# pix - доп. программа просмотра изображений (Хватит и простой Xviewer)
# Thunderbird - почтовый клиент
# Warpinator - отправка и получение файлов по локальной сети
# rhythmbox - аудиоплеер
# webapp-manager - создавать десктопные приложения из страниц сайтов - хр*нь, короче!
# onboard - экранная клавиатура
# Timeshift - программа востановления системы из бэкапа (снимка) - Заметка:пока оставлю, надо попробовать её !
# sudo apt purge -y pix thunderbird warpinator rhythmbox webapp-manager onboard timeshift
# Не актуально для удаления (выпелено в новой редакции):
# vino - утилиту удалённого доступа к НАШЕМУ рабочему столу
# Redshift - утилита для автоматической смены цветовой температуры монитора, в зависимости от времени суток
# pidgin - утилиту мгновенных сообщений Pidgin
# GNote - заметки
# HexChat - IRC client based on XChat
# удалить extensions(расширения), cache и данные Firefox
# rm -rf ~/.mozilla
# файлы локализации firefox
# sudo apt purge firefox-locale-en firefox-locale-ru

# 2. Обновим систему:
#####################
# Обновим системные списки ссылок на пакеты, содержащихся в репозиториях:
sudo apt update
# Обновим установленные пакеты (и их зависимости), для которых в репозиториях доступны новые версии,
# и удаляем пакеты (зависимости), которые более ненужны:
sudo apt full-upgrade -y
# Устраним сбои (если такие есть) в базе пакетов, вызванные нарушениями зависимостей:
sudo apt install -f -y 
# Удалим оставшиеся конфиги от удалённых пакетов:
sudo aptitude purge ~c -y 
# Удалим архивные файлы .deb пакетов из локального репозитория:
sudo apt clean
# Удалим архивные файлы .deb пакетов из каталога /var/cache/apt/archives:
sudo apt autoclean

# 3. Решаем проблемы и недочёты (донастраиваем) Linux Mint:
###########################################################
# "Warning: No support for locale: ru_RU.utf8":
sudo locale-gen --purge --no-archive
# Добавляем две локали в систему, которые ИНОГДА по умолчанию не устанавливаются:
sudo locale-gen ru_RU.CP1251 ru_RU.KOI8-R
# Установим показ русскоязычной документации (манов) по команде man <пакет> (если они есть на русском) 
echo 'export MANOPT="-L ru"' >> ~/.bashrc

# 4. Установим необходимый софт/библиотеки, используя списки репозиториев системы:
##################################################################################
# Установим 32 битные библиотеки для разрешения неразрешённых зависимостей в 64 битной системе, это позволит,
# при возникновении необходимости, устанавливать и запускать 32 битные и gt приложения на 64 битной системе:
# sudo apt install -y ia32-libs libc6:i386
# Установим Microsoft True Type(ttf) шрифты: Andale Mono, Arial, Arial Black, Comic Sans MS, Courier New, Georgia, Impact, Times New Roman, Trebuchet, 
# Verdana, Webdings
sudo apt install -y ttf-mscorefonts-installer
#
# vim - редактор
# mc - Midnight Commander - консольный файловый менеджер
# kcolorchooser - пипетка выбора цветов и выбора цвета на экране (нажимать на каплю)
# kruler - экранная линейка
# inkscape - редактор векторной графики
# gparted - редактор разделов HDD
# filezilla - FileZilla Client (да, в репозитории не самая последняя версия, но ведь перед добавлением в репозиторий она протестированна и работает стабильно)
# libimage-exiftool-perl - утилита для удаление EXIF информации из изображений и фото
# whois - утилита получения сведений об IP или URL адресе ресурса (Пример: $ whois patsuckow.ru | less )
# tree - выводит дерево файлов и папок, а потом подсчитывает их количество по отдельности. Кроме того, утилита имеет множество опций и настроек.
# htop — консольный монитор системных ресурсов в реальном времени: посмотреть сколько оперативной памяти занято, процент использования процессора, какие процессы 
#        используют больше всего ресурсов системы, можно менять приоритеты процессов завершать их, выполнять поиск, фильтровать процессы по определенным 
#        параметрам, сортировать, а также смотреть потоки каждого процесса.
# brasero - запись CD/DVD-R/RW (обычных, загрузочных с iso), музыкальных дисков, клонирование дисков www.gnome.org/projects/brasero
# python3-venv - уилита для работы с виртуальным окружением в python3
# ark - графическая утилита-архиватор: tar, tar.bz2, tar.lz4, tar.lz, tar.lzma, tar.xz, tar.zst, tar.Z, zip и т.д.
# pwgen - консольный генератор паролей. Использование (рандомный, 18 символьный пароль, без символов O/0 и 1/I): pwgen -sB 18
# ffmpeg - A complete, cross-platform solution to record, convert and stream audio and video. https://ffmpeg.org/
# Cheese - утилита для получения снимков и видео с вашей вебкамеры
# kdenlive - видео редактор для Linux, для решения полупрофессиональных задач, с открытым исходным кодом, ориентированный на работу в окружении рабочего 
#            стола KDE. Для работы с видео используются другие проекты, такие как ffmpeg и mlt 
# vnstat - Учет трафика сетевого интерфейса https://electrichp.blogspot.com/2013/05/linux-vnstat.html
# obs-studio - захват видео скринкастов с экрана Linux, позволяет записывать видео с нескольких источников, в том числе с наложением картинки / возможна 
#              трансляция на все популярные платформы: YouTube, Twitch и другие
# fuse3 - FUSE library and header files - нужен для работы Cryptomator и Veracrypt на Linux Mint
# Audacity - запись и редактирование аудиофайлов (https://github.com/audacity/audacity) (https://www.audacityteam.org/download/linux/)
# Audacious - лёгкий аудиоплеер
# cpu-x - аналог виндовс cpu-z утилиты для получения информации о процессоре, материнке и т.п.
# kdiskmark - утилита тестирования скорости чтения/записи HDD, SSD, flash
# libgtk2.0-dev - библиотека gtk+2.0
# metadata-cleaner - позволяет просматривать метаданные в файлах и по возможности избавляться от них (https://metadatacleaner.romainvigier.fr/ )
# GIMP - фоторедактор (бесплатный аналог фотошоп)
# Putty - ssh-клиент
# GSmart Control - Проверка инфы из S.M.A.R.T. ATA и SATA HDD дисков, доки - https://gsmartcontrol.shaduri.dev/
sudo apt install -y filezilla mc kcolorchooser kruler inkscape gparted libimage-exiftool-perl whois tree htop brasero python3-pip python3-venv ark pwgen ffmpeg cheese kdenlive 
sudo apt install -y vnstat obs-studio fuse3 audacity audacious cpu-x kdiskmark gimp gsmartcontrol

# Установим Putty - ssh-клиент:
sudo add-apt-repository universe
sudo apt update
sudo apt install putty -y

# Прекратили поддержку на территории РФ:
# clamav - антивирусный сканер и его демона + clamtk - графическая оболочка к нему.
# freecad - бесплатная система 2D и 3D моделирования (куча роликов, документации и поддержкой python - https://www.freecad.org/?lang=ru ) --- ???
# xneur gxneur  --- ???

# wipe - утилита для безвозвратного удаления файлов? путём перезаписи содержимого файла и каталога случайными данными или нулями.
# установить зависимости для wipe и сам wipe
sudo apt install -y build-essential libgmp-dev
sudo apt install wipe
# Поскольку, по непонятной причине автор удалил репозиторий (https://github.com/magnumripper/wipe.git), то если wipe уже не будет устанавливать через apt, 
# сохранённую версию можно скачать из моего github:
# https://github.com/patsuckow/boxMiniTools/blob/main/%D0%9A%D1%80%D0%B8%D0%BF%D1%82%D0%BE%D0%B3%D1%80%D0%B0%D1%84%D0%B8%D1%8F/wipe_0.24-6_amd64.deb

# 5. Установим необходимый софт, используя ppa-репозитории:
###########################################################
# Cryptomator - кроссплатформенное средство резервного копирования с шифрованием для вашего облачного хранилища (Dropbox, Google Drive, OneDrive и любым 
# другим облачным сервисом хранения данных, синхронизирующимся с локальной папкой). Сайт - https://cryptomator.org
sudo add-apt-repository ppa:sebastian-stenzel/cryptomator -y && sudo apt update && sudo apt install cryptomator -y
# KeePassXC - кросплатформенный менеджер паролей (https://keepassxc.org/) ("живой" форк разработки от "мёртвой и не обновляющейся" KeePassX (https://www.keepassx.org/)
sudo add-apt-repository -y ppa:phoerious/keepassxc && sudo apt update && sudo apt install -y keepassxc
# Консольный git:
sudo apt add-repository ppa:git-core/ppa -y && sudo apt update && sudo apt install -y git
# DB Browser for SQLite (sqlitebrowser) для работы с БД SQLite3  (GUI версия)
sudo add-apt-repository -y ppa:linuxgndu/sqlitebrowser && sudo apt update && sudo apt install -y sqlitebrowser
# Boot-Repair - утилита для восстановления доступа к вашей операционной системе в случае сбоя загрузчика
# https://sourceforge.net/p/boot-repair/home/ru/
# https://help.ubuntu.com/community/Boot-Repair
# https://github.com/yannmrn/boot-repair
sudo add-apt-repository -y ppa:yannubuntu/boot-repair && sudo apt update && sudo apt install -y boot-repair
# Etcher (balena-etcher-electron) - утилита записи загрузочных ISO-образов на флешку - что-то сломались зависимости в новом Mint :(
# curl -1sLf 'https://dl.cloudsmith.io/public/balena/etcher/setup.deb.sh' | sudo -E bash
# sudo apt update & sudo apt install -y balena-etcher-electron
# Typora - A minimal Markdown reading & writing app / https://typora.io
#wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
#sudo add-apt-repository -y 'deb https://typora.io/linux ./'
#sudo apt update & sudo apt install -y typora
# Grub Customizer - утилита для настройки загрузчика системы - Windows может снести загрузчик своими обновлениями и потом восстановить - эти настройки будет невозможно! Поэтому - нафиг их.
# sudo add-apt-repository ppa:danielrichter2007/grub-customizer -y && sudo apt update && sudo apt install -y grub-customizer

# 6. Установка утилит, для обновления которых требуется наличие в системе крипто-ключей для их репозиториев:
#############################################################################################################
# Создадим скрытую папку в домашней директории пользователя (но с доступом только суперпользователя), где будем хранить скачанные ключи для репозиториев:
sudo mkdir ~/.crypto-keys

# Скачаем GPG ключ для VSCodium
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

# Добавим репозиторий VSCodium с указанием GPG ключа и архитектуры amd64
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list

# Обновим списки репозиториев, скачаем и установим VSCodium
sudo apt update && sudo apt install -y codium


# Syncthin - Утилита с открытым исходным кодом для синхронизации файлов между устройствами, не требующая центрального сервера. (https://apt.syncthing.net)
# Add the release PGP keys:
sudo mkdir -p /etc/apt/keyrings
sudo curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
# Add the "stable" channel to your APT sources. (The stable channel is updated with stable release builds, usually every first Tuesday of the month):
echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
# Update and install syncthing:
sudo apt update
# sudo apt -y install ca-certificates && apt-transport-https
sudo apt -y install syncthing
# Создадим скрипт для загрузки демона syncthing, при старте системы, чтобы сихронизация сразу заработала в фоне
# Путь к исполняемому файлу вашей утилиты (и специфические ключи для запуска)
APP_EXECUTABLE="/usr/bin/syncthing serve --no-browser --logfile=default"
# Название и описание вашей утилиты
APP_NAME="Start Syncthing"
APP_DESCRIPTION="Starts the main syncthing process in the background."
# Создаем .desktop файл в директории автозапуска
AUTOSTART_DIR="$HOME/.config/autostart"
DESKTOP_FILE="$AUTOSTART_DIR/syncthing.desktop"
mkdir -p "$AUTOSTART_DIR"
touch "$DESKTOP_FILE"
# Заполняем .desktop файл
echo "[Desktop Entry]" > "$DESKTOP_FILE"
echo "Type=Application" >> "$DESKTOP_FILE"
echo "Exec=$APP_EXECUTABLE" >> "$DESKTOP_FILE"
echo "Hidden=false" >> "$DESKTOP_FILE"
echo "NoDisplay=false" >> "$DESKTOP_FILE"
echo "X-GNOME-Autostart-enabled=true" >> "$DESKTOP_FILE"
echo "Name=$APP_NAME" >> "$DESKTOP_FILE"
echo "Comment=$APP_DESCRIPTION" >> "$DESKTOP_FILE"
echo "Icon=syncthing" >> "$DESKTOP_FILE"
echo "Terminal=false" >> "$DESKTOP_FILE"
echo "Categories=Network;FileTransfer;P2P" >> "$DESKTOP_FILE"
chmod +x "$DESKTOP_FILE"

# 7. Скачаем и установим deb пакеты:
####################################
# Создадим каталог uploads во временной папке системы:
sudo mkdir /tmp/uploads
# Скачаем пакеты:
#################
# TeamViewer - Пакет программного обеспечения для удалённого контроля компьютеров совместного использования,
#              обмена файлами между управляющей и управляемой машинами, видеосвязи и веб-конференций.
# sudo wget -P /tmp/uploads https://download.teamviewer.com/download/linux/teamviewer_amd64.deb

# Skype - для видеозвонков
# sudo wget -P /tmp/uploads https://go.skype.com/skypeforlinux-64.deb

# yt-dlp - форк youtube-dl с активной разработкой и поддержкой. Он также предлагает широкий набор 
#          функций и возможностей для загрузки видео с YouTube и других платформ.
sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
sudo chmod a+rx /usr/local/bin/yt-dlp

# На всякий случай проверим и устраним сломавшиеся зависимости:
sudo apt-get install -f
# Установим все скачанные .deb-пакеты:
# sudo dpkg -i /tmp/uploads/*.deb
# Удовлетворяем требуемые зависимости
sudo apt --fix-broken -y install

# 8. Установка с сайтов, через установочные ssh
###############################################
# Vivaldi браузер - увы, не поддерживает LESS и значит нельзя смотреть ютуб через прокси :(
# sudo wget -P /tmp/uploads https://downloads.vivaldi.com/snapshot/install-vivaldi.sh
# sh /tmp/uploads/install-vivaldi.sh
# Удаляем каталог uploads из временной папки со всем содержимым
# sudo rm -rf /tmp/uploads
#
# Установим pyenv - утилиту для управления несколькими версиями Python на одной системе.
curl https://pyenv.run | bash
# Теперь обновим настройки оболочки
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
source ~/.bashrc
# Решение проблем (с установкой pyenv)
sudo apt install libedit-dev libncurses5-dev libssl-dev zlib1g zlib1g-dev libssl-dev libbz2-dev libsqlite3-dev lzma -y
# Установим несколько последних версий Python с помощью pyenv
#pyenv install -v 3.10.13
pyenv install -v 3.11.7
pyenv install -v 3.12.0
# Установим версию Python 3.12.0 как глобальную в сисеме
pyenv global 3.12.0

# 9. Flatpak и Flathub
# Установить Flatpak и Flathub
# sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# Установим Obsidian (инструмент для локальной работы с набором файлов Markdown) через Flatpak
## flatpak install flathub io.obsidian.Obsidian  ---???
# mmex - менеджер личных финансов
flatpak install flathub org.moneymanagerex.MMEX -y
# whatsapp-desktop - неофициальный десктопный клиентдля whatsapp
flatpak install flathub io.github.mimbrero.WhatsAppDesktop -y

# 10. PIP - пакетный менеджер для python
########################################
# Обновляем его
pip install --upgrade pip

# 11. Скачаем исходники, скомпилируем и установим софт:
# VeraCrypt - наследник TrueCrypt (Disk encryption with strong security based on TrueCrypt)
# https://github.com/veracrypt/VeraCrypt.git
# https://git.code.sf.net/p/veracrypt/code
# https://bitbucket.org/veracrypt/veracrypt.git
# sudo apt update
# sudo apt install -y build-essential yasm fuse pkg-config libpcsclite-dev libncurses-dev libpam0g-dev
# libwxgtk3.0-gtk3-dev
# cd ~/ && git clone https://bitbucket.org/veracrypt/veracrypt.git
# cd ~/veracrypt/src && make
# sudo make install
# sudo rm -rf ~/veracrypt

# 12. Установим TLS сертификаты МИНЦИФРЫ для безопасного входа на гос.сайты (типа ГосУслуг) и сайты Российских банков, типа Сбера
cd /usr/local/share/ca-certificates/
sudo -s
# скачать корневой сертификат:
wget https://gu-st.ru/content/lending/russian_trusted_root_ca_pem.crt
# скачать выпускающий сертификат:
wget https://gu-st.ru/content/lending/russian_trusted_sub_ca_pem.crt
# обновить системное хранилище сертификатов:
update-ca-certificates
# Проверить установку сертификатов (должны появится строки: label: Russian Trusted Root CA и label: Russian Trusted Sub CA):
trust list | grep Russian

# После всех установок/обновлений/удалений:
##############################################
# Обновим списки пакетов, содержащихся в репозиториях
# Обновим пакеты, установленные в системе (и их зависимости), для которых в репозиториях доступны новые версии
sudo apt update && sudo apt full-upgrade -y
# Удаляем пакеты (зависимости), которые более ненужны
sudo apt-get install -f -y
# Обновим пакеты, которые требуют разрешения зависимостей (установки дополнительных/удаления конфликтующих пакетов)
sudo apt dist-upgrade -y 
# Устраним сбои (если такие есть) в базе пакетов, вызванные нарушениями зависимостей
sudo apt install -f -y 
# Удалим оставшиеся конфиги от удалённых пакетов
sudo aptitude -y purge ~c 
# Удалим архивные файлы .deb пакетов из локального репозитория
sudo apt clean -y
# Удалим архивные файлы .deb пакетов из каталога /var/cache/apt/archives
sudo apt autoclean -y

# Установим правильную смену раскладки клавиатуры
# echo "setxkbmap -layout us,ru -option grp:alt_shift_toggle" >> ~/.bashrc

# Перезагрузим систему, через 1 минуту:
shutdown -r +1

exit 0
