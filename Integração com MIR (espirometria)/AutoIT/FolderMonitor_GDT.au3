
;Sleep(10000)
;Run("C:\MIR\winspiroPRO\winspiroPRO.exe /GDT")

local $path = 'C:\MIR\winspiroPRO\'
$watching = "C:\MIR\winspiroPRO\WPR_*.*"
$moving = "C:\Move\Me\Here\"
;$timetowatch = 30 * 1000
;$timestamp = TimerInit()

While 1
    ;If TimerDiff($timestamp) >= $timetowatch Then
	  $check = FileFindFirstFile($path & "WPR_*.*")
	  If $check <> -1 Then
		 While 1
            $fileName = FileFindNextFile($check)
            If @error Then ExitLoop
              ;MsgBox(4096, "File:", $fileName) ;para debug
			if FileMove($path & $fileName,$path & "WPRO_SEN.GDT") = 1 then
			  ConsoleWrite($fileName & ' renamed to ' & "WPRO_SEN.GDT" & @LF)
		    Else
			  ConsoleWrite('File rename failed for file = ' & $path & $FileName & @LF)
     	    endif
		 WEnd
	  EndIf
	  $check = FileFindFirstFile($path & "*WPRO.*")
      If $check <> -1 Then
         While 1
            $fileName = FileFindNextFile($check)
            If @error Then ExitLoop
               ;MsgBox(4096, "File:", $fileName);para debug
			if FileMove($path & $fileName,$path & "SEN_WPR.GDT") = 1 then
			   ConsoleWrite($fileName & ' renamed to ' & "SEN_WPR.GDT" & @LF)
			Else
			 ConsoleWrite('File rename failed for file = ' & $path & $FileName & @LF)
	 	    endif
		 WEnd
	  EndIf
        ;$timestamp = TimerInit()
    ;EndIf
    Sleep (10)
WEnd