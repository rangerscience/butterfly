module IntegerPatches
  def to_hex_s
    "0x" + to_s(16).upcase.rjust(6, '0')
  end

  def to_chr_bytes
    ((self & 0xFF0000) >> 16).chr +
    ((self & 0x00FF00) >>  8).chr +
    ((self & 0x0000FF)      ).chr
  end
end

Integer.include IntegerPatches
