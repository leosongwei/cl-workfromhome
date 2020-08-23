(pkg-config-cflags "sdl2")

(include "SDL.h")
(include "SDL_video.h")

(constant (+SDL_INIT_VIDEO+ "SDL_INIT_VIDEO"))

(cenum c-sdl-window-flags
       ((:SDL_WINDOW_FULLSCREEN_DESKTOP "SDL_WINDOW_FULLSCREEN_DESKTOP"))
       ((:SDL_WINDOW_BORDERLESS+ "SDL_WINDOW_BORDERLESS"))
       ((:SDL_WINDOW_RESIZABLE+ "SDL_WINDOW_RESIZABLE"))
       ((:SDL_WINDOW_MINIMIZED+ "SDL_WINDOW_MINIMIZED"))
       ((:SDL_WINDOW_MAXIMIZED+ "SDL_WINDOW_MAXIMIZED")))

(cstruct c-sdl-PixelFormat "SDL_PixelFormat"
         (format "format" :type :uint32)
         (bytes-per-pixel "BytesPerPixel" :type :uint8)
         (r-mask "Rmask" :type :uint32)
         (g-mask "Gmask" :type :uint32)
         (b-mask "Bmask" :type :uint32)
         (a-mask "Amask" :type :uint32))

(cstruct c-sdl-Surface "SDL_Surface"
         (format "format" :type :pointer) ;; SDL_PixelFormat*
         (w "w" :type :int)
         (h "h" :type :int)
         (pixels "pixels" :type :pointer)
         (clip-rect "clip_rect" :type :pointer) ;; SDL_Rect
         (refcount "refcount" :type :int))

