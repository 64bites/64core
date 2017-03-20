#importonce

// TODO: Add docs

.function extract_byte_argument(arg, byte_id) {
  .if (arg.getType()==AT_IMMEDIATE) {
    .return CmdArgument(arg.getType(), extract_byte(arg.getValue(), byte_id))
  } else {
    .return CmdArgument(arg.getType(), arg.getValue() + byte_id)
  }
}

.function extract_byte(value, byte_id) {
  .var bits = bytes_to_bits(byte_id)
  .eval value = value >> bits
  .return value & $ff
}
.function bytes_to_bits(bytes) {
  .return bytes * 8
}
.function bits_to_bytes(bits) {
  .return bits / 8
}
