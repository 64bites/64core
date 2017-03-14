.importonce
.import source "./common.asm"

.macro int24(value) {
  .fill bits_to_bytes(24), extract_byte(value, i) 
}

.pseudocommand inc16 arg {
  :_inc bits_to_bytes(16): arg
}
.pseudocommand inc24 arg {
  :_inc bits_to_bytes(24): arg
}
.pseudocommand inc32 arg {
  :_inc bits_to_bytes(32): arg
}

.pseudocommand _inc bytes: arg {
  .for (var byte_id = 0; byte_id < bytes.getValue(); byte_id++) {
    inc extract_byte_argument(arg, byte_id)
    bne end 
  }
  end:
}

.pseudocommand dec16 arg {
  lda extract_byte_argument(arg, 0)
  bne dec_lower
  dec extract_byte_argument(arg, 1)
dec_lower:
  dec extract_byte_argument(arg, 0)
}

.pseudocommand dec24 arg {
  lda extract_byte_argument(arg, 0)
  bne dec_0
  lda extract_byte_argument(arg, 1)
  bne dec_1
  dec extract_byte_argument(arg, 2)
dec_1:
  dec extract_byte_argument(arg, 1)
dec_0:
  dec extract_byte_argument(arg, 0)
}

.pseudocommand dec32 arg {
  lda extract_byte_argument(arg, 0)
  bne dec_0
  lda extract_byte_argument(arg, 1)
  bne dec_1
  lda extract_byte_argument(arg, 2)
  bne dec_2
  dec extract_byte_argument(arg, 3)
dec_2:
  dec extract_byte_argument(arg, 2)
dec_1:
  dec extract_byte_argument(arg, 1)
dec_0:
  dec extract_byte_argument(arg, 0)
}
.pseudocommand sub a: b: result {
  :_sub bits_to_bytes(8): a: b: result 
}
.pseudocommand sub16 a: b: result {
  :_sub bits_to_bytes(16): a: b: result 
}
.pseudocommand sub32 a: b: result {
  :_sub bits_to_bytes(32): a: b: result 
}

.pseudocommand _sub bytes_count: a: b: result {
  sec  
  :_sbc bytes_count: a: b: result
}

.pseudocommand sbc16 a: b: result {
  :_sbc bits_to_bytes(16): a: b: result 
}

.pseudocommand sbc32 a: b: result {
  :_sbc bits_to_bytes(32): a: b: result 
}

.pseudocommand _sbc bytes_count: a: b: result {
  .if (result.getType() == AT_NONE) {
    .eval result = a
  }
  .for (var byte_id = 0; byte_id < bytes_count.getValue(); byte_id++) {
    lda extract_byte_argument(a, byte_id)
    sbc extract_byte_argument(b, byte_id)
    sta extract_byte_argument(result, byte_id)
  } 
}

.pseudocommand add a: b: result {
  :_add bits_to_bytes(8): a: b: result 
}
.pseudocommand add16 a: b: result {
  :_add bits_to_bytes(16): a: b: result 
}
.pseudocommand add32 a: b: result {
  :_add bits_to_bytes(32): a: b: result 
}

.pseudocommand _add bytes_count: a: b: result {
  clc  
  :_adc bytes_count: a: b: result
}

.pseudocommand adc16 a: b: result {
  :_adc bits_to_bytes(16): a: b: result 
}
.pseudocommand adc32 a: b: result {
  :_adc bits_to_bytes(32): a: b: result 
}
.pseudocommand _adc bytes_count: a: b: result {
  .if (result.getType() == AT_NONE) {
    .eval result = a
  }
  .for (var byte_id = 0; byte_id < bytes_count.getValue(); byte_id++) {
    lda extract_byte_argument(a, byte_id)
    adc extract_byte_argument(b, byte_id)
    sta extract_byte_argument(result, byte_id)
  } 
}
.pseudocommand asl16 value {
  :_asl bits_to_bytes(16): value
}
.pseudocommand asl24 value {
  :_asl bits_to_bytes(24): value
}
.pseudocommand asl32 value {
  :_asl bits_to_bytes(32): value
}
.pseudocommand _asl bytes_count: value {
  asl extract_byte_argument(value, 0)
  .for (var byte_id = 1; byte_id < bytes_count.getValue(); byte_id++) {
    rol extract_byte_argument(value, byte_id)
  }
}
.pseudocommand rol16 value {
  :_rol bits_to_bytes(16): value
}
.pseudocommand rol24 value {
  :_rol bits_to_bytes(24): value
}
.pseudocommand rol32 value {
  :_rol bits_to_bytes(32): value
}
.pseudocommand _rol bytes_count: value {
  .for (var byte_id = 0; byte_id < bytes_count.getValue(); byte_id++) {
    rol extract_byte_argument(value, byte_id)
  }
}
.pseudocommand lsr16 value {
  :_lsr bits_to_bytes(16): value
}
.pseudocommand lsr24 value {
  :_lsr bits_to_bytes(24): value
}
.pseudocommand lsr32 value {
  :_lsr bits_to_bytes(32): value
}
.pseudocommand _lsr bytes_count: value {
  lsr extract_byte_argument(value, bytes_count.getValue() - 1)
  .for (var byte_id = bytes_count.getValue() - 2; byte_id >= 0 ; byte_id--) {
    ror extract_byte_argument(value, byte_id)
  }
}
.pseudocommand ror16 value {
  :_ror bits_to_bytes(16): value
}
.pseudocommand ror24 value {
  :_ror bits_to_bytes(24): value
}
.pseudocommand ror32 value {
  :_ror bits_to_bytes(32): value
}
.pseudocommand _ror bytes_count: value {
  .for (var byte_id = 0; byte_id < bytes_count.getValue(); byte_id++) {
    ror extract_byte_argument(value, byte_id)
  }
}

.pseudocommand cmp_eq16 expected: actual {
  :_cmp_eq bits_to_bytes(16): expected: actual 
}
.pseudocommand cmp_eq24 expected: actual {
  :_cmp_eq bits_to_bytes(24): expected: actual 
}
.pseudocommand cmp_eq32 expected: actual {
  :_cmp_eq bits_to_bytes(32): expected: actual 
}
.pseudocommand _cmp_eq bytes_count: expected: actual {
  .for (var byte_id = 0; byte_id < bytes_count.getValue(); byte_id++) {
    lda extract_byte_argument(expected, byte_id)
    cmp extract_byte_argument(actual, byte_id)
    .if (byte_id < bytes_count.getValue() - 1) {
      bne end
    }
  } 
  end:
}
