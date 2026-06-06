# zjstatus-widgets.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/hammerspoon", "@stdlib//components/fish", "@stdlib//components/curl"]
#
# Hammerspoon Spoon: event-driven zjstatus pipe widgets for zellij.
# Pushes keyboard layout, VPN state, battery, CPU, memory, focus mode,
# date and time to all active zellij sessions.
#
# Downloads zjstatus.wasm into ~/.config/zellij/plugins/ and symlinks
# the Hammerspoon Spoon and fish conf.d snippet.

platforms = ["macos"]
after = ["@stdlib//components/hammerspoon", "@stdlib//components/fish", "@stdlib//components/zellij"]

_ZJSTATUS_URL = "https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm"

def install(ctx):
    home = ctx.env("HOME")
    ctx.mkdir(home + "/.hammerspoon/Spoons/ZJStatusWidgets.spoon")
    ctx.link_file(
        src = "ZJStatusWidgets.spoon/init.lua",
        dst = home + "/.hammerspoon/Spoons/ZJStatusWidgets.spoon/init.lua",
    )
    ctx.mkdir(home + "/.config/fish/conf.d")
    ctx.link_file(
        src = "zjstatus-push-all.fish",
        dst = home + "/.config/fish/conf.d/zjstatus-push-all.fish",
    )
    plugins_dir = home + "/.config/zellij/plugins"
    ctx.mkdir(plugins_dir)
    zjstatus_dest = plugins_dir + "/zjstatus.wasm"
    if not ctx.file_exists(zjstatus_dest):
        ctx.log("zjstatus-widgets: downloading zjstatus.wasm...")
        ctx.run("curl", ["-fsSL", _ZJSTATUS_URL, "-o", zjstatus_dest])
        ctx.run("chmod", ["644", zjstatus_dest])

def upgrade(ctx):
    install(ctx)

def verify(ctx):
    home = ctx.env("HOME")
    if not ctx.file_exists(home + "/.hammerspoon/Spoons/ZJStatusWidgets.spoon/init.lua"):
        ctx.log("zjstatus-widgets: Spoon not found")
    if not ctx.file_exists(home + "/.config/fish/conf.d/zjstatus-push-all.fish"):
        ctx.log("zjstatus-widgets: fish conf.d snippet not found")
    if not ctx.file_exists(home + "/.config/zellij/plugins/zjstatus.wasm"):
        ctx.log("zjstatus-widgets: zjstatus.wasm not found")

def uninstall(ctx):
    home = ctx.env("HOME")
    ctx.remove_symlink(home + "/.hammerspoon/Spoons/ZJStatusWidgets.spoon/init.lua")
    ctx.remove_symlink(home + "/.config/fish/conf.d/zjstatus-push-all.fish")
