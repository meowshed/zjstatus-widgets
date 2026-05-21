# MIT License
#
# Copyright (c) 2025 Andrew Vasilyev <me@retran.me>
#
# @file: components/zjstatus-widgets/conf.d/zjstatus-push-all.fish
# @brief: Push all zellij status widgets via Hammerspoon on session attach/start

# Guard: only run inside a zellij session
if not set -q ZELLIJ_SESSION_NAME
    exit 0
end

# Fire-and-forget: ask Hammerspoon to push all zjstatus widgets for this session
hs -c "ZJStatusPushAll('$ZELLIJ_SESSION_NAME')" &
