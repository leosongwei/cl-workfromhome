(load (cffi-grovel:process-grovel-file "avdevice-grovel.lisp" "/dev/shm/_avdevice.o"))
(load-foreign-library "libavdevice.so")

(defcfun ("avdevice_configuration" c-ffmpeg-avdevice_configuration) :string)
;; (c-ffmpeg-avdevice_configuration)

(defcfun ("avformat_alloc_context" c-ffmpeg-avformat_alloc_context) (:pointer (:struct c-ffmpeg-AVFormatContext)))
;; (c-ffmpeg-avformat_alloc_context)

(defcfun ("avdevice_list_devices" c-ffmpeg-avdevice_list_devices) :int
  (context (:pointer (:struct c-ffmpeg-AVFormatContext)))
  (device_list (:pointer (:pointer (:struct c-ffmpeg-AVDeviceInfoList)))))

;; --------------------------------------------

(defstruct ffmpeg-avformat-context
  (ptr #.(null-pointer) :type #.(type-of (null-pointer))))

(defun ffmpeg-avformat-alloc-context ()
  (let ((ptr (c-ffmpeg-avformat_alloc_context)))
    (if (null-pointer-p ptr)
        (c-ffmpeg-condition "Could not allocate AVFormatContext"))
    (make-ffmpeg-avformat-context :ptr ptr)))
;; (ffmpeg-avformat-alloc-context)

(defstruct ffmpeg-avdevice-info-list
  (ptr #.(null-pointer) :type #.(type-of (null-pointer))))

;; ptr = []
;; ptr_actual = ref(ptr)

(defun ffmpeg-avdevice-list-devices (ffmpeg-avformat-context)
  (let ((context-ptr (ffmpeg-avformat-context-ptr ffmpeg-avformat-context)))
    (with-foreign-object (outer-ptr :pointer)
      (let ((inner-ptr (foreign-alloc :pointer)))
        (setf (mem-ref outer-ptr :pointer) inner-ptr)
        (c-ffmpeg-avdevice_list_devices context-ptr outer-ptr)
        (make-ffmpeg-avdevice-info-list :ptr inner-ptr)))))

;; (ffmpeg-avdevice-list-devices (ffmpeg-avformat-alloc-context))
