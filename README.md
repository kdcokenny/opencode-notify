# opencode-notify

> Native OS notifications for OpenCode. Know when your AI is done or needs you.

A plugin for [OpenCode](https://github.com/sst/opencode) that delivers native desktop notifications when tasks complete, errors occur, or the AI needs your input.

## What is this?

`opencode-notify` uses native OS notification systems to keep you informed without watching the terminal:

- **Native feel** - Uses macOS Notification Center, Windows Toast, Linux notify-send
- **Smart defaults** - Only notifies for parent sessions, not every sub-task
- **Terminal-aware** - Suppresses notifications when your terminal is focused
- **Click-to-focus** - Click the notification to bring your terminal to the foreground (macOS)
- **Auto-detection** - Automatically detects 37+ terminal emulators (Ghostty, Kitty, iTerm2, WezTerm, etc.)
- **Zero config** - Works out of the box, customize if you want

## Part of KDCO

This plugin is part of the [KDCO Registry](https://github.com/kdcokenny/ocx/tree/main/registry/src/kdco), a collection of plugins, agents, and skills for OpenCode.

## Installation (Recommended)

Install via [OCX](https://github.com/kdcokenny/ocx), the package manager for OpenCode extensions:

```bash
# Install OCX
curl -fsSL https://ocx.kdco.dev/install.sh | sh
# Or: npm install -g ocx

# Initialize OCX in your project
ocx init

# Add the KDCO registry
ocx registry add --name kdco https://registry.kdco.dev

# Install notifications (included in kdco-workspace)
ocx add kdco-notify
```

## Manual Installation

Copy the source files directly into your `.opencode/` directory:

**Caveats:**
- You'll need to manually install dependencies (`node-notifier`, `detect-terminal`)
- Updates require manual re-copying

The source is in [`src/`](./src) - copy the plugin file to `.opencode/plugin/`.

## Features

### Smart Notification Philosophy

> "Notify the human when the AI needs them back, not for every micro-event."

| Event | Notifies? | Sound | Why |
|-------|-----------|-------|-----|
| Parent session complete | Yes | Glass | Main task done - time to review |
| Parent session error | Yes | Basso | Something broke - needs attention |
| Permission needed | Yes | Submarine | AI is blocked, waiting for you |
| Child session complete | No | - | Orchestrator handles this |

### Terminal Detection

Uses [`detect-terminal`](https://github.com/jonschlinkert/detect-terminal) to automatically identify your terminal emulator. Supports 37+ terminals including:

- Ghostty
- Kitty
- iTerm2
- WezTerm
- Alacritty
- Hyper
- Terminal.app
- Windows Terminal
- VS Code integrated terminal
- And many more...

### Focus Awareness

Inspired by [Ghostty](https://github.com/ghostty-org/ghostty)'s notification system:

- **Suppresses notifications** when your terminal is the active window
- **Only notifies** when you're away or in another app
- Prevents notification spam during active coding sessions

### Click-to-Focus

On macOS, clicking a notification brings your terminal to the foreground. The plugin:

1. Detects which terminal you're using
2. Looks up its bundle ID dynamically
3. Uses that for the notification's click action

### Native OS Integration

Uses [node-notifier](https://github.com/mikaelbr/node-notifier) which bundles native binaries:

- **macOS** - terminal-notifier (NSUserNotificationCenter)
- **Windows** - SnoreToast (Windows Toast API)
- **Linux** - notify-send (libnotify)

No `brew install` or system dependencies required.

### Configuration (Optional)

Create `~/.config/opencode/kdco-notify.json` to customize:

```json
{
  "enabled": true,
  "notifyChildSessions": false,
  "suppressWhenFocused": true,
  "sounds": {
    "idle": "Glass",
    "error": "Basso",
    "permission": "Submarine"
  }
}
```

**Available macOS sounds:** Basso, Blow, Bottle, Frog, Funk, Glass, Hero, Morse, Ping, Pop, Purr, Sosumi, Submarine, Tink

## Platform Support

| Feature | macOS | Windows | Linux |
|---------|-------|---------|-------|
| Native notifications | ✅ | ✅ | ✅ |
| Custom sounds | ✅ | ❌ | ❌ |
| Focus detection | ✅ | ❌ | ❌ |
| Click-to-focus | ✅ | ❌ | ❌ |
| Terminal detection | ✅ | ✅ | ✅ |

## Usage

Once installed, the plugin automatically:

1. Detects your terminal emulator on startup
2. Looks up its bundle ID for click-to-focus
3. Listens for `session.idle`, `session.error`, and `permission.updated` events
4. Checks if the session is a parent (root) session
5. Checks if your terminal is focused (suppresses if yes)
6. Sends a native notification with appropriate sound

No tools are added - it's purely event-driven.

## Source

The implementation is in [`src/`](./src). It's TypeScript, fully readable, and designed to be forked and customized.

## License

MIT
