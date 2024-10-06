--       █████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗
--      ██╔══██╗██║    ██║██╔════╝██╔════╝██╔═══██╗████╗ ████║██╔════╝
--      ███████║██║ █╗ ██║█████╗  ███████╗██║   ██║██╔████╔██║█████╗
--      ██╔══██║██║███╗██║██╔══╝  ╚════██║██║   ██║██║╚██╔╝██║██╔══╝
--      ██║  ██║╚███╔███╔╝███████╗███████║╚██████╔╝██║ ╚═╝ ██║███████╗
--      ╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝

-- HOME

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local vicious = require("vicious")

require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local lain = require("lain")
local markup = lain.util.markup
local pulsebar = require("lain.widget.pulsebar")

-- Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true
        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end

--

local function run_restart_cmd()
    awful.spawn.with_shell("pkill -u $USER")
end

local function readAll(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

--
--
-- Set your wallpaper directory
local wallpaper_dir = "/home/mahmood/Pictures/BingWallpaper/"
-- Function to set a random wallpaper
local function set_random_wallpaper()
    local wallpapers = {}
    local dir_listing = io.popen('ls "' .. wallpaper_dir .. '"')
    for filename in dir_listing:lines() do
        if filename:match("^.+%.jpg$") or filename:match("^.+%.png$") then
            table.insert(wallpapers, wallpaper_dir .. "/" .. filename)
        end
    end
    dir_listing:close()
    if #wallpapers > 0 then
        local wallpaper = wallpapers[math.random(0, #wallpapers)]
        gears.wallpaper.maximized(wallpaper, nil, true)
    end
end


--
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/chameleon/theme.lua")
-- beautiful.font = "MartianMono Nerd Font Mono Condensed"


-- This is used later as the default terminal and editor to run.
TERMINAL = "wezterm"
EDITOR = os.getenv("EDITOR") or "vim"
EDITOR_CMD = TERMINAL .. " -- " .. EDITOR

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.floating,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

-- Helper functions
local function client_menu_toggle_fn()
    local instance = nil
    return function()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end


-- Menu
-- Create a launcher widget and a main menu

AWESOME_MENU = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual",  TERMINAL .. " -e \"man awesome\"" },
    { "restart", awesome.restart },
    { "quit",    function() awesome.quit() end }
}


-- Need to allow these commands to be run without password
-- Or if you are using systemd: systemctl [suspend|hibernate]
POWER_MENU = {
    { "reboot",   "systemctl reboot" },
    { "suspend",  "systemctl suspend" },
    { "poweroff", "systemctl poweroff" }
}

MAIN_MENU = awful.menu({
    items = {
        { "awesome",  AWESOME_MENU },
        { "idea",     "intellij-idea-ultimate-edition" },
        { "firefox",  "firefox-nightly" },
        { "files",    "nautilus" },
        { "terminal", TERMINAL },
        { "power",    POWER_MENU }
    }
})
LAUNCHER = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = MAIN_MENU
})
-- Menubar configuration
menubar.utils.TERMINAL = TERMINAL -- Set the terminal for applications that require it
-- Keyboard map indicator and switcher
KEYBOARD_LAYOUT = awful.widget.keyboardlayout()


-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_random_wallpaper)

awful.screen.connect_for_each_screen(function(s)

    set_random_wallpaper()

    -- Each screen has its own tag table.
    local spacer1 = wibox.widget.textbox('<span font="artwiz lemon 8">\t</span>')
    local ii = s.index
    names = {}
    for i = 1, 9 do
        table.insert(names, "WK" .. ii .. "." .. i)
    end
    -- local l = awful.layout.suit
    -- local layouts = { l.tile, l.tile, l.tile, l.tile, l.tile, l.tile, l.tile, l.tile }
    awful.tag(names, s, awful.layout.layouts[1])
    -- Create a promptbox for each screen
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({}, 3, function() MAIN_MENU:toggle() end),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
))
-- }}}
--

