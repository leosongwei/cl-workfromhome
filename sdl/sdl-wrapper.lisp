(defun sdl-init (flags)
  (let ((c-flags 0))
    (dolist (flag flags)
      (let ((flag-value (case flag
                          (:video +SDL_INIT_VIDEO+)
                          (otherwise 0))))
        (setf c-flags (logior c-flags flag-value))))
    (c-sdl-init c-flags)))
;; (sdl-init '(:video))

;; -------------------------------------------------
;; Window

(defstruct sdl-window
  (ptr #.(null-pointer)))

(defun sdl-create-window (title x y w h &optional flags)
  (let ((c-flags 0))
    (dolist (flag flags)
      (setf c-flags (logior c-flags (foreign-enum-value 'c-sdl-window-flags flag))))
    (with-foreign-string (c-title title)
      (make-sdl-window :ptr (c-sdl-createwindow c-title x y w h c-flags)))))

(defun sdl-destroy-window (sdl-window)
  (c-sdl-destroywindow (sdl-window-ptr sdl-window)))

;; --------------------------------------------------
;; Renderer
(defstruct sdl-renderer
  (ptr #.(null-pointer)))

(defun sdl-create-renderer (sdl-window flags)
  (let ((c-flags 0))
    (dolist (flag flags)
      (setf c-flags (logior c-flags (foreign-enum-value 'c-sdl-renderer-flags flag))))
    (make-sdl-renderer :ptr (c-sdl-createrenderer (sdl-window-ptr sdl-window)
                                                  -1
                                                  c-flags))))

(defun sdl-renderer-clear (sdl-renderer)
  (c-sdl-renderclear (sdl-renderer-ptr sdl-renderer)))

(defun sdl-renderer-present (sdl-renderer)
  (c-sdl-renderpresent (sdl-renderer-ptr sdl-renderer)))

;; (defparameter +window1+  (sdl-create-window "hello!" 1000 800 400 400
;;                                             '(:sdl_window_resizable)))
;; (sdl-destroy-window +window1+)
;; (defparameter +renderer+ (sdl-create-renderer +window1+ '(:SDL_RENDERER_SOFTWARE)))
;; (sdl-renderer-clear +renderer+)
;; (sdl-renderer-present +renderer+)
