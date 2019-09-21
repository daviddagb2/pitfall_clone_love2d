function love.conf(t)
    t.title = "Pitfall remake"		-- The title of the window the game is in (string)
    t.window.width = 384 ---384	  192		    -- The window width (number)
    t.window.height = 320 -- 320	 260		    -- The window height (number)
    t.window.fullscreen = false		-- Enable fullscreen (boolean)
    t.window.vsync = true			    -- Enable vertical sync (boolean)
    t.console = true
    t.window.resizable = false          -- Let the window be user-resizable (boolean)

    t.accelerometerjoystick = true      -- Enable the accelerometer on iOS and Android by exposing it as a Joystick (boolean)
    t.window.icon = nil                 -- Filepath to an image to use as the window's icon (string)
end