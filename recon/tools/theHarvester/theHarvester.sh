#!/bin/bash

echo "Список команд:"
echo "DO - поиск после настройки всего"
echo "HELP - вывод консоли помощи"
echo "DOMAIN - заполнить масив доменов (он обнуляется при вводе этой команды)"
echo "BACKEND - заполнить масив поисковых систем"
echo "LIST - количество результатов"
echo "FILE - настроить вывод в файл (ввести директорию файла//она будет создана во время запуска)"
echo "EX - выход"


true_variable=true
BASE_DIR=~/notes/recon/domain-enum/theHarvester
base_number=100
DOMAINS=("example.com")
SEARCH=("google")

while [ $true_variable ]; do
	echo "Введите команду" 
	read command
	
	if [ "$command" = "DOMAIN" ]; then
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
	elif [ "$command" = "BACKEND" ]; then
		#Пустой список для поисковиков
		SEARCH=()

		# Получение списка доменов
		echo "Количество поисковиков:"
		read number
		i=1
		while [ $i -le $number ]; do
			echo "Поисковик:"
			read name
			SEARCH+=("$name")
			((i++)) 
		done
	elif [ "$command" = "LIST" ]; then
		echo "Количество результатов"
		read input
		base_number=$input
	elif [ "$command" = "FILE" ]; then
		echo "Место сохранения файла"
		read input
		BASE_DIR="$input"
	elif [ "$command" = "HELP" ]; then
		theHarvester -h
	elif [ "$command" = "DO" ]; then
		# Проходим по каждому домену
		for domain in "${DOMAINS[@]}"; do
		    DOMAIN_DIR="$BASE_DIR/$domain"
		    mkdir -p "$DOMAIN_DIR"
		    
		    for search in "${SEARCH[@]}"; do
		    	echo "$domain searching by using $search"
		    	theHarvester -d "$domain" -b "$search" -l $base_number -f "$DOMAIN_DIR/theHarvester_$search.xml"
		    done
		done
		echo "[✔] Готово!" 
		
	elif [ "$command" = "EX" ]; then
		true_variable=false
	fi
done

