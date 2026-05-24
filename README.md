# zjstatus-widgets

A [meowctl](https://github.com/meowshed/meowctl) registry module — Hammerspoon Spoon that pushes system state to [zjstatus](https://github.com/dj95/zjstatus) widgets in all active Zellij sessions.

## What it pushes

- Current keyboard layout
- VPN connection state
- Battery level
- CPU usage
- Memory usage
- Focus mode status
- Date and time

## Files

| File | Destination |
|------|-------------|
| `ZJStatusWidgets.spoon/init.lua` | `~/.hammerspoon/Spoons/ZJStatusWidgets.spoon/init.lua` |
| `zjstatus-push-all.fish` | `~/.config/fish/conf.d/zjstatus-push-all.fish` |

## Usage

```python
component("@zjstatus-widgets//zjstatus-widgets")
```

## Dependencies

- `@stdlib//components/hammerspoon`
- `@stdlib//components/fish`
- `@stdlib//components/zellij`

## License

MIT
