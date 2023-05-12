#INCLUDE 'protheus.ch'
#INCLUDE 'totvs.ch'
#INCLUDE 'rwmake.ch'
#INCLUDE 'font.ch'
#INCLUDE 'colors.ch'

//---------------------------------------------------//

/*
{protheus.doc} CalcImc
Tela para calcular o IMC do usuario
@author Rafael Geres   
@since 12/05/2023
*/

//---------------------------------------------------//

user function CalcImc()

Local nAltura := Space(3), nPeso := Space(6)

    @ 200,001 TO 410,480 DIALOG oDlg TITLE OEMTOANSI("Cálculo de IMC")
    @ 02,10 TO 095,230
    @ 10,018 Say " O programa ira calcular o seu IMC - Indice de massa corporal"
    @ 30,018 Say " Digite sua altura em CM"
    @ 37,018 Say " Ex: 187cm (1.87m)"
    @ 30,098 Say " Digite o peso com casas Decimais."
    @ 37,098 Say " Ex: 50,5 ou 60.8"
    @ 45,018 MSGET nAltura SIZE 55,11 of oDlg Pixel Picture "@!"
    @ 45,078 MSGET nPeso SIZE 55,11 of oDlg Pixel Picture "@!"
    @ 70,158 BMPBUTTON TYPE 02 ACTION Close(oDlg)
    @ 70,188 BMPBUTTON TYPE 01 ACTION ContaIMC(nAltura,nPeso)

    activate dialog oDlg CENTERED

RETURN

STATIC Function ContaIMC(nAltura,nPeso)

    Local cTexto := ""
    Local nIMC

    If NumeraPeso(nPeso)

    nAltura := VAL(nAltura)/100 
    nPeso   := VAL(STRTRAN(nPeso,",","."))

    nImc := nPeso / (nAltura ^ 2)

    Do Case
        Case nImc <= 18.5
            cTexto := "Abaixo do Peso"
        Case nImc >= 18.6 .AND. nImc <= 24.9
            cTexto := "Peso Normal"
        Case nImc >= 25 .AND. nImc <= 29.9
            cTexto := "Sobrepeso"
        Case nImc >= 30 .AND. nImc <= 39.9
            cTexto := "Obesidade"
        OtherWise
            cTexto := "gordin ein fi"
    ENDCASE

    MSGINFO("Seu ICM é: " + Alltrim(str(nImc,5,2)) + " e você está " + cTexto)

ELSE
    
    ALERT("Separe os pesos com casas decimais utilizando (.) ou (,)")

ENDIF

RETURN

Static Function NumeraPeso(nPeso)

    Local lRet := .F.
    Local cStrA := ","
    Local cStrB := "."

    If cStrA $ nPeso .OR. cStrB $ nPeso
        lRet := .T.
    ELSE   
        lRet := .F.
    ENDIF

RETURN lRet
