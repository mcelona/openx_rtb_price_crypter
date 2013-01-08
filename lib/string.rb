class InvalidHexStringError < StandardError; end

class String
  def hex2bin
    s = self
    raise InvalidHexStringError unless(s =~ /^[\da-fA-F]+$/)
    s = '0' + s if((s.length & 1) != 0)
    s.scan(/../).map{ |b| b.to_i(16) }.pack('C*')
  end

  def bin2hex
    self.unpack('C*').map{ |b| "%02X" % b }.join('')
  end
end