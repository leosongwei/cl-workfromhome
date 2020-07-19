(load (cffi-grovel:process-grovel-file "avdevice-grovel.lisp" "/dev/shm/_avdevice.o"))
(load-foreign-library "libavdevice.so")

(defcfun ("avdevice_configuration" c-ffmpeg-avdevice_configuration) :string)
;; (c-ffmpeg-avdevice_configuration)

(defcfun ("avformat_alloc_context" c-ffmpeg-avformat_alloc_context) (:pointer (:struct c-ffmpeg-AVFormatContext)))
;; (c-ffmpeg-avformat_alloc_context)

;; (defcfun ("avdevice_list_devices" c-ffmpeg-avdevice_list_devices) :int
;;   (context (:pointer (:struct c-ffmpeg-AVFormatContext)))
;;   (device_list (:pointer (:pointer (:struct c-ffmpeg-AVDeviceInfoList)))))

(defcfun ("avdevice_list_input_sources" c-ffmpeg-avdevice_list_input_sources) :int
  (device (:pointer (:struct c-ffmpeg-AVInputFormat)))
  (device_name :string)
  (device_options :pointer) ;; AVDictionary
  (device_list (:pointer (:pointer (:struct c-ffmpeg-AVDeviceInfoList)))))

(defcfun ("avdevice_register_all" c-ffmpeg-avdevice_register_all) :void)

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

(defun ffmpeg-avdevice-list-input-sources (device-name)
  (with-foreign-string (c-device-name device-name)
    (with-foreign-object (ptr :pointer)
      (setf (mem-aref ptr :pointer) (null-pointer))
      (c-ffmpeg-avdevice_list_input_sources (null-pointer) c-device-name (null-pointer) ptr)
      (make-ffmpeg-avdevice-info-list :ptr (mem-aref ptr :pointer)))))

(ffmpeg-avdevice-list-input-sources "x11grab")

;; ptr = []
;; ptr_actual = ref(ptr)

;; (defun ffmpeg-avdevice-list-devices (ffmpeg-avformat-context)
;;   (let ((context-ptr (ffmpeg-avformat-context-ptr ffmpeg-avformat-context)))
;;     (let ((ptr (foreign-alloc :pointer)))
;;       (c-ffmpeg-avdevice_list_devices context-ptr ptr)
;;       (make-ffmpeg-avdevice-info-list :ptr (mem-aref ptr :pointer)))))

;;(ffmpeg-avdevice-list-devices (ffmpeg-avformat-alloc-context))


;; try this:
;; int avdevice_list_input_sources 	( 	struct AVInputFormat *  	device,
;; 		const char *  	device_name,
;; 		AVDictionary *  	device_options,
;; 		AVDeviceInfoList **  	device_list 
;; 	)
