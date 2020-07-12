(load-foreign-library "libavdevice.so")
(load (cffi-grovel:process-grovel-file "avdevice-grovel.lisp" "/dev/shm/_avdevice.o"))


(defcfun ("avdevice_configuration" c-ffmpeg-avdevice_configuration) :string)
;; (c-ffmpeg-avdevice_configuration)

(defcfun ("avformat_alloc_context" c-ffmpeg-avformat_alloc_context) (:pointer (:struct c-ffmpeg-AVFormatContext)))

(defcfun ("avdevice_list_devices" c-ffmpeg-avdevice_list_devices) :int
  (context (:pointer (:struct c-ffmpeg-AVFormatContext)))
  (device_list (:pointer (:pointer (:struct c-ffmpeg-AVDeviceInfoList)))))
