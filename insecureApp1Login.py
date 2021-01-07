import requests, sys, os, re, fileinput
requests.packages.urllib3.disable_warnings() 

#Globals, 
#Configurable globals, should be configured to match your environment
insecureApp1User = 'f6student'
insecureApp1Pass = 'f6DEMOs4u!'
formData = { "username": insecureApp1User, "password": insecureApp1Pass}
host = 'https://insecureapp1.f5.demo'
loginUri = '/WebGoat/login'
hostUrl = host + loginUri
loginTryLimit = 1000000
#End configurable globals

#Require Python v3 or greater
if sys.version_info[:3] < (3,0,0):

	print('requires Python >= 3.0.0')
	sys.exit(1)

for x in range(loginTryLimit):
		
		dataCreds = '{\'username\':\'' + insecureApp1User + '\',\'password\':\'' + insecureApp1Pass + str(x) + '\'}'
		response = requests.post(hostUrl,data=formData,verify=False)
		print(response.text)
