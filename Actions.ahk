Move() {
    global
    local isLeft := IsKeyDown("Left") || IsKeyDown("J")
    local isUp := IsKeyDown("Up") || IsKeyDown("I")
    local isRight := IsKeyDown("Right") || IsKeyDown("L")
    local isDown := IsKeyDown("Down") || IsKeyDown("K")
            
    if isLeft && isUp && isRight && isDown {
        InitializePositions()
        return
    }
    
    if isLeft {
        if isUp {
            position := _positionTopLeft
        }
        else if isDown {
            position := _positionBottomLeft
        }
        else if isRight {
            position := _positionHome
        }
        else {
            position := _positionLeft
        }
    }
    else if isRight {
        if isUp {
            position := _positionTopRight
        }
        else if isDown {
            position := _positionBottomRight
        }
        else {
            position := _positionRight
        }
    }
    else if isUp {
        if isDown {
            position := _positionHome
        }
        else {
            position := _positionTop
        }
    }
    else if isDown {
        position := _positionBottom
    }
    else {
        position := _positionHome
    }

    local monitor := GetCurrentMonitor()
    local location := _position%monitor%_%position%
    StoreUndoLocation()
    MoveToLocation(location)
}

MoveToLocation(location) {
    if (IsMaximized()) {
        Restore()
    }

    StringSplit, parts, location, `,
    WinMove, A,, %parts1%, %parts2%, %parts3%, %parts4%
}

MoveToNextMonitor() {
    global

    local current := GetCurrentMonitor()
    local next := GetNextMonitor()

    if (current != next) {
        local position := GetCurrentPositionIndex() 
        local location := position > 0 ? _position%next%_%position% : GetNextPosition()
        local isMaximized := IsMaximized()

        MoveToLocation(location)
        
        if (isMaximized) {
            Maximize()
        }
    }
}

UndoMove() {
    global
    local id := WinExist("A")
    local undo := _undo%id%

    if (undo != "") {
        MoveToLocation(undo)
    }
}

MaximizeRestore() {
    if (IsMaximized()) {
        Restore()
    }
    else {
        Maximize()
    }
}

Maximize() {
    WinMaximize, A
}

Minimize() {
    WinMinimize, A
}

Restore() {
    WinRestore, A
}

Close() {
    WinClose, A
}

CloseTab() {
    Send ^w   
}

SetOnTop() {
    WinSet, AlwaysOnTop, On, A
    WinGetTitle, title, A
    WinSetTitle, A, , ::%title%::
}

RemoveOnTop() {
    WinSet, AlwaysOnTop, Off, A
    WinGetTitle, title, A
    
    StringLeft, marker, title, 2
    if (marker = "::") {
        StringTrimLeft, title, title, 2
    }

    StringRight, marker, title, 2
    if (marker = "::") {
        StringTrimRight, title, title, 2
    }
    
    WinSetTitle, A, , %title%
}

IsMaximized() {
    WinGet, maximized, MinMax, A
    return %maximized%
}

IsKeyDown(key) {
    return GetKeyState(key, "P")
}