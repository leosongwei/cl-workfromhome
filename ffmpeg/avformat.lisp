(load (cffi-grovel:process-grovel-file "ffmpeg/avformat-grovel.lisp" "/dev/shm/_ffmpeg.o"))

(load-foreign-library "libavformat.so")

(defcfun ("av_register_all" c-ffmpeg-av_register_all) :void)

(defcfun ("av_find_input_format" c-ffmpeg-av_find_input_format) (:pointer (:struct c-ffmpeg-AVInputFormat))
  (short_name :string))
;; (with-foreign-string (name "x11grab")
;;   (convert-from-foreign (c-ffmpeg-av_find_input_format name) '(:struct c-ffmpeg-AVInputFormat)))

(defstruct ffmpeg-av-input-format
  (ptr #.(null-pointer) :type #.(type-of (null-pointer))))

(defun ffmpeg-av-find-input-format (name)
  (let ((ptr (with-foreign-string (c-name name)
               (c-ffmpeg-av_find_input-format c-name))))
    (if (null-pointer-p ptr)
        nil
        (make-ffmpeg-av-input-format :ptr ptr))))
;; (ffmpeg-av-find-input-format "x11grab")

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
  (options :pointer))

(defun ffmpeg-avformat-open-input (url format options)
  (check-type url string)
  (check-type format ffmpeg-av-input-format)
  (check-type options ffmpeg-dict)
  (with-foreign-object (context-pp :pointer)
    (with-foreign-object (options-pp :pointer)
      (with-foreign-string (c-url url)
        (setf (mem-ref context-pp :pointer) (null-pointer))
        (setf (mem-ref options-pp :pointer) (ffmpeg-dict-ptr options))
        (c-ffmpeg-avformat_open_input context-pp c-url (ffmpeg-av-input-format-ptr format) options-pp)
        (let ((ptr (mem-ref context-pp :pointer)))
          (if (null-pointer-p ptr)
              nil
              (make-ffmpeg-avformat-context :ptr ptr)))))))

;; (ffmpeg-avformat-open-input
;;  ":0"
;;  (ffmpeg-av-find-input-format "x11grab")
;;  (make-ffmpeg-dict))
