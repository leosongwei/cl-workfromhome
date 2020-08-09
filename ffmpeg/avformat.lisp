(load (cffi-grovel:process-grovel-file "ffmpeg/avformat-grovel.lisp" "/dev/shm/_ffmpeg.o"))

(load-foreign-library "libavformat.so")

(defcfun ("av_register_all" c-ffmpeg-av_register_all) :void)

(defcfun ("av_find_input_format" c-ffmpeg-av_find_input-format) (:pointer (:struct c-ffmpeg-AVInputFormat))
  (short_name :string))
;; (with-foreign-string (name "x11grab")
;;   (convert-from-foreign (c-ffmpeg-av_find_input-format name) '(:struct c-ffmpeg-AVInputFormat)))

(defstruct ffmpeg-av-input-format
  (ptr #.(null-pointer) :type #.(type-of (null-pointer))))

(defcfun ("avformat_alloc_context" c-ffmpeg-avformat_alloc_context) (:pointer (:struct c-ffmpeg-AVFormatContext)))
;; (c-ffmpeg-avformat_alloc_context)

(defstruct ffmpeg-avformat-context
  (ptr #.(null-pointer) :type #.(type-of (null-pointer))))

(defun ffmpeg-avformat-alloc-context ()
  (let ((ptr (c-ffmpeg-avformat_alloc_context)))
    (if (null-pointer-p ptr)
        (c-ffmpeg-condition "Could not allocate AVFormatContext"))
    (make-ffmpeg-avformat-context :ptr ptr)))
;; (ffmpeg-avformat-alloc-context)

(defcfun ("avformat_open_input" c-ffmpeg-avformat_open_input) :int
  (ps (:pointer (:pointer (:struct c-ffmpeg-AVFormatContext))))
  (url :string)
  (fmt (:pointer (:struct c-ffmpeg-AVInputFormat)))
  (options :options))

(defun ffmpeg-avformat-open-input (
