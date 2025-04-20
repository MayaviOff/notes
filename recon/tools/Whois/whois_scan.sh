#!/bin/bash

# Список доменов менять тут
DOMAINS=("jut.su" "lanet.ua")

# Основная папка для сохранения результатов
BASE_DIR=~/notes/recon/domain-enum/WhoIs

# Создание основной папки, если ее нет еще
mkdir -p "$BASE_DIR"

# Проходим по каждому домену
for domain in "${DOMAINS[@]}"; do
    echo "[+] Обработка $domain..."

    # Создаем папку для каждого домена
    DOMAIN_DIR="$BASE_DIR/$domain"
    mkdir -p "$DOMAIN_DIR"

    # Сохраняем результат whois
    whois "$domain" > "$DOMAIN_DIR/whois.txt"

    echo "    ↳ Сохранено: $DOMAIN_DIR/whois.txt"
done

echo "[✔] Готово!"
