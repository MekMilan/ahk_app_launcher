global APP_NAME := "App Launcher"
global COMMANDS_PATH := "user_commands"
global GUI_WIDHT := 300
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
    if not WinExist(APP_NAME) {
        gui, -MinimizeBox -Caption +AlwaysOnTop
        gui, margin, 2,2
        gui, color, c2e2e2e, c2e2e2e
        gui, font, cffffff s12
        gui, add, edit, w%GUI_WIDHT% vuser_input gsearch
        gui, add, ListBox, w%GUI_WIDHT% h100 vchosen sort, %commands%
        gui, add, button, ggo Default w0 h0
        gui, show, AutoSize, App Launcher
    }
}

guiClose() {
    gui, Destroy
    ;reload
}
guiEscape() {
    gui, Destroy
    ;reload
}

go() {
    gui, hide
    GuiControlGet, cmd,, chosen
    switch (cmd) {
        case "reload":
            reload
        Default:
            run, %COMMANDS_PATH%\%cmd%.ahk
    }
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
;gui()

!f::gui()
up::up()
down::down()