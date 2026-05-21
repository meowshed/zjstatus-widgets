# zjstatus-widgets.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/hammerspoon", "@stdlib//components/fish"]
#
# Hammerspoon Spoon: event-driven zjstatus pipe widgets for zellij.
# Pushes keyboard layout, VPN state, battery, CPU, memory, focus mode,
# date and time to all active zellij sessions.
#
# Also installs a fish conf.d snippet that bootstraps widget push on
# zellij session attach.

platforms = ["macos"]
after = ["@stdlib//components/hammerspoon", "@stdlib//components/fish"]

def install(ctx):
    home = ctx.env("HOME")
    ctx.link_file(
        src = "ZJStatusWidgets.spoon/init.lua",
        dst = home + "/.hammerspoon/Spoons/ZJStatusWidgets.spoon/init.lua",
    )
    ctx.link_file(
        src = "zjstatus-push-all.fish",
        dst = home + "/.config/fish/conf.d/zjstatus-push-all.fish",
    )

def verify(ctx):
    home = ctx.env("HOME")
    if not ctx.file_exists(home + "/.hammerspoon/Spoons/ZJStatusWidgets.spoon/init.lua"):
        ctx.log("zjstatus-widgets: Spoon not found")
    if not ctx.file_exists(home + "/.config/fish/conf.d/zjstatus-push-all.fish"):
        ctx.log("zjstatus-widgets: fish conf.d snippet not found")

def uninstall(ctx):
    home = ctx.env("HOME")
    ctx.remove_symlink(home + "/.hammerspoon/Spoons/ZJStatusWidgets.spoon/init.lua")
    ctx.remove_symlink(home + "/.config/fish/conf.d/zjstatus-push-all.fish")
