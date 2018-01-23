require 'string'
require 'base64'
require 'openssl'

class OpenxRtbPriceCrypterError < StandardError; end

class OpenxRtbPriceCrypter
  
  def self.decrypt( value, encryption_key, integrity_key )
    value = value.gsub( /-/, '+' ).gsub( "_", "/" ) + "=="
    
    begin 
      bin_encryption_key = encryption_key.hex2bin
      bin_integrity_key = integrity_key.hex2bin
    
      decoded_value = Base64.decode64( value )
    
      initvec = decoded_value[0,16]
      ciphertext = decoded_value[16,8]
      integritysig = decoded_value[24,4]
    
      digest = OpenSSL::HMAC.digest(OpenSSL::Digest::SHA1.new, bin_encryption_key, initvec )
      xor = ciphertext.bytes.zip(digest.bytes).map { |x,y| (x^y).chr }.join
    
      integrity_digest = OpenSSL::HMAC.digest(OpenSSL::Digest::SHA1.new, bin_integrity_key, xor+initvec )
      integrity_digest_array = integrity_digest.bytes.to_a
      integritysig_array = integritysig.bytes.to_a
    
      begin
        4.times{ |i| raise OpenxRtbPriceCrypterError if integrity_digest_array[i] != integritysig_array[i] }
        xor.bin2hex.to_i(16)
      rescue OpenxRtbPriceCrypterError
        "Signature does not match!"
      end
    rescue InvalidHexStringError
      "Invalid Hex String!"
    end
  end
  
end
