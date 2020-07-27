(load (cffi-grovel:process-grovel-file "avutil-grovel.lisp" "/dev/shm/_ffmpeg.o"))
(load-foreign-library "libavutil.so")

(defcfun ("av_dict_set" c-ffmpeg-av_dict_set) :int
  (pm :pointer) (key :string) (value :string) (flags :int))

(defcfun ("av_dict_get" c-ffmpeg-av_dict_get) (:pointer (:struct c-ffmpeg-AVDictionaryEntry))
  (m :pointer)
  (key :string)
  (prev (:pointer (:struct c-ffmpeg-AVDictionaryEntry)))
  (flags :int))

;; ----------------------------------------

(defstruct ffmpeg-dict
  (ptr #.(null-pointer) :type #.(type-of (null-pointer))))

(defun ffmpeg-dict-ref (ffmpeg-dict key)
  (with-foreign-string (c-key key)
    (let ((ptr (ffmpeg-dict-ptr ffmpeg-dict))
          (result-ptrs '())
          (flags 0))
      (do ((entry (c-ffmpeg-av_dict_get ptr c-key (null-pointer) flags)
                  (c-ffmpeg-av_dict_get ptr c-key entry flags)))
          ((null-pointer-p entry) nil)
        (push entry result-ptrs))
      (mapcar
       (lambda (result) (getf
                         (convert-from-foreign result '(:struct c-ffmpeg-AVDictionaryEntry))
                         'value))
       result-ptrs))))