-- {{{ Key bindings
    GLOBAL_KEYS = gears.table.join(
            awful.key({ modkey, }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

            awful.key({ modkey, "Control"   }, "Left", 
            function()
                for i = 1, screen.count() do
                    awful.tag.viewprev(i)
                end
            end ),

            awful.key({ modkey, "Control"   }, "Right", 
            function()
                for i = 1, screen.count() do
                    awful.tag.viewnext(i)
                end
            end ),

            awful.key({ modkey, }, "Left",   awful.tag.viewprev, { description = "view previous", group = "tag" }),
            awful.key({ modkey, }, "Right",  awful.tag.viewnext, { description = "view next", group = "tag" }),
            awful.key({ modkey, }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
            awful.key({ modkey, }, "j", function() awful.client.focus.byidx(1) end, { description = "focus next by index", group = "client" }),
            awful.key({ modkey, }, "k", function() awful.client.focus.byidx(-1) end, { description = "focus previous by index", group = "client" }),


            -- Layout manipulation
            awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,  {description = "swap with next client by index", group = "client"}),
            awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,  {description = "swap with previous client by index", group = "client"}),
            awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,                       {description = "jump to urgent client", group = "client"}),
            awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
                      {description = "increase the number of master clients", group = "layout"}),
            awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
                      {description = "decrease the number of master clients", group = "layout"}),
            awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
                      {description = "increase the number of columns", group = "layout"}),
            awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
                      {description = "decrease the number of columns", group = "layout"}),
            awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
                      {description = "select next", group = "layout"}),
            awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
                      {description = "select previous", group = "layout"}),
            -- screen focus

            awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end, { description = "focus the next screen", group = "screen" }),

            awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end, { description = "focus the previous screen", group = "screen" }),

            awful.key({ modkey, }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),

            awful.key({ modkey, }, "Tab", 
                    function()
                        awful.client.focus.history.previous()
                        if client.focus then
                            client.focus:raise()
                        end
                    end,
                    { description = "go back", group = "client" }),

            -- Standard program

            awful.key({ modkey, }, "Return", function() awful.spawn(TERMINAL) end, { description = "open a terminal", group = "launcher" }),

            awful.key({ modkey, }, "w", function() MAIN_MENU:show() end, { description = "show main menu", group = "awesome" }),
            awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
            awful.key({ modkey, "Shift" }, "q", run_restart_cmd, { description = "quit awesome", group = "awesome" }),

            -- lock
            awful.key({ modkey, "Shift" }, "l", function() awful.spawn("i3lock") end, { description = "Locks the screen", group = "awesome" }),

            awful.key({ modkey, "Control" }, "n",
                    function()
                    local c = awful.client.restore()
                    -- Focus restored client
                    if c then
                    client.focus = c
                    c:raise()
                    end
                    end,
                    { description = "restore minimized", group = "client" }),

            --- volume control {{{
                awful.key({ modkey, "Shift" }, "End", function() awful.spawn.with_shell("$HOME/bin/volume-control.sh toggle") end,
                        { description = "(un)mute volume", group = "volume" }),
                awful.key({ modkey, "Shift" }, "Left", function() awful.spawn.with_shell("$HOME/bin/volume-control.sh down") end,
                        { description = "lower volume", group = "volume" }),
                awful.key({ modkey, "Shift" }, "Right", function() awful.spawn.with_shell("$HOME/bin/volume-control.sh up") end,
                        { description = "raise volume", group = "volume" }),
                --- }}}
    -- Prompt
        awful.key({ modkey }, "r", function()
                awful.util.spawn_with_shell("rofi -show run")
                end, { description = "run prompt", group = "launcher" }),

        awful.key({ modkey, "Shift" }, "w", function()
                awful.util.spawn_with_shell("rofi -show window")
                end, { description = "run prompt", group = "launcher" }),

        awful.key({ modkey }, "x",
                function()
                awful.prompt.run {
                prompt       = "Run Lua code: ",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
                }
                end,
                { description = "lua execute prompt", group = "awesome" }),
        -- Menubar
            awful.key({ modkey }, "p", function() menubar.show() end, { description = "show the menubar", group = "launcher" })
            )

            clientkeys = gears.table.join(

                    awful.key(
                        { modkey, }, "f", 
                        function(c)
                        c.fullscreen = not c.fullscreen
                        c:raise()
                        end, 
                        { description = "toggle fullscreen", group = "client" }
                        ),

                    awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end, { description = "close", group = "client" }),

                    awful.key(
                        { modkey, "Control" }, "space", 
                        awful.client.floating.toggle,
                        { description = "toggle floating", group = "client" }
                        ),

                    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
                        { description = "move to master", group = "client" }),
                    awful.key({ modkey, }, "o", function(c) c:move_to_screen() end, { description = "move to screen", group = "client" }),
                    awful.key({ modkey, }, "n", function(c) c.minimized = true end, { description = "minimize", group = "client" }),
                    awful.key({ modkey, }, "m", function(c)
                            c.maximized = not c.maximized
                            c:raise()
                            end, { description = "(un)maximize", group = "client" }),
                    awful.key({ modkey, "Control" }, "m", function(c)
                            c.maximized_vertical = not c.maximized_vertical
                            c:raise()
                            end, { description = "(un)maximize vertically", group = "client" }),
                    awful.key({ modkey, "Shift" }, "m", function(c)
                            c.maximized_horizontal = not c.maximized_horizontal
                            c:raise()
                            end, { description = "(un)maximize horizontally", group = "client" })
                        )

                        -- Bind all key numbers to tags.
                        -- Be careful: we use keycodes to make it work on any keyboard layout.
                        -- This should map on the top row of your keyboard, usually 1 to 9.
                        for i = 1, 9 do
                            GLOBAL_KEYS = gears.table.join(GLOBAL_KEYS,
                                    -- View tag only.
                                    awful.key({ modkey }, "#" .. i + 9,
                                        function()
                                            for screen = 1, screen.count() do
                                                local tag = awful.tag.gettags(screen)[i]
                                                if tag then
                                                    awful.tag.viewonly(tag)
                                                end
                                            end
                                        end,
                                        { description = "view tag #" .. i, group = "tag" }),
                                    -- Toggle tag display.
                                    awful.key({ modkey, "Control" }, "#" .. i + 9,
                                        function()
                                        local screen = awful.screen.focused()
                                        local tag = screen.tags[i]
                                        if tag then
                                        awful.tag.viewtoggle(tag)
                                        end
                                        end,
                                        { description = "toggle tag #" .. i, group = "tag" }),
                                -- Move client to tag.
                                    awful.key({ modkey, "Shift" }, "#" .. i + 9,
                                            function()
                                            if client.focus then
                                            local tag = client.focus.screen.tags[i]
                                            if tag then
                                            client.focus:move_to_tag(tag)
                                            end
                                            end
                                            end,
                                            { description = "move focused client to tag #" .. i, group = "tag" }),
                                -- Toggle tag on focused client.
                                    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                                            function()
                                            if client.focus then
                                            local tag = client.focus.screen.tags[i]
                                            if tag then
                                            client.focus:toggle_tag(tag)
                                            end
                                            end
                                            end,
                                            { description = "toggle focused client on tag #" .. i, group = "tag" })
    )
        end

        CLIENT_BUTTONS = gears.table.join(
                awful.button({}, 1, function(c)
                    client.focus = c; c:raise()
                    end),
                awful.button({ modkey }, 1, awful.mouse.client.move),
                awful.button({ modkey }, 3, awful.mouse.client.resize))

        -- Set keys
        root.keys(GLOBAL_KEYS)

        -- Rules
        -- Rules to apply to new clients (through the "manage" signal).
        awful.rules.rules = {
            -- All clients will match this rule.
            {
                rule = {},
                properties = {
                    border_width = beautiful.border_width,
                    border_color = beautiful.border_normal,
                    focus = awful.client.focus.filter,
                    raise = true,
                    keys = clientkeys,
                    buttons = CLIENT_BUTTONS,
                    screen = awful.screen.preferred,
                    placement = awful.placement.no_overlap + awful.placement.no_offscreen
                }
            },

            -- Floating clients.
            {
                rule_any = {
                    instance = {
                        "DTA",   -- Firefox addon DownThemAll.
                            "copyq", -- Includes session name in class.
                    },
                    class = {
                        "Arandr",
                        "Gpick",
                        "Kruler",
                        "MessageWin", -- kalarm.
                            "Sxiv",
                        "Wpa_gui",
                        "pinentry",
                        "veromix",
                        "conky",
                        "xtightvncviewer" },

                    name = {
                        "Event Tester", -- xev.
                    },
                    role = {
                        "AlarmWindow", -- Thunderbird's calendar.
                            "pop-up",      -- e.g. Google Chrome's (detached) Developer Tools.
                    }
                },
                properties = { floating = true }
            },

            -- Add titlebars to normal clients and dialogs
            {
                rule_any = { type = { "normal" }
                },
                properties = { titlebars_enabled = false }
            },
            -- Add titlebars to normal clients and dialogs
            {
                rule_any = { type = { "dialog" }
                },
                properties = { titlebars_enabled = true }
            },

            -- Set Firefox to always map on the tag named "2" on screen 1.
                -- { rule = { class = "Firefox" },
                    --   properties = { screen = 1, tag = "2" } },
        }
    -- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
        not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({}, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c):setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        {     -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Set an initial wallpaper when AwesomeWM starts
set_random_wallpaper()

-- autostart things
awful.spawn.with_shell("sh $HOME/.screenlayout/default.sh")
polybar_path = gears.filesystem.get_configuration_dir() .. 'polybar.sh'
awful.spawn.with_shell("sh " .. polybar_path)

-- }}}
--
--
--

--- Enable for lower memory consumption
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
gears.timer({
	timeout = 5,
	autostart = true,
	call_now = true,
	callback = function()
		collectgarbage("collect")
	end,
})
