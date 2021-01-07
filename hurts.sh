#!/bin/bash

ab -B 10.1.10.100 -l -r -n 4000 -m POST -c 50 -d -H "Host: avalanchecorp.net" -H "Pragma: no-cache" -H "Cache-Control: no-cache" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Upgrade-Insecure-Requests: 1" -H "User-Agent: HTTP-Killer" -H "x-requested-with: me" -H "Referer: http://10.0.2.1/bla.html" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: en-US"  http://10.1.10.145/
