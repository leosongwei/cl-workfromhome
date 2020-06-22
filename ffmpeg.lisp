(ql:quickload 'cffi)
(ql:quickload 'cffi-grovel)

(use-package :cffi)
(load (cffi-grovel:process-grovel-file "ffmpeg-grovel.lisp" "/dev/shm/_ffmpeg.o"))

(define-condition c-ffmpeg-condition (error)
  ((message :initarg :message)
   (data :initarg :data))
  (:report (lambda (condition stream)
             (format stream "message: ~A~%data: ~A~%"
                     (slot-value condition 'message)
                     (slot-value condition 'data)))))
(defun c-ffmpeg-condition (message &optional data)
  (error (make-condition 'c-ffmpeg-condition
                         :message message
                         :data data)))
;; (c-ffmpeg-condition "no!!!!" "I'am your father!")

;; load ffmpeg libraries
(load-foreign-library "libavcodec.so")

;; ---------------------------------------------------------------
;; AVCodec functions

(defstruct ffmpeg-avcodec
  (ptr #.(null-pointer) :type #.(type-of (null-pointer))))

(defcfun ("avcodec_find_encoder_by_name"
          c-ffmpeg-avcodec_find_encoder_by_name)
    (:pointer (:struct c-ffmpeg-AVCodec))
  (codec_name :string))
;; (foreign-slot-value (c-ffmpeg-avcodec_find_encoder_by_name "libx264")
;;                    '(:struct c-ffmpeg-AVCodec)
;;                    'name)

(defun ffmpeg-find-encoder-by-name (encoder-name)
  (let ((ptr
         (with-foreign-string (c-name encoder-name)
           (c-ffmpeg-avcodec_find_encoder_by_name c-name))))
    (if (null-pointer-p ptr)
        (c-ffmpeg-condition "Unable to find specified codec"
                            (format nil "encoder-name: ~A" encoder-name)))
    (make-ffmpeg-avcodec :ptr ptr)))
;; (ffmpeg-find-encoder-by-name "libx264")
;; (ffmpeg-find-encoder-by-name "2333")

(defstruct ffmpeg-avcodec-context
  (ptr #.(null-pointer) :type #.(type-of (null-pointer))))

(defcfun ("avcodec_alloc_context3"
          c-ffmpeg-avcodec_alloc_context3)
    (:pointer (:struct c-ffmpeg-AVCodecContext))
  (codec :pointer))

(defun ffmpeg-avcodec-alloc-context3 (ffmpeg-avcodec)
  (check-type ffmpeg-avcodec ffmpeg-avcodec)
  (let ((ptr (c-ffmpeg-avcodec_alloc_context3 (ffmpeg-avcodec-ptr ffmpeg-avcodec))))
    (if (null-pointer-p ptr)
        (c-ffmpeg-condition "Could not allocate AVCodecContext"))
    (make-ffmpeg-avcodec-context :ptr ptr)))
;; (ffmpeg-avcodec-alloc-context3 (ffmpeg-find-encoder-by-name "libx264"))
;; (let ((ptr (ffmpeg-avcodec-context-ptr
;;             (ffmpeg-avcodec-alloc-context3
;;              (ffmpeg-find-encoder-by-name "libx264")))))
;;   (foreign-slot-value ptr '(:struct c-ffmpeg-AVCodecContext) 'codec))

(defstruct ffmpeg-av-packet
  (ptr #.(null-pointer) :type #.(type-of (null-pointer))))

(defcfun ("av_packet_alloc" c-ffmpeg-av_packet_alloc) :pointer)

(defun ffmpeg-av-packet-alloc ()
  (let ((ptr (c-ffmpeg-av_packet_alloc)))
    (if (null-pointer-p ptr)
        (c-ffmpeg-condition "Could not allocat AVPacket"))
    (make-ffmpeg-av-packet :ptr ptr)))



