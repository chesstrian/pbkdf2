crypto = require 'crypto'
pbkdf2 = require './pbkdf2'

algorithm = 'sha1'
password = 'myPassword'
salt = '呀'
iterations = 10000
key_length = 32

console.time 'crypto'
crypto_result = crypto.pbkdf2Sync(password, salt, iterations, key_length).toString 'binary'
console.timeEnd 'crypto'
console.log crypto_result

console.time 'pbkdf2'
pbkdf2_result = pbkdf2 algorithm, password, salt, iterations, key_length
console.timeEnd 'pbkdf2'
console.log pbkdf2_result
