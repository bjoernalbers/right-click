# right-click

A macOS-package to automatically enable right-click on the Apple Magic Mouse.

## Motivation

Users usually enable 
[right-click on Mac](https://support.apple.com/guide/mac-help/right-click-mh35853/mac)
via "System Settings" > "Mouse" > "Secondary click".
Administrators who want to automatically enable the right-click on multiple Macs  encounter a
problem:
This mouse setting *cannot* be controlled by a configuration profile on recent versions of macOS.

However, running these commands followed by a restart works:

    defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode TwoButton
    defaults write com.apple.AppleMultitouchMouse MouseButtonMode TwoButton

Source: https://apple.stackexchange.com/questions/118585/is-it-possible-to-enable-mouse-right-click-via-terminal

This payload-free package executes those commands in the context of the
currently logged-in user in order to automatically enable right-click.

## Usage

1. Make sure the user is logged-in
2. Download and install [latest release of this package](https://github.com/bjoernalbers/right-click/releases/latest)
3. Restart Mac
