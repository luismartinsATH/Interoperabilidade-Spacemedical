#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

$search_file=0
Local $search_file = FileFindFirstFile("C:\temp\Dicom\*.dcm") ;quantidade de ficheiros DCM na pasta
;ConsoleWrite("conteudo inicial search_file= " & $search_file & @LF & @LF) ;para debug
Local $local_temp = "C:\temp\Dicom\"; Pasta onde o event engine grava os ficheiros DCM
Local $local_final_PDF = "\\10.0.0.5\recursos$\"; Pasta onde gravar os PDF extraidos
Local $local_final_DCM = "C:\DMR\Sentinel\DICOM\" ;Pasta onde o serviço DICOM do sentinel vai buscar o ficheiro dcm
Local $local_ORG = "C:\temp\Dicom\Originais\" ;para debug
Local $Debug = 0

;FileCopy($local_temp, $local_ORG, 1) ;para debug - cria cópia do ficheiro dcm original

If $search_file = -1 Then
	Exit
EndIf

Do
	$contagem=$search_file-1 ;controla o loop
	Local $file = FileFindNextFile($search_file) ;encontra o proximo ficheiro DCM
    If @error Then exitloop

	If $Debug =1 Then
		ConsoleWrite(@LF & "Nome original: " & $file & @LF)
	Endif

	$comando_dcm2pdf = "dcm2pdf " & $local_temp & $file & " " & $local_temp & $file & ".pdf" ;preparação do comando com os argumentos a passar
	$filepdf= $local_temp & $file & ".pdf"

	; ConsoleWrite("comando dcm2pdf: " & $comando_dcm2pdf & @LF) ;Para debug
	; ConsoleWrite("nome do ficheiro pdf: " & $filepdf & @LF) ;Para debug

	runwait($comando_dcm2pdf, "C:\ProgramData\Del Mar Reynolds Medical\Sentinel\scripts", @SW_HIDE ) ;corre o conversor dcm2pdf

	FileMove($local_temp & "\*.pdf", $local_final_PDF,1) ;Move os PDF para o destino final
	FileMove($local_temp & $file, $local_final_DCM,1) ;Move o DCM processado para o destino final, para processamento do DICOM service

	$contagem=$contagem-1

Until $contagem>1

FileClose($search_file)