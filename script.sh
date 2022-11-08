#! /bin/bash
#FORTIFICACION DE UN SISTEMA LINUX
#Declare Colors
NC='\033[0m'
RED='\033[0;31m' #error
YELLOW='\033[0;33m' #ask
GREEN='\033[0;32m' #success
BLUE='\033[0;34m' #process
PS3='Selecciona una opción: '

#Start Menu
echo $'\n'Menú: $'\n'
options=("Crear Admin" "Crear un usuario" "Crear múltiples usuarios" "Ver usuarios" "Buscar usuario" "Salir")
select opt in "${options[@]}"
do
	case $opt in
		"Crear Admin")
			echo Ingresando a la opcion 1 - Crear un admin... $'\n'
			sleep 2
			echo Ingresa el grupo al que pertenecerá el admin: 
			read grupo
			sleep 1
			echo Ingresa el nombre de admin a crear: 
			read usuario
			sleep 1
			echo Ingresa la contraseña del admin: 
			read passwrd
			sleep 1
			echo Re-ingresa la contraseña del admin: 
			read passwrd2
			printf "${BLUE}Validando contraseñas...${NC}\n"
			sleep 5
			if [ $passwrd != $passwrd2 ]
			then
				printf "${RED}Las contraseñas de admin no coinciden.${NC}\n"
				printf "${YELLOW}Intenta de nuevo...${NC}\n"
			else
				printf "${GREEN}Las contraseñas coinciden!${NC}\n"
				printf "${YELLOW}La información de admin es correcta?\n"
				echo Grupo: $grupo
				echo Usuario: $usuario
				echo Contraseña: $passwrd
				printf "1) Si\n"
				printf "2) No ${NC}\n"
				read answer
				if [ $answer == 1 ]
				then
					resp=$(getent group $grupo)
					if [ -z "$resp" ]
					then
						printf "${GREEN}El grupo $grupo no existe.${NC}\n"
						sudo groupadd $grupo
					else
						printf "${RED}El grupo $grupo ya existe.${NC}\n"
					fi
					resp2=$(getent passwd $usuario)
					if [ -z "$resp2" ]
					then
						printf "${GREEN}El admin $usuario no existe.${NC}\n"
						sudo useradd $usuario -p $passwrd -g $grupo
						sudo usermod -aG sudo $usuario
						printf "${GREEN}Admin $usuario registrado con exito!${NC}\n"
					else
						printf "${RED}El admin $usuario ya existe.${NC}\n"
					fi
				elif [ $answer == 2 ]
				then
					printf "${RED}Cancelando procedimiento...${NC}\n"
					sleep 3
					printf "${RED}Intenta de nuevo.${NC}\n"
				else
					printf "${RED}Opcion inválida.${NC}\n"
					sleep 3
					printf "${RED}Intenta de nuevo.${NC}\n"
				fi
			fi
			sleep 2
			;;
		"Crear un usuario")
			echo Ingresando a la opcion 2 - Crear un usuario... $'\n'
			sleep 2
			echo Ingresa el grupo al que pertenecerá el usuario: 
			read grupo
			sleep 1
			echo Ingresa el nombre de usuario a crear: 
			read usuario
			sleep 1
			echo Ingresa la contraseña del usuario: 
			read passwrd
			sleep 1
			echo Re-ingresa la contraseña del usuario: 
			read passwrd2
			printf "${BLUE}Validando contraseñas...${NC}\n"
			sleep 5
			if [ $passwrd != $passwrd2 ]
			then
				printf "${RED}Las contraseñas no coinciden.${NC}\n"
				printf "${YELLOW}Intenta de nuevo...${NC}\n"
			else
				printf "${GREEN}Las contraseñas coinciden!${NC}\n"
				printf "${YELLOW}La información es correcta?\n"
				echo Grupo: $grupo
				echo Usuario: $usuario
				echo Contraseña: $passwrd
				printf "1) Si\n"
				printf "2) No ${NC}\n"
				read answer
				if [ $answer == 1 ]
				then
					resp=$(getent group $grupo)
					if [ -z "$resp" ]
					then
						printf "${GREEN}El grupo $grupo no existe.${NC}\n"
						sudo groupadd $grupo
						printf "${GREEN}Grupo $grupo registrado con exito!${NC}\n"
					else
						printf "${RED}El grupo $grupo ya existe.${NC}\n"
					fi
					resp2=$(getent passwd $usuario)
					if [ -z "$resp2" ]
					then
						printf "${GREEN}El usuario $usuario no existe.${NC}\n"
						sudo useradd $usuario -p $passwrd -g $grupo
						printf "${GREEN}Usuario $usuario registrado con exito!${NC}\n"
					else
						printf "${RED}El usuario $usuario ya existe.${NC}\n"
					fi
				elif [ $answer == 2 ]
				then
					printf "${RED}Cancelando procedimiento...${NC}\n"
					sleep 3
					printf "${RED}Intenta de nuevo.${NC}\n"
				else
					printf "${RED}Opcion inválida.${NC}\n"
					sleep 3
					printf "${RED}Intenta de nuevo.${NC}\n"
				fi
			fi
			sleep 2
			;;
			
		"Crear múltiples usuarios")
			echo Ingresando a la opcion 3 - Crear múltiples usuarios... $'\n'
			echo Ingresa el grupo al que pertenecerán los usuarios: 
			read grupo
			sleep 1
			echo Ingresa el último usuario a crear: 
			read y
			echo Ingresa a partir de qué usuario crear: 
			read z
			zero=0
			resp=$(getent group $grupo)
			if [ -z "$resp" ]
			then
				printf "${GREEN}El grupo $grupo no existe.${NC}\n"
				sudo groupadd $grupo
				printf "${GREEN}Grupo $grupo registrado con exito!${NC}\n"
			else
				printf "${RED}El grupo $grupo ya existe.${NC}\n"
			fi
			if [[ $grupo == 'soporte' ]]
			then
				grupo='soporte'
				grupito='soporte'
				pass='SEGRED00so'
				
			elif [[ $grupo == 'mantenimiento' ]]
			then
				grupo='mantenimiento'
				grupito='mtto'
				pass='SEGRED00mtto'
			fi
			echo $grupo
			echo $grupito
			for (( x=z; x<=$y; x++ ))
				do  	
					if (( x < 10 ))
				  	then
				  		passwrd=$pass
				  		usuario=$grupito$zero$x
				  		passwrd=$passwrd$zero$x
						sleep 1
						resp2=$(getent passwd $usuario)
						if [ -z "$resp2" ]
						then
							printf "${GREEN}El usuario $usuario no existe.${NC}\n"
							sudo useradd $usuario -p $passwrd -g $grupo
							printf "${GREEN}Usuario $usuario registrado con exito!${NC}\n"
						else
							printf "${RED}El usuario $usuario ya existe.${NC}\n"
						fi
					else	
						passwrd=$pass
						usuario=$grupito$x
						passwrd=$passwrd$x
						sleep 1
						resp2=$(getent passwd $usuario)
						if [ -z "$resp2" ]
						then
							printf "${GREEN}El usuario $usuario no existe.${NC}\n"
							sudo useradd $usuario -p $passwrd -g $grupo
							printf "${GREEN}Usuario $usuario registrado con exito!${NC}\n"
						else
							printf "${RED}El usuario $usuario ya existe.${NC}\n"
						fi
					fi
				done
			;;
			
		"Ver usuarios")
			echo Ingresando a la opcion 4 - Ver usuarios... $'\n'
			sleep 2
			cat /etc/passwd 
			;;
			
		"Buscar usuario")
			echo Ingresando a la opcion 5  - Buscar usuario... $'\n'
			sleep 2
			echo Ingresa el nombre de usuario a buscar: 
			read search
			printf "${BLUE}Buscando usuario...${NC}"
			echo $'\n'
			sleep 5
			printf "${GREEN}"
			grep $search /etc/passwd | grep . || printf "${RED}El usuario $search no existe.${NC}\n"
			printf "${NC}\n"
			;;
			
		"Salir")
			printf "${BLUE}Guardando y saliendo...${NC}\n"
			sleep 5
			printf "${GREEN}Haz salido de forma exitosa!${NC}"
			echo $'\n'
			break
			;;
		*) echo Opcion inválida '->' $REPLY  $'\n';;
	esac
done