import asyncdispatch, httpclient, json, strutils

const api = "https://api.award-vpn.com/v2"
var headers = newHttpHeaders({"Connection": "keep-alive",  "Host": "api.award-vpn.com",  "Content-Type": "application/x-www-form-urlencoded",  "accept": "application/json, text/plain, */*", "user-agent":"okhttp/4.12.0"})

proc get_token*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    headers["Authorization"]="Basic YXBpLXVzZXI6Li5Bc2RmQDEyMzRqa2w7"
    client.headers = headers
    let response = await client.post(api & "/token",body="device=nim")
    let body = await response.body
    let json=parseJson(body)
    headers["Authorization"]="Bearer " & json["token"].getStr()
    result=json
  finally:
    client.close()

proc get_servers*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/servers?sort=country")
    let body = await response.body
    result=parseJson(body)
  finally:
    client.close()
