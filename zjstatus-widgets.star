# zjstatus-widgets.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/hammerspoon", "@stdlib//components/fish", "@stdlib//components/curl"]
#
# Hammerspoon Spoon: event-driven zjstatus pipe widgets for zellij.
# Pushes keyboard layout, VPN state, battery, CPU, memory, focus mode,
# date and time to all active zellij sessions.
#
# Also installs zjstatus.wasm into ~/.config/zellij/plugins/ and a fish
# conf.d snippet that bootstraps widget push on zellij session attach.

ZJSTATUS_VERSION = "v0.23.0"
ZJSTATUS_URL = "https://github.com/dj95/zjstatus/releases/download/%s/zjstatus.wasm" % ZJSTATUS_VERSION

platforms = ["macos"]
after = ["@stdlib//components/hammerspoon", "@stdlib//components/fish", "@stdlib//components/curl"]

def install(ctx):
    home = ctx.env("HOME")
    plugins_dir = home + "/.config/zellij/plugins"
    ctx.mkdir(plugins_dir)
    ctx.run("curl", ["-fsSL", ZJSTATUS_URL, "-o", plugins_dir + "/zjstatus.wasm"])
    ctx.link_file(
        src = "ZJStatusWidgets.spoon/init.lua",
        dst = home + "/.hammerspoon/Spoons/ZJStatusWidgets.spoon/init.lua",
    )
    ctx.link_file(
        src = "zjstatus-push-all.fish",
        dst = home + "/.config/fish/conf.d/zjstatus-push-all.fish",
    )

def upgrade(ctx):
    install(ctx)

def verify(ctx):
    home = ctx.env("HOME")
    if not ctx.file_exists(home + "/.config/zellij/plugins/zjstatus.wasm"):
        ctx.log("zjstatus-widgets: zjstatus.wasm not found")
    if not ctx.file_exists(home + "/.hammerspoon/Spoons/ZJStatusWidgets.spoon/init.lua"):
        ctx.log("zjstatus-widgets: Spoon not found")
    if not ctx.file_exists(home + "/.config/fish/conf.d/zjstatus-push-all.fish"):
        ctx.log("zjstatus-widgets: fish conf.d snippet not found")

def uninstall(ctx):
    home = ctx.env("HOME")
    ctx.delete_file(home + "/.config/zellij/plugins/zjstatus.wasm")
    ctx.remove_symlink(home + "/.hammerspoon/Spoons/ZJStatusWidgets.spoon/init.lua")
    ctx.remove_symlink(home + "/.config/fish/conf.d/zjstatus-push-all.fish")
