(load (cffi-grovel:process-grovel-file "avformat-grovel.lisp" "/dev/shm/_ffmpeg.o"))

(load-foreign-library "libavformat.so")

(defcfun ("av_register_all" c-ffmpeg-av_register_all) :void)

(defcfun ("av_find_input_format" c-ffmpeg-av_find_input-format) (:pointer (:struct c-ffmpeg-AVInputFormat))
  (short_name :string))

;; (with-foreign-string (name "x11grab")
;;   (convert-from-foreign (c-ffmpeg-av_find_input-format name) '(:struct c-ffmpeg-AVInputFormat)))

;; int avformat_open_input ( AVFormatContext **  	ps,
;; 		const char *  	url,
;; 		AVInputFormat *  	fmt,
;; 		AVDictionary **  	options 
;; 	) 	
