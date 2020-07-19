(pkg-config-cflags "libavformat")

(include "libavformat/avformat.h")


(cstruct c-ffmpeg-AVInputFormat "struct AVInputFormat"
         (name "name" :type :string)
         (long-name "long_name" :type :string)
         (next "next" :type :pointer)) ;; ptr to AVInputformat

(cstruct c-ffmpeg-AVOutputFormat "struct AVInputFormat"
         (name "name" :type :string)
         (long-name "long_name" :type :string)
         (next "next" :type :pointer)) ;; ptr to AVOutputformat, grovel can't do recursive parse

(cstruct c-ffmpeg-AVFormatContext "struct AVFormatContext"
         (iformat "iformat" :type (:pointer (:struct c-ffmpeg-AVInputFormat))))
