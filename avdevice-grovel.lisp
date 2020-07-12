(pkg-config-cflags "libavdevice")

(include "libavdevice/avdevice.h")


(cstruct c-ffmpeg-AVInputFormat "struct AVInputFormat"
         (name "name" :type :string)
         (long-name "long_name" :type :string)
         (next "next" :type :pointer)) ;; ptr to AVInputformat

;; (cstruct c-ffmpeg-AVFormatContext "struct AVFormatContext"
;;          )

;; (cstruct c-ffmpeg-AVDictionary "struct AVDictionary"
;;          )
