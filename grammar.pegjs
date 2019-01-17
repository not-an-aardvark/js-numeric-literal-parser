NumericLiteral =
  BinaryIntegerLiteral /
  OctalIntegerLiteral /
  HexIntegerLiteral /
  LegacyOctalIntegerLiteral /
  DecimalLiteral

BinaryIntegerLiteral =
  m:(('0b' / '0B') BinaryDigit+) {
    return {
      type: 'BinaryInteger',
      prefix: m[0],
      digits: m[1]
    };
  }

OctalIntegerLiteral =
  m:(('0o' / '0O') OctalDigit+) {
    return {
      type: 'OctalInteger',
      prefix: m[0],
      digits: m[1]
    };
  }
  
HexIntegerLiteral =
  m:(('0x' / '0X') HexDigit+) {
    return {
      type: 'HexInteger',
      prefix: m[0],
      digits: m[1]
    };
  }

LegacyOctalIntegerLiteral =
  m:("0" OctalDigit+ !NonOctalDecimalDigit) {
    return {
      type: 'LegacyOctalInteger',
      prefix: m[0],
      digits: m[1]
    };
  }

DecimalLiteral =
  m:(DecimalDigit+ "." DecimalDigit* ExponentPart?) {
    return {
      type: 'Decimal',
      integralDigits: m[0],
      decimalPoint: m[1],
      fractionalDigits: m[2],
      exponent: m[3]
    };
  } /
  m:("." DecimalDigit+ ExponentPart?) {
    return {
      type: 'Decimal',
      integralDigits: [],
      decimalPoint: m[0],
      fractionalDigits: m[1],
      exponent: m[2]
    };
  } /
  m:(DecimalDigit+ ExponentPart?) {
    return {
      type: 'Decimal',
      integralDigits: m[0],
      decimalPoint: null,
      fractionalDigits: [],
      exponent: m[1]
    };
  }
  
ExponentPart = m:(("e" / "E") ("+" / "-")? DecimalDigit+) {
  return {
    exponentIndicator: m[0],
    sign: m[1],
    digits: m[2]
  };
}

BinaryDigit = [01]
OctalDigit = [01234567]
DecimalDigit = [0123456789]
HexDigit = [0123456789abcdefABCDEF]
NonOctalDecimalDigit = [89]
