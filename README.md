# uDork - Google Hacking Tool

###### Author: M3n0sD0n4ld
###### Twitter: [@David_Uton](https://twitter.com/David_Uton)

# Description:

uDork is a script written in Python that uses advanced Google search techniques to obtain sensitive information in files or directories, find IoT devices, detect versions of web applications, and so on.

uDork does NOT make attacks against any server, it only uses predefined dorks and/or official lists from exploit-db.com (Google Hacking Database: https://www.exploit-db.com/google-hacking-database).

# Download and install:
```
$ git clone https://github.com/m3n0sd0n4ld/uDork
$ cd uDork
$ pip install -r requirements.txt
- Open the file and write inside this line:
```
cookie = 'YOUR FACEBOOK COOKIES HERE'
```
$ python3 uDork.py -h
```
# Important!!!
- For the tool to work, you must configure uDork with your Facebook cookie in the file `cookie.py`.
- You must also be logged in to Facebook on the computer you are using uDork WITHOUT logging out.

## Steps to obtain the cookie and configure the cookie
- Login to facebook.com
- Press in your browser control + shift + K (Firefox) o control + shift + J (Google Chrome) to go to console.
- Write document.cookie in the console and copy the cookies "c_user = content" and "xs = content" to the variable "cookie" inside the file "cookie.py""
```
cookie = 'c_user=XXXXXX; xs=XXXXXX'
```
Note: If the "xs" cookie does not appear, [follow these steps](https://gist.github.com/sqren/0e4563f258c9e85e4ae1).
- Save and remember, you must NOT log out of Facebook or you will have to do these steps again.


# Use:

## Menu

```
$ python3 uDork.py -h
       _____             _    
      |  __ \           | |   
 _   _| |  | | ___  _ __| | __
| | | | |  | |/ _ \| '__| |/ /
| |_| | |__| | (_) | |  |   < 
 \__,_|_____/ \___/|_|  |_|\_\ v.2020.03.13
		by M3n0sD0n4ld - (@David_Uton)

----------------------------------------------------------------------------------------------------
usage: uDork.py [-h] [-d DOMAIN] [-e EXTENSION] [-t TEXT] [-s STRING]
                [-m MASSIVE] [-l LIST] [-f FILE] [-k DORK] [-p PAGES]
                [-o OUTPUT]

optional arguments:
  -h, --help            show this help message and exit
  -d DOMAIN, --domain DOMAIN
                        Domain or IP address.
  -e EXTENSION, --extension EXTENSION
                        Search files by extension. Use 'all' to find the list
                        extension.
  -t TEXT, --text TEXT  Find text in website content.
  -s STRING, --string STRING
                        Locate text strings within the URL.
  -m MASSIVE, --massive MASSIVE
                        Attack a site with a predefined list of dorks. Review
                        list <-l / - list>
  -l LIST, --list LIST  Shows the list of predefined dorks (Exploit-DB).
  -f FILE, --file FILE  Use your own personalized list of dorks.
  -k DORK, --dork DORK  Specifies the type of dork <filetype | intext | inurl>
                        (Required for '<-f / - file'>).
  -p PAGES, --pages PAGES
                        Number of pages to search in Google. (By default 5
                        pages).
  -o OUTPUT, --output OUTPUT
                        Export results to a file.
```

## Example of searching pdf files

```
$ python3 uDork.py -d nasa.gov -e pdf
                                                                
       _____             _    
      |  __ \           | |   
 _   _| |  | | ___  _ __| | __
| | | | |  | |/ _ \| '__| |/ /
| |_| | |__| | (_) | |  |   < 
 \__,_|_____/ \___/|_|  |_|\_\ v.2020.03.13
		by M3n0sD0n4ld - (@David_Uton)

----------------------------------------------------------------------------------------------------
[!] The results will appear below. This may take several minutes, please wait ...
----------------------------------------------------------------------------------------------------
Domain/IP: nasa.gov
Find links with: pdf
----------------------------------------------------------------------------------------------------
https://www.sti.nasa.gov/thesvol2.pdf
https://www.sti.nasa.gov/thesvol1.pdf
https://www.nasa.gov/pdf/220260main_Workforce_Transition_Strategy_briefing.pdf
https://oig.nasa.gov/docs/SAR0318.pdf
https://oig.nasa.gov/docs/FinalWrittenStatement_03_13_2013.pdf
https://oig.nasa.gov/docs/MC-2018.pdf
https://www.nasa.gov/centers/dryden/pdf/88798main_srfcs.pdf
https://www.nasa.gov/specials/apollo50th/pdf/A10_PressKit.pdf
https://www.nasa.gov/specials/apollo50th/pdf/A14_PressKit.pdf
https://www.nasa.gov/specials/apollo50th/pdf/A07_PressKit.pdf
https://www.nasa.gov/specials/apollo50th/pdf/A15_PressKit.pdf
https://www.nasa.gov/specials/apollo50th/pdf/A09_PressKit.pdf
https://www.nasa.gov/specials/apollo50th/pdf/A08_PressKit.pdf
https://www.nasa.gov/centers/dryden/pdf/88790main_Dryden.pdf
https://oig.nasa.gov/docs/MC-2017.pdf
....
```
## Example of searching routes with the word "password"
```
$ python3 uDork.py -d nasa.gov -s password
                                                                
       _____             _    
      |  __ \           | |   
 _   _| |  | | ___  _ __| | __
| | | | |  | |/ _ \| '__| |/ /
| |_| | |__| | (_) | |  |   < 
 \__,_|_____/ \___/|_|  |_|\_\ v.2020.03.13
		by M3n0sD0n4ld - (@David_Uton)

----------------------------------------------------------------------------------------------------
[!] The results will appear below. This may take several minutes, please wait ...
----------------------------------------------------------------------------------------------------
Domain/IP: nasa.gov
Find links with: password
----------------------------------------------------------------------------------------------------
https://www.grc.nasa.gov/its-training/best-practices/password-tips/
https://www.grc.nasa.gov/its-training/best-practices/password-rules/
https://www.nas.nasa.gov/hecc/support/kb/password-creation-rules_270.html
https://www.nas.nasa.gov/hecc/support/kb/index.php%3FView%3Dentry%26EntryID%3D270%26EntryTitle%3Dpassword-creation-rules%26mobile%3D0
https://open.nasa.gov/datanaut-accounts/password/reset/%3Fnext%3D/explore/datanauts/app/profile
https://www.nas.nasa.gov/hecc/support/kb/i-cant-log-inmy-password-is-not-workingmy-account-is-locked_5.html
https://www.nas.nasa.gov/hecc/support/kb/index.php%3FView%3Dentry%26EntryID%3D53%26EntryTitle%3Dtwo-step-connection-using-rsa-securid-passcode-and-nas-password%26mobile%3D0
https://www.nas.nasa.gov/hecc/support/kb/index.php%3FView%3Dentry%26EntryID%3D8%26EntryTitle%3Dwhat-are-the-requirements-for-creating-a-password%26mobile%3D0
https://oltaris.nasa.gov/password/new
https://ghrc.nsstc.nasa.gov/data-publication/user/password
https://answers.nssc.nasa.gov/app/answers/detail/a_id/6173/~/change-launchpad-%2528idmax%2529-password
https://answers.nssc.nasa.gov/app/answers/list/search/1/kw/Password/search/1
https://answers.nssc.nasa.gov/app/answers/list/search/1/kw/CHANGE%2520NDC%2520PASSWORD/suggested/1
https://answers.nssc.nasa.gov/app/answers/detail/a_id/6174/~/reset-ndc-password
.....
```
## Dorks listing
```
$ python3 uDork.py -l list
                                                                
       _____             _    
      |  __ \           | |   
 _   _| |  | | ___  _ __| | __
| | | | |  | |/ _ \| '__| |/ /
| |_| | |__| | (_) | |  |   < 
 \__,_|_____/ \___/|_|  |_|\_\ v.2020.03.13
		by M3n0sD0n4ld - (@David_Uton)

----------------------------------------------------------------------------------------------------

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

```

## Example of use Dorks Massive 
```
$ python3 uDork.py -d nasa.gov -m admin -p 3 -o report.txt
                                                                
       _____             _    
      |  __ \           | |   
 _   _| |  | | ___  _ __| | __
| | | | |  | |/ _ \| '__| |/ /
| |_| | |__| | (_) | |  |   < 
 \__,_|_____/ \___/|_|  |_|\_\ v.2020.03.13
		by M3n0sD0n4ld - (@David_Uton)

----------------------------------------------------------------------------------------------------
[!] The results will appear below. This may take several minutes, please wait ...
----------------------------------------------------------------------------------------------------
Domain/IP: nasa.gov
Find links with: ADMIN/

https://asd.gsfc.nasa.gov/blueshift/index.php/author/admin/
https://lists.hq.nasa.gov/mailman/admin
https://lists.hq.nasa.gov/mailman/admin/LISTNAME
https://rosetta.jpl.nasa.gov/blogs/admin
https://dartslab.jpl.nasa.gov/qa/user/admin
https://landsat.gsfc.nasa.gov/author/admin/page/8/
https://rosetta.jpl.nasa.gov/blogs/admin%3Fpage%3D1
https://www.nasa.gov/news/speeches/admin/mg_speech_collection_archive_4.html
https://dartslab.jpl.nasa.gov/qa/user/admin/answers
https://dartslab.jpl.nasa.gov/qa/user/admin/wall
https://landsat.gsfc.nasa.gov/author/admin/page/14/
....
----------------------------------------------------------------------------------------------------
Domain/IP: nasa.gov
Find links with: AdminTools/

https://kscddms.ksc.nasa.gov/adminTools.html
----------------------------------------------------------------------------------------------------
Domain/IP: nasa.gov
Find links with: Server.html

https://image.msfc.nasa.gov/ChrisDocs/udfLib/Server.html
https://www.nasa.gov/privacy/PIA-ODIN-server.html

MORE RESULTS...
```

# Thanks:

Thank s0md3v for goop, very good job! https://github.com/s0md3v/goop



