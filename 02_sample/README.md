# 3 steps

## MEMO

### Create test data

```ruby
require 'securerandom'
File.write('proxy/static/01_1k.txt', SecureRandom.alphanumeric(1_000 - 1) + "\n")
File.write('proxy/static/02_10k.txt', 10.times.map { SecureRandom.alphanumeric(1_000 - 1) }.join("\n") + "\n")
File.write('proxy/static/03_20k.txt', 20.times.map { SecureRandom.alphanumeric(1_000 - 1) }.join("\n") + "\n")
File.write('proxy/static/04_1m.txt', 1_000.times.map { SecureRandom.alphanumeric(1_000 - 1) }.join("\n") + "\n")
```

### GET Nginx static files

```sh
# 1sec OK
wget localhost:8080/proxy/static/01_1k.txt -O /dev/null
# 10sec OK
wget localhost:8080/proxy/static/02_10k.txt -O /dev/null
# 20sec OK
wget localhost:8080/proxy/static/03_20k.txt -O /dev/null
# 100sec OK
wget localhost:8080/proxy/static/04_1m.txt -O /dev/null
```
