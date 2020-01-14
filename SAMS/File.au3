Local $search_file = FileFindFirstFile("C:\ProgramData\Del Mar Reynolds Medical\Sentinel\1.0\License.xml") ;quantidade de ficheiros na pasta
Local $local_temp = "C:\ProgramData\Del Mar Reynolds Medical\Sentinel\1.0\"
;ConsoleWrite("conteudo search_file= " & $search_file & @LF & @LF) ;debug

If $search_file = -1 Then
	Exit
EndIf

Local $file = FileFindNextFile($search_file)
;ConsoleWrite("Nome original: " & $local_temp & $file & @LF)
FileDelete($local_temp & $file); 

FileClose($search_file)