(pkg-config-cflags "libavutil")

(include "libavutil/dict.h")

(cstruct c-ffmpeg-AVDictionaryEntry "struct AVDictionaryEntry"
         (key "key" :type :string)
         (value "value" :type :string))
