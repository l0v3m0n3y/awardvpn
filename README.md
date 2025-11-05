# awardvpn
api for awardvpn vpn service for android
# Example
```nim
import asyncdispatch, awardvpn, json

discard waitFor get_token()
let data = waitFor get_servers()
let servers=data["data"]
for server in servers:
  try:
    echo server["name"].getStr()
    echo server["ip"].getStr()
  except Exception as e:
    discard
```

# Launch (your script)
```
nim c -d:ssl -r  your_app.nim
```
