#!/bin/bash

read -p "Введите адрес для пинга или пустую строку (по умолчанию google.com): " HOST

if [ -z "$HOST" ]; then
  HOST="google.com"
  echo "Пинг: $HOST"
fi

failCounter=0

while true; do
  #pingResp=$(ping -c 1 -W1 "$HOST")
  #echo "$pingResp"

  ms=$(ping -c 1 "$HOST" | grep "time=" | awk -F'time=' '{print $2}' | awk '{print int($1)}')

  if [[ -n "$ms" ]]; then

    failCounter=0
    if (( ms > 100 )); then
      echo "Задержка больше 100 мс. Пинг $ms мс"
    
    else
	echo "Пинг для $HOST меньше 100мс"
    fi	
  else
    ((failCounter++))

    if (( failCounter >= 3 )); then
      echo "3 подряд неудачных пинга"
      break
    fi
  fi

  sleep 1
done
