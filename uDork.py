#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys 
import json
import time
import argparse
from goop import goop
from colorama import Fore,Style
from cookie import cookie

# Variables
peticiones = 1

# Colores
red = '\033[91m'
green = '\033[92m'
white = '\033[97m'
yellow = '\033[93m'
bold = '\033[1m'
end = '\033[0m'

# Dorks
d_filetype = './dorks/filetype.txt'
d_intext = './dorks/intext.txt'
d_inurl = './dorks/inurl.txt'
d_global = './dorks/global.txt'
d_admin = './dorks/admin.txt'
d_directorios = './dorks/directorios.txt'
d_usernames = './dorks/usernames.txt'
d_passwords = './dorks/passwords.txt'
d_webservers = './dorks/webservers.txt'
d_archivos_vulnerables = './dorks/archivos_vulnerables.txt'
d_servidores_vulnerables = './dorks/servidores_vulnerables.txt'
d_mensajes_error = './dorks/mensajes_error.txt'
d_redes_vulnerables = './dorks/redes_vulnerables.txt'
d_portal_logins = './dorks/portal_logins.txt'
d_dispositivos = './dorks/dispositivos.txt'

# Funciones
# Logotipo de inicio
def banner_uDork():
	print("""                                                                
       _____             _    
      |  __ \           | |   
 _   _| |  | | ___  _ __| | __
| | | | |  | |/ _ \| '__| |/ /
| |_| | |__| | (_) | |  |   < 
 \__,_|_____/ \___/|_|  |_|\_\ %sv.2019.12.1
		by %sM3n0sD0n4ld%s
""" % (bold, red, end))

# Separador entre líneas
def separador():
	print("----------------------------------------------------------------------")

# Listado de dorks predefinidos
def listaDorks():
    print("""
 ======================== LISTADO DORKS ========================
 admin : Paneles de acceso de todo tipo (administración, login, CMS, ...)
 directorios : Directorios sensibles (drupal, wordpress, phpmyadmin...)
 usernames : Encuentra archivos que contienen nombres de usuarios.
 passwords : Encuentra archivos que contienen contraseñas.
 webservers: Encuentra servidores web.
 archivos_vulnerables : Encuentra archivos vulnerables. 
 servidores_vulnerables : Encuentra servidores vulnerables.
 mensajes_error : Muestra mensajes de error.
 redes_vulnerables : Encuentra datos de software en redes vulnerables.
 portal_logins : Enumera logins de portales.
 dispositivos :  Encuentra dispositivos conectados (impresoras, webcams, termostatos, ...)
""")

# Mensaje de error del menú
def banner_error():
	print("Error, faltan parámetros por pasar.")
	print("Escriba python3 uDork.py -h para más información.")

# Mensaje para dorks massivos
def msgMassive():
    print("%s[!]%s Los resultados irán apareciendo abajo. Esto tardará varios minutos, por favor espere..." % (red, end))
    print("")

# Cabecera resultado
def msgResult():
    print("Dominio/IP: %s%s%s" % (bold, url, end))
    print("Tipo de ficheros: %s%s%s" % (bold, dato, end))

# Devuelve la lista por su flag
def lista(dato):
	lista = {
            "all": d_filetype,
            "admin": d_admin,
		    "directorios": d_directorios,
		    "usernames": d_usernames,
		    "passwords": d_passwords,
		    "webservers": d_webservers,
		    "archivos_vulnerables": d_archivos_vulnerables,
		    "servidores_vulnerables": d_servidores_vulnerables,
		    "mensajes_error": d_mensajes_error,
		    "redes_vulnerables": d_redes_vulnerables,
		    "portal_logins": d_portal_logins,
		    "dispositivos": d_dispositivos
	}
	return lista.get(dato, "Error, no encuentra listado.")

# Algoritmo dork 
def search(url, dork, dato):
	print("Dominio/IP: %s%s%s" % (bold, url, end))
	print("Tipo de ficheros: %s%s%s" % (bold, dato, end))
	separador()
	for page in range(peticiones):
		result = goop.search(url, dork, dato, cookie, page=page, full=True)
		for each in result:
			print('%s' % (result[each]['url']))

# Algoritmo dork global
def searchGlobal(url, dork, dato):
    lastDato = None
    for page in range(peticiones):
        result = goop.search_all_dork(url, dork, dato, cookie, page=page, full=True)
        for each in result:
            if each != None:
                if dato != lastDato:
                    if lastDato != dato:
                        separador()
                    msgResult()
                print('%s' % (result[each]['url']))
                lastDato = dato

# Algoritmo dork masivos
def searchMassive(url, dato):
    lastDato = None
    for page in range(peticiones):
        result = goop.search_all_global(url, dato, cookie, page=page, full=True)
        for each in result:
            if each != None:
                if dato != lastDato:
                    if lastDato != dato:
                        separador()
                    msgResult()
                print('%s' % (result[each]['url']))
                lastDato = dato

# Ejecución del Script
banner_uDork()
separador()

# Menu
parser = argparse.ArgumentParser()
parser.add_argument("-d", "--domain", help="Dominio o dirección IP.")
parser.add_argument("-e", "--extension", help="Buscar archivos por extensión. Usa 'all' para buscar extensión de la lista.")
parser.add_argument("-t", "--text", help="Encuentra texto en el contenido del sitio web.")
parser.add_argument("-s", "--string", help="Localizar cadenas de texto dentro de la URL.")
parser.add_argument("-m", "--massive", help="Ataca a un sitio con una lista de dorks predefinida o personalizada. Revisar lista <-l/--list>")
parser.add_argument("-l", "--list", help="Muestra el listado de dorks predefinido (Exploit-DB).")
args = parser.parse_args()

# Ejecución uDork
if args.domain != None:
    url = args.domain
    if args.extension == 'all':
        msgMassive()
        f = open(d_filetype, 'r')
        for dato in f:
            dork = 'filetype'
            searchGlobal(url, dork, dato)
    elif args.extension != None:
        dork = 'filetype'
        dato = args.extension
        search(url, dork, dato)
    elif args.text != None:
        dork = 'intext'
        dato = args.text
        search(url, dork, dato)
    elif args.string != None:
        dork = 'inurl'
        dato = args.string
    elif args.massive == 'admin':
        msgMassive()
        dork = 'inurl'
        lista = lista(args.massive)
        f = open(lista, 'r')
        for dato in f:
            searchGlobal(url, dork, dato)
    elif args.massive != None:
        msgMassive()
        lista = lista(args.massive)
        f = open(lista, 'r')
        for dato in f:
            searchMassive(url, dato)
elif args.list != None:
    listaDorks()
else:
    banner_error()