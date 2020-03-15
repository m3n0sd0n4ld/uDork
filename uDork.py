#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys 
import json
import time
import argparse
from goop import goop
from cookie import cookie

# Colors
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

# Functions
# Logotype 
def banner_uDork():
	print("""                                                                
       _____             _    
      |  __ \           | |   
 _   _| |  | | ___  _ __| | __
| | | | |  | |/ _ \| '__| |/ /
| |_| | |__| | (_) | |  |   < 
 \__,_|_____/ \___/|_|  |_|\_\ %sv.2020.03.13
		by %sM3n0sD0n4ld%s - (%s@David_Uton%s)%s
""" % (bold, red, white, yellow, white, end))

# Separator
def separador():
	print("----------------------------------------------------------------------------------------------------")

# Dorks listing
def listaDorks():
    print("""
 ======================== DORKS LISTING ========================
 admin : Access panels of all kinds (administration, login, CMS, ...)
 directories : Sensitive directories (drupal, wordpress, phpmyadmin ...)
 usernames : Find files containing user names.
 passwords : Find files that contain passwords.
 webservers: Find web servers.
 vulnerable_files : Find vulnerable files. 
 vulnerable_servers : Find vulnerable servers.
 error_messages : Show error messages.
 vulnerable_networks : Find software data on vulnerable networks.
 portal_logins : List portal logins.
 devices :  Find connected devices (printers, webcams, thermostats, ...)
""")

# Error menu message
def banner_error():
	print("Error, missing parameters to pass.")
	print("Type python3 uDork.py -h for more information.")

# Error message
def msgError():
	print("An error occurred while passing the parameters, check the inserted data.")

# Massive message
def msgMassive():
    print("%s[!]%s The results will appear below. This may take several minutes, please wait ..." % (red, end))

# Result message
def msgResult(url, dato):
    if args.output != None:
        output("----------------------------------------------------------------------------------------------------")
        output("Domain/IP: %s%s%s" % (bold, url, end))
        output("Find links with: %s%s%s" % (bold, dato, end))
    separador()
    print("Domain/IP: %s%s%s" % (bold, url, end))
    print("Find links with: %s%s%s" % (bold, dato, end))

# Dorks listing
def lista(dato):
	lista = {
            "all": d_filetype,
            "admin": d_admin,
		    "directories": d_directorios,
		    "usernames": d_usernames,
		    "passwords": d_passwords,
		    "webservers": d_webservers,
		    "vulnerable_files": d_archivos_vulnerables,
		    "vulnerable_servers": d_servidores_vulnerables,
		    "error_messages": d_mensajes_error,
		    "vulnerable_networks": d_redes_vulnerables,
		    "portal_logins": d_portal_logins,
		    "devices": d_dispositivos
	}
	return lista.get(dato, "Error, can't find listing.")

# Dork default
def search(url, dork, dato):
    msgResult(url, dato)
    separador()
    for page in range(peticiones()):
        result = goop.search(url, dork, dato, cookie, page=page, full=True)
        for each in result:
            if args.output != None:
                output(result[each]['url'])
            print('%s' % (result[each]['url']))

# Dork global
def searchGlobal(url, dork, dato):
    lastDato = None
    for page in range(peticiones()):
        result = goop.search_all_dork(url, dork, dato, cookie, page=page, full=True)
        for each in result:
            if each != None:
                if dato != lastDato:
                    msgResult(url, dato)
                if args.output != None:
                    output(result[each]['url'])
                print('%s' % (result[each]['url']))
                lastDato = dato

# Dork massive
def searchMassive(url, dato):
    lastDato = None
    for page in range(peticiones()):
        result = goop.search_all_global(url, dato, cookie, page=page, full=True)
        for each in result:
            if each != None:
                if dato != lastDato:
                    msgResult(url, dato)
                if args.output != None:
                    output(result[each]['url'])
                print('%s' % (result[each]['url']))
                lastDato = dato

# Dorks menu functions
# Filetype
def optionExtension(extension, url, dork):
    msgMassive()
    if extension == 'all':
        f = open(d_filetype, 'r')
        try:
            for dato in f:
                searchGlobal(url, dork, dato)
        except:
            msgError()
        finally:
            f.close()
    else:
        try:
            search(url, dork, extension)
        except:
            msgError()

# Intext
def optionText(text, url, dork):
    msgMassive()
    try:
        search(url, dork, text)
    except:
        msgError()

# String
def optionString(string, url, dork):
    msgMassive()
    try:
        search(url, dork, string)
    except:
        msgError()

# Massive
def optionMassive(massive, url, dork):
    msgMassive()
    if massive == 'admin':
        try:
            f = open(lista(massive), 'r')
            for dato in f:
                searchGlobal(url, dork, dato)
        except:
            msgError()
        finally:
            f.close()
    else:
        try:
            f = open(lista(massive), 'r')
            for dato in f:
                searchMassive(url, dato)
        except:
            msgError()
        finally:
            f.close()

# File
def optionFile(file, url, dork):
    msgMassive()
    if dork == 'filetype':
        try:
            f = open(file, 'r')
            for dato in f:
                searchGlobal(url, dork, dato)
        except:
            msgError()
        finally:
            f.close()
    else:
        try:
            f = open(file, 'r')
            for dato in f:
                searchGlobal(url, file, dato)
        except:
            msgError()
        finally:
            f.close()

# Pages
def peticiones():
    if args.pages != None:
        try:
            return int(args.pages)
        except:
            msgError()
    else:
        try:
            return 5
        except:
            msgError()

# Output
def output(linea):
    try:
        f = open(args.output, 'a')
        f.write(linea)
        f.write("\n")
    except:
        msgError()
    finally:
        f.close()

# Menu
banner_uDork()
separador()
parser = argparse.ArgumentParser()
parser.add_argument("-d", "--domain", help="Domain or IP address.")
parser.add_argument("-e", "--extension", help="Search files by extension. Use 'all' to find the list extension.")
parser.add_argument("-t", "--text", help="Find text in website content.")
parser.add_argument("-s", "--string", help="Locate text strings within the URL.")
parser.add_argument("-m", "--massive", help="Attack a site with a predefined list of dorks. Review list <-l / - list>")
parser.add_argument("-l", "--list", help="Shows the list of predefined dorks (Exploit-DB).")
parser.add_argument("-f", "--file", help="Use your own personalized list of dorks.")
parser.add_argument("-k", "--dork", help="Specifies the type of dork <filetype | intext | inurl> (Required for '<-f / - file'>).")
parser.add_argument("-p", "--pages", help="Number of pages to search in Google. (By default 5 pages).")
parser.add_argument("-o", "--output", help="Export results to a file.")
args = parser.parse_args()

# uDork execution
if args.domain != None:
    url = args.domain
    if args.extension == 'all':
        optionExtension(args.extension, url, dork='filetype')
    elif args.extension != None:
        optionExtension(args.extension, url, dork='filetype')
    elif args.text != None:
        optionText(args.text, url, dork='intext')
    elif args.string != None:
        optionString(args.string, url, dork='inurl')
    elif args.massive == 'admin':
        optionMassive(args.massive, url, dork='inurl')
    elif args.massive != None:
        optionMassive(args.massive, url, dork=None)
    elif args.file != None and args.dork != None:
        optionFile(args.file, url, args.dork)
    else:
        banner_error()
elif args.list != None:
    listaDorks()
else:
    banner_error()