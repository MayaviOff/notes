#!/bin/bash

echo "Список команд:"
echo "IP - ip адрес"
echo "SHORT - короткий вывод"
echo "FULL - максимум инфы"
echo "MX - mx записи"
echo "NS - ns записи"
echo "OWN - свой DNS"

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
BASE_DIR=~/notes/recon/domain-enum/dig

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
	    dig "$domain" > "$DOMAIN_DIR/digip.txt"

	    echo "Сохранено: $DOMAIN_DIR/dig.txt"
	done
elif [ "$command" = "FULL" ]; then
	# Проходим по каждому домену
	for domain in "${DOMAINS[@]}"; do
	    echo "[+] Обработка $domain..."

	    # Создаем папку для каждого домена
	    DOMAIN_DIR="$BASE_DIR/$domain"
	    mkdir -p "$DOMAIN_DIR"

	    # Сохраняем результат
	    dig "$domain" ANY > "$DOMAIN_DIR/digANY.txt"

	    echo "Сохранено: $DOMAIN_DIR/digANY.txt"
	done
elif [ "$command" = "SHORT" ]; then
	# Проходим по каждому домену
	for domain in "${DOMAINS[@]}"; do
	    echo "[+] Обработка $domain..."

	    # Создаем папку для каждого домена
	    DOMAIN_DIR="$BASE_DIR/$domain"
	    mkdir -p "$DOMAIN_DIR"

	    # Сохраняем результат
	    dig +short "$domain" > "$DOMAIN_DIR/digSHORT.txt"

	    echo "Сохранено: $DOMAIN_DIR/digSHORT.txt"
	done
elif [ "$command" = "MX" ]; then
	# Проходим по каждому домену
	for domain in "${DOMAINS[@]}"; do
	    echo "[+] Обработка $domain..."

	    # Создаем папку для каждого домена
	    DOMAIN_DIR="$BASE_DIR/$domain"
	    mkdir -p "$DOMAIN_DIR"

	    # Сохраняем результат
	    dig "$domain" MX > "$DOMAIN_DIR/digMX.txt"

	    echo "Сохранено: $DOMAIN_DIR/digMX.txt"
	done
elif [ "$command" = "NS" ]; then
	# Проходим по каждому домену
	for domain in "${DOMAINS[@]}"; do
	    echo "[+] Обработка $domain..."

	    # Создаем папку для каждого домена
	    DOMAIN_DIR="$BASE_DIR/$domain"
	    mkdir -p "$DOMAIN_DIR"

	    # Сохраняем результат
	    dig "$domain" NS > "$DOMAIN_DIR/digNS.txt"

	    echo "Сохранено: $DOMAIN_DIR/digNS.txt"
	done
elif [ "$command" = "OWN" ]; then
	# Проходим по каждому домену
	for domain in "${DOMAINS[@]}"; do
	    echo "[+] Обработка $domain..."
	    
	    echo "Сервер для $domain (типа @8.8.8.8):"
	    read server

	    # Создаем папку для каждого домена
	    DOMAIN_DIR="$BASE_DIR/$domain"
	    mkdir -p "$DOMAIN_DIR"

	    # Сохраняем результат
	    dig "$server" "$domain" > "$DOMAIN_DIR/digOWN.txt"

	    echo "Сохранено: $DOMAIN_DIR/digOWN.txt"
	done
fi

echo "[✔] Готово!"



