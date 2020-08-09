(pkg-config-cflags "libavdevice")

(include "libavdevice/avdevice.h")

(cstruct c-ffmpeg-AVDeviceInfo "struct AVDeviceInfo"
         (device-name "device_name" :type :string)
         (device-description "device_description" :type :string))

(cstruct c-ffmpeg-AVDeviceInfoList "struct AVDeviceInfoList"
         (devices "devices" :type (:pointer (:pointer (:struct c-ffmpeg-AVDeviceInfo))))
         (nb-devices "nb_devices" :type :int)
         (default-device "default_device" :type :int))
