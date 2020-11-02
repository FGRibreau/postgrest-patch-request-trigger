curl http://localhost:3000/cities

echo "\n\nPATCH /cities?id=eq.1 '{\"name\": null}'"
curl -s -H "content-type: application/json" --request PATCH --data '{"name": null}' http://localhost:3000/cities?id=eq.1 | jq '.message'

echo "\n\nPATCH /cities?id=eq.1 '{\"name\": \"new_value\"}'"
curl -s -H "content-type: application/json" --request PATCH --data '{"name": "new_value"}' http://localhost:3000/cities?id=eq.1 | jq '.message'
