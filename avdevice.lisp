(load-foreign-library "libavdevice.so")
(load (cffi-grovel:process-grovel-file "avdevice-grovel.lisp" "/dev/shm/_avdevice.o"))


(defcfun ("avdevice_configuration" c-ffmpeg-avdevice_configuration) :string)
;; (c-ffmpeg-avdevice_configuration)
