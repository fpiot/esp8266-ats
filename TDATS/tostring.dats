#include "../config.hats"
staload "{$ESP8266}/SATS/tostring.sats"
staload UN = "prelude/SATS/unsafe.sats"

typedef cstring = $extype"atstype_string"
extern fun os_sprintf_int (cstring, string, int): void = "mac#os_sprintf"

implement{}
esp_tostrptr_int(i) = r where {
  #define BSZ 32
  var buf = @[byte][BSZ]()
  val bufp = $UN.cast{cstring}(addr@buf)
  val () = os_sprintf_int (bufp, "%d", i)
  val r = $UN.castvwtp0{Strptr1}(string0_copy($UN.cast{string}(bufp)))
}
