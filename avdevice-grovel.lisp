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

(cstruct c-ffmpeg-AVDeviceInfo "AVDeviceInfo"
         (device-name "device_name" :type :string)
         (device-description "device_description" :type :string))

(cstruct c-ffmpeg-AVDeviceInfoList "struct AVDeviceInfoList"
         (devices "devices" :type (:pointer (:pointer (:struct c-ffmpeg-AVDeviceInfo))))
         (nb-devices "nb_devices" :type :int)
         (default-device "default_device" :type :int))
