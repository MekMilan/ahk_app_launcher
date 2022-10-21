global APP_NAME := "App Launcher"
global COMMANDS_PATH := "user_commands"
global user_input
global chosen
global commands

commands() {
    loop, files, %COMMANDS_PATH%\*
    {
        command_name := StrReplace(A_LoopFileName, ".ahk", "")
        commands .= command_name "|"
    }
}

gui() {
    gui, -MinimizeBox -Caption +AlwaysOnTop
    gui, margin, 2,2
    gui, add, edit, vuser_input gsearch
    gui, add, ListBox, h100 vchosen sort, %commands%
    gui, add, button, ggo Default w0 h0
    gui, show, AutoSize, App Launcher
}

guiClose() {
    reload
}
guiEscape() {
    reload
}

go() {
    gui, hide
    GuiControlGet, cmd,, chosen
    run, %COMMANDS_PATH%\%cmd%.ahk
    gui, destroy
}

search() {
    gui, Submit, NoHide
    guicontrol, ChooseString, chosen, %user_input%
}

up() {
    if WinActive(APP_NAME) {
        GuiControl, focus, chosen
        send {up}
        GuiControl, focus, user_input
    }
    else {
        send {up}
    }
}

down() {
    if WinActive(APP_NAME) {
        GuiControl, focus, chosen
        send {down}
        GuiControl, focus, user_input
    }
    else {
        send {down}
    }
}

commands()
gui()

!f::gui()
up::up()
down::down()