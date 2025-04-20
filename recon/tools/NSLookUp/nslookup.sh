#!/bin/bash

echo "Список команд:"
echo "IP - ip адрес"
echo "DNS - конкертный днс"
echo "MX - mx записи"
echo "NS - ns записи"

#Пустой список для доменов
DOMAINS=()

# Получение списка доменов
echo "Количество доменов:"
read number
i=1
while [ $i -le $number ]; do
	echo "Домен:"
	read name
	DOMAINS+=("$name")
	((i++)) 
done

# Основная папка для сохранения результатов
BASE_DIR=~/notes/recon/domain-enum/nslookup

# Создание основной папки, если ее нет еще
mkdir -p "$BASE_DIR"

# Принятие команды
echo "Введи команду:"
read command 

if [ "$command" = "IP" ]; then
	# Проходим по каждому домену
	for domain in "${DOMAINS[@]}"; do
	    echo "[+] Обработка $domain..."

	    # Создаем папку для каждого домена
	    DOMAIN_DIR="$BASE_DIR/$domain"
	    mkdir -p "$DOMAIN_DIR"

	    # Сохраняем результат
	    nslookup "$domain" > "$DOMAIN_DIR/nslookupip.txt"

	    echo "Сохранено: $DOMAIN_DIR/nslookupip.txt"
	done
elif [ "$command" = "DNS" ]; then
	# Проходим по каждому домену
	for domain in "${DOMAINS[@]}"; do
	    echo "[+] Обработка $domain..."
	    
	    echo "Сервер для $domain (типа 8.8.8.8):"
	    read server

	    # Создаем папку для каждого домена
	    DOMAIN_DIR="$BASE_DIR/$domain"
	    mkdir -p "$DOMAIN_DIR"

	    # Сохраняем результат
	    nslookup "$domain" "$server"> "$DOMAIN_DIR/nslookupDNS.txt"

	    echo "Сохранено: $DOMAIN_DIR/nslookupDNS.txt"
	done
elif [ "$command" = "MX" ]; then
	# Проходим по каждому домену
	for domain in "${DOMAINS[@]}"; do
	    echo "[+] Обработка $domain..."

	    # Создаем папку для каждого домена
	    DOMAIN_DIR="$BASE_DIR/$domain"
	    mkdir -p "$DOMAIN_DIR"

	    # Сохраняем результат
	    nslookup -query=mx "$domain" > "$DOMAIN_DIR/nslookupMX.txt"

	    echo "Сохранено: $DOMAIN_DIR/nslookupMX.txt"
	done
elif [ "$command" = "NS" ]; then
	# Проходим по каждому домену
	for domain in "${DOMAINS[@]}"; do
	    echo "[+] Обработка $domain..."

	    # Создаем папку для каждого домена
	    DOMAIN_DIR="$BASE_DIR/$domain"
	    mkdir -p "$DOMAIN_DIR"

	    # Сохраняем результат
	    nslookup -query=ns "$domain" > "$DOMAIN_DIR/nslookupNS.txt"

	    echo "Сохранено: $DOMAIN_DIR/nslookupNS.txt"
	done
fi

echo "[✔] Готово!"



