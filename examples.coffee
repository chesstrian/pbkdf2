crypto = require 'crypto'
pbkdf2 = require './index'

password = 'myPassword'
salt = '呀'
iterations = 10000
key_length = 32

console.time 'crypto'
crypto_result = crypto.pbkdf2Sync(password, salt, iterations, key_length).toString 'binary'
console.timeEnd 'crypto'
console.log crypto_result

console.time 'pbkdf2'
pbkdf2_result = pbkdf2 null, password, salt, iterations, key_length
console.timeEnd 'pbkdf2'
console.log pbkdf2_result
