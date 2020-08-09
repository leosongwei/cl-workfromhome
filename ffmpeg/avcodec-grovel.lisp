(pkg-config-cflags "libavcodec")

(include "stdint.h")
(include "libavcodec/avcodec.h")


(ctype int64_t "int64_t")

;; -------------------------------------------

(cenum c-ffmpeg-AVPixelFormat
       ((:AV_PIX_FMT_NONE "AV_PIX_FMT_NONE"))
       ((:AV_PIX_FMT_YUV420P "AV_PIX_FMT_YUV420P"))
       ((:AV_PIX_FMT_RGB24 "AV_PIX_FMT_RGB24"))
       ((:AV_PIX_FMT_RGBA "AV_PIX_FMT_RGBA")))

(cstruct c-ffmpeg-AVRational "struct AVRational"
         (num "num" :type :int)
         (den "den" :type :int))

(cstruct c-ffmpeg-AVCodec "struct AVCodec"
         (name "name" :type :string)
         (long-name "long_name" :type :string))

(cstruct c-ffmpeg-AVCodecContext "struct AVCodecContext"
         (width "width" :type :int)
         (height "height" :type :int)

         (bit-rate "bit_rate" :type int64_t)
         (bit-rate-tolerance "bit_rate_tolerance" :type int64_t)
         (av-pixel-format "pix_fmt" :type c-ffmpeg-AVPixelFormat)

         (time-base "time_base" :type (:struct c-ffmpeg-AVRational))
         (framerate "framerate" :type (:struct c-ffmpeg-AVRational))

         ;; key frames:
         ;; https://blog.csdn.net/abcjennifer/article/details/6577934
         (gop-size "gop_size" :type :int)
         (max-b-frames "max_b_frames" :type :int)

         ;; codec
         (codec "codec" :type (:pointer (:struct c-ffmpeg-AVCodec)))
         (priv_data "priv_data" :type :pointer))

