crypto = require 'crypto'

module.exports = (algorithm = 'sha1', password, salt, iterations, key_length = '0') ->
  unless typeof iterations is 'number' and iterations >= 0
    throw new TypeError 'Invalid iterations number'

  unless typeof key_length is 'number' and key_length >= 0
    throw new TypeError 'Invalid key length'

  unless Buffer.isBuffer password
    password = new Buffer password, 'binary'
  unless Buffer.isBuffer salt
    salt = new Buffer salt, 'binary'

  hash = crypto.createHmac(algorithm, password).update('').digest 'binary'
  block_count = Math.ceil key_length / hash.length

  output = '';
  for i in [1..block_count]
    last = new Buffer salt.length + 4
    salt.copy last, 0, 0, salt.length
    last.writeUInt32BE i, salt.length

    last = xor_sum = crypto.createHmac(algorithm, password).update(last).digest()

    for j in [1..iterations - 1]
      last = crypto.createHmac(algorithm, password).update(last).digest()
      for k in [0..last.length - 1]
        xor_sum[k] ^= last[k]

    output += xor_sum.toString 'binary'

  output.substr 0, key_length
