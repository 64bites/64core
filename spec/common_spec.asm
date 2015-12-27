.import source "../lib/64core/common.asm"
.import source "64spec.asm"


sfspec: :init_spec()

  :finish_spec()

.assert "extract_byte_argument extracts value correctly in immediate mode", 
  extract_byte_argument(CmdArgument(AT_IMMEDIATE, $11223344), 2).getValue(),
  $22
.assert "extract_byte_argument changes pointer correctly in absolute mode", 
  extract_byte_argument(CmdArgument(AT_ABSOLUTE, $1000), 9).getValue(),
  $1009
.assert "extract_byte_argument does not change mode", 
  extract_byte_argument(CmdArgument(AT_IMMEDIATE, $11223344), 2).getValue(),
  CmdArgument(AT_IMMEDIATE, $22).getValue()


.assert "extract_byte can extract LSB in immediate mode", 
  extract_byte($11223344, 0), 
  $44
.assert "extract_byte can extract second byte in immediate mode", 
  extract_byte($11223344, 1), 
  $33
.assert "extract_byte can extract third byte in immediate mode", 
  extract_byte($11223344, 2), 
  $22
.assert "extract_byte can extract MSB in immediate mode", 
  extract_byte($11223344, 3), 
  $11
