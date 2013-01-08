require 'test/unit'
require 'openx_rtb_price_crypter'

class OpenxRtbPriceCrypterErrorTest < Test::Unit::TestCase
  def setup 
    @key = "9D9768E1925FD35825543F8B796E24FDEEA629F7E263E3C16081F0C21FA976BC"
    @integrity_key = "41DE9DD43E712C63C66BEF3FDA133DC9B967C09CCAA45E2A264EED45F863023A"
  end
  
  def test_decrypt
    assert_equal 660, OpenxRtbPriceCrypter.decrypt( "AAABO93WAY9pQ_FHfQa7IKt4Xi-XL98AW9p6zw", @key, @integrity_key )
    assert_equal 200, OpenxRtbPriceCrypter.decrypt( "AAABO93Tqw9TraqTv5yHU-Rm5c9YA19a0MxBjQ", @key, @integrity_key )
    assert_equal 440, OpenxRtbPriceCrypter.decrypt( "AAABO93BO3vnNvljBbGgZnCSGFciF81QgNKzxw", @key, @integrity_key )
  end
  
  def test_key_not_valid_kex
    @key = "QD9768E1925FD35825543F8B796E24FDEEA629F7E263E3C16081F0C21FA976BC"
    assert_equal "Invalid Hex String!", OpenxRtbPriceCrypter.decrypt( "AAABO93WAY9pQ_FHfQa7IKt4Xi-XL98AW9p6zw", @key, @integrity_key )
  end
  
  def test_integrity_key_not_valid_kex
    @integrity_key = "Q1DE9DD43E712C63C66BEF3FDA133DC9B967C09CCAA45E2A264EED45F863023A"
    assert_equal "Invalid Hex String!", OpenxRtbPriceCrypter.decrypt( "AAABO93WAY9pQ_FHfQa7IKt4Xi-XL98AW9p6zw", @key, @integrity_key )
  end
  
  def test_invalid_key
    @key = "2D9768E1925FD35825543F8B796E24FDEEA629F7E263E3C16081F0C21FA976BC"
    assert_equal "Signature does not match!", OpenxRtbPriceCrypter.decrypt( "AAABO93WAY9pQ_FHfQa7IKt4Xi-XL98AW9p6zw", @key, @integrity_key )
  end
  
  def test_invalid_integrity_key
    @integrity_key = "21DE9DD43E712C63C66BEF3FDA133DC9B967C09CCAA45E2A264EED45F863023A"
    assert_equal "Signature does not match!", OpenxRtbPriceCrypter.decrypt( "AAABO93WAY9pQ_FHfQa7IKt4Xi-XL98AW9p6zw", @key, @integrity_key )
  end

end