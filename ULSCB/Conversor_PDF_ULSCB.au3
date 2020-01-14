$search_file=0
Local $search_file = FileFindFirstFile("C:\temp\Recebidos\*.pdf") ;quantidade de ficheiros na pasta
ConsoleWrite("conteudo inicial search_file= " & $search_file & @LF & @LF) ;debug
Local $local_temp = "C:\temp\Recebidos\"; Pasta onde o electrocardiografo descarrega os ficheiros gerados
Local $local_erros_PDF = "C:\temp\Erros\"; Pasta de erros
;Local $local_final_PDF = "C:\temp\Movidos PDF\" ;debug
Local $local_final_PDF = "C:\DMR\Sentinel\Sentinel Messaging Service\Inboxes\Philips\"; Pasta oonde o serviço do sentinel vai buscar o pdf
Local $local_final_SCP = "C:\DMR\Sentinel\SCP Import Service\Inboxes\CardioExpress\" ;Pasta oonde o serviço do sentinel vai buscar o SCP
Local $local_ORG = "C:\temp\Originais" ;para debug
Local $Debug = 1

;FileCopy($local_temp, $local_ORG) ;para debug
FileMove($local_temp & "\*.scp", $local_final_SCP,1) ;move os ficheiros SCP para a pasta de processamento do Sentinel

If $search_file = -1 Then
	Exit
EndIf

;While 1
$contagem=0
Do
	;Local $search_file = FileFindFirstFile("C:\temp\Recebidos\*.pdf")
	ConsoleWrite(":. inicio DO - Conteudo váriavel $searchfile: " & $search_file & @LF)
	$contagem=$search_file-1
	ConsoleWrite(":. inicio DO - Conteudo váriavel $contagem: " & $contagem & @LF)
	Local $file = FileFindNextFile($search_file)
    If @error Then exitloop
	$string_array = StringSplit($file,"-") ;divide o nome do ficheiro utilizando o "-"

	If $Debug =1 Then
	  ConsoleWrite(@LF & "Rotina de mover erros" & @LF)
	  ConsoleWrite("Nome original: " & $file & @LF)
      if IsArray($string_array) Then
        For $i = 1 to $string_array[0]
          ConsoleWrite("[" & $i & "] = " & $string_array[$i] & @LF)
	    Next
      EndIf
    Endif

	if UBound($string_array)<=4 then
		$Renamed_file = $file & ".erro"
		ConsoleWrite("renamedfile com erro <4: " & $Renamed_file & @LF & @LF) ; para debug
		$contagem=$contagem-1
		ConsoleWrite(":. Conteudo váriavel $contagem actualizada: " & $contagem & @LF)
		FileMove($local_temp & $file, $local_temp & $renamed_file,1) ;escreve o nome do ficheiro com nome formatado
		FileMove($local_temp & $renamed_file, $local_erros_PDF,1) ;move o ficheiro alterado
    EndIf

Until $contagem>1
;WEnd

;ConsoleWrite(@LF & ":. Debug .:" & @LF)
;ConsoleWrite(":. Conteudo váriavel $searchfile: " & $search_file & @LF)
;ConsoleWrite("Nome Debug: " & $file & @LF)

While 1
	Local $search_file = FileFindFirstFile("C:\temp\Recebidos\*.pdf")
	ConsoleWrite(@LF & ":. Debug dentro de loop .:" & @LF)
	ConsoleWrite(":. Conteudo váriavel $searchfile: " & $search_file & @LF)
    Local $file = FileFindNextFile($search_file)
	If @error Then ExitLoop
	ConsoleWrite("Nome original dentro de loop: " & $file & @LF)

	$string_array = StringSplit($file,"-") ;divide o nome do ficheiro utilizando o "-"

	;para debug
	If $Debug =1 Then
	  ConsoleWrite("Nome original: " & $file & @LF)
      if IsArray($string_array) Then
        For $i = 1 to $string_array[0]
          ConsoleWrite("[" & $i & "] = " & $string_array[$i] & @LF)
	    Next
      EndIf
    Endif

	;Formato recebido NAME-ID-TIME.pdf
	;Renomeia para o formato "Processo"_PatientID_DATE_TIME.pdf
	If UBound($string_array)>5 then
	   $string_array[5] = StringReplace($string_array[5], ".pdf", "", 1, 1)  ;retira o .pdf da stringarray[5]
	   $Renamed_file = "Processo" & "-" & $string_array[3] & "[" & $string_array[4] & "+" & $string_array[5] & "]" & ".pdf" ;não inclui o nome porque o matching no sentinel é feito apenas pelo ID - Pressupoe existencia de OMG com o nome
      ; $Renamed_file = "EC_" & $string_array[3] & "[" & $string_array[4] & "+" & $string_array[5] & "]" & $string_array[2] & "_" & $string_array[1] & ".pdf" ;Renomeia para o formato Processo_PatientID[DATE+TIME].pdf
	   ConsoleWrite("renamedfile: " & $Renamed_file & @LF & @LF) ; para debug
	   FileMove($local_temp & $file, $local_temp & $renamed_file,1) ;escreve o nome do ficheiro com nome formatado
	   FileMove($local_temp & $renamed_file, $local_final_PDF,1) ;move o ficheiro alterado
	EndIf

	;Formato recebido NAME-ID-TIME.pdf
	;Renomeia para o formato  Numero de Processo_PatientID_DATE_TIME.pdf
	if UBound($string_array)<=5 then
	   ;ConsoleWrite("2a opção a ser processada" & @LF & @LF) ; para debug
	   $string_array[4] = StringReplace($string_array[4], ".pdf", "", 1, 1)  ;retira o .pdf da stringarray[4]
	   $Renamed_file = $string_array[1] & "-" & $string_array[2] & "[" & $string_array[3] & "+" & $string_array[4] & "]" & ".pdf"
       ;$Renamed_file = "EC_" & $string_array[1] & "[" & $string_array[2] & "+" & $string_array[3] & "]" & ".pdf" ;Renomeia para o formato EC_PatientID[Date+Time].pdf
	   ConsoleWrite("renamedfile <5: " & $Renamed_file & @LF & @LF) ; para debug
	   FileMove($local_temp & $file, $local_temp & $renamed_file,1) ;escreve o nome do ficheiro com nome formatado
	   FileMove($local_temp & $renamed_file, $local_final_PDF,1) ;move o ficheiro alterado
    EndIf

	; FileDelete($local_temp & $renamed_file); para legacy - não utilizado
WEnd

FileClose($search_file)