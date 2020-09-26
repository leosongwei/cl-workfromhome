(pkg-config-cflags "sdl2")

(include "SDL.h")
(include "SDL_video.h")

(constant (+SDL_INIT_VIDEO+ "SDL_INIT_VIDEO"))

(cenum c-sdl-window-flags
       ((:SDL_WINDOW_FULLSCREEN_DESKTOP "SDL_WINDOW_FULLSCREEN_DESKTOP"))
       ((:SDL_WINDOW_BORDERLESS "SDL_WINDOW_BORDERLESS"))
       ((:SDL_WINDOW_RESIZABLE "SDL_WINDOW_RESIZABLE"))
       ((:SDL_WINDOW_MINIMIZED "SDL_WINDOW_MINIMIZED"))
       ((:SDL_WINDOW_MAXIMIZED "SDL_WINDOW_MAXIMIZED")))

(cenum c-sdl-renderer-flags
       ((:SDL_RENDERER_SOFTWARE "SDL_RENDERER_SOFTWARE"))
       ((:SDL_RENDERER_ACCELERATED "SDL_RENDERER_ACCELERATED"))
       ((:SDL_RENDERER_PRESENTVSYNC "SDL_RENDERER_PRESENTVSYNC"))
       ((:SDL_RENDERER_TARGETTEXTURE "SDL_RENDERER_TARGETTEXTURE")))

(cenum c-sdl-window-event-id
       ((:SDL_WINDOWEVENT_NONE "SDL_WINDOWEVENT_NONE"))
       ((:SDL_WINDOWEVENT_SHOWN "SDL_WINDOWEVENT_SHOWN"))
       ((:SDL_WINDOWEVENT_HIDDEN "SDL_WINDOWEVENT_HIDDEN"))
       ((:SDL_WINDOWEVENT_EXPOSED "SDL_WINDOWEVENT_EXPOSED"))
       ((:SDL_WINDOWEVENT_MOVED "SDL_WINDOWEVENT_MOVED"))
       ((:SDL_WINDOWEVENT_RESIZED "SDL_WINDOWEVENT_RESIZED"))
       ((:SDL_WINDOWEVENT_SIZE_CHANGED "SDL_WINDOWEVENT_SIZE_CHANGED"))
       ((:SDL_WINDOWEVENT_MINIMIZED "SDL_WINDOWEVENT_MINIMIZED"))
       ((:SDL_WINDOWEVENT_MAXIMIZED "SDL_WINDOWEVENT_MAXIMIZED"))
       ((:SDL_WINDOWEVENT_RESTORED "SDL_WINDOWEVENT_RESTORED"))
       ((:SDL_WINDOWEVENT_ENTER "SDL_WINDOWEVENT_ENTER"))
       ((:SDL_WINDOWEVENT_LEAVE "SDL_WINDOWEVENT_LEAVE"))
       ((:SDL_WINDOWEVENT_FOCUS_GAINED "SDL_WINDOWEVENT_FOCUS_GAINED"))
       ((:SDL_WINDOWEVENT_FOCUS_LOST "SDL_WINDOWEVENT_FOCUS_LOST"))
       ((:SDL_WINDOWEVENT_CLOSE "SDL_WINDOWEVENT_CLOSE"))
       ((:SDL_WINDOWEVENT_TAKE_FOCUS "SDL_WINDOWEVENT_TAKE_FOCUS"))
       ((:SDL_WINDOWEVENT_HIT_TEST "SDL_WINDOWEVENT_HIT_TEST")))

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

