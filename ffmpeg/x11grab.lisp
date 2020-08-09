(defcfun ("x11grab_read_header" c-ffmpeg-x11grab_read_header) :int
  (context (:pointer (:struct c-ffmpeg-AVFormatContext))))

;; (with-foreign-string (name "x11grab")
;;   (convert-from-foreign (c-ffmpeg-av_find_input-format name) '(:struct c-ffmpeg-AVInputFormat)))
