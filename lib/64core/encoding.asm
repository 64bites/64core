#importonce
.function char(number) {
  .var chars = "@abcdefghijklmnopqrstuvwxyz[Ĝ]„ğ !\"#$%&'()*+,-./0123456789:;<=>?ŀABCDEFGHIJKLMNOPQRSTUVWXYZś\ŝŞ_`šŢţŤťŦŧŨũŪūŬŭŮůŰűŲųŴŵŶŷŸŹź{|}~ſƀƁƂƃƄƅƆƇƈƉƊƋƌƍƎƏƐƑƒƓƔƕƖƗƘƙƚƛƜƝƞƟƠ¡¢ƣ¤¥¦§¨©ª«¬ƭ®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ"
  .return chars.charAt(number)
}

.function pet_char(scr_char) {
  .var pet_index = scr_char + 0
  .if (pet_index < 32 * 1) {
    .eval pet_index += 64
  } else .if (pet_index < 32 * 2) {
    .eval pet_index += 0
  } else .if (pet_index < 32 * 3) {
    .eval pet_index += 32
  } else .if (pet_index < 32 * 4) {
    .eval pet_index += 64
  }
  .return char(pet_index)
}

.function pet_string(scr_string) {
  .var result = ""
  .for (var i = 0;i < scr_string.size(); i++) {
    .eval result += pet_char(scr_string.charAt(i))
  }
  .return result
}
