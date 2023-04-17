*** Settings ***
Library             ExcelLibrary
Library             String
Library             OperatingSystem
Library             Dialogs
Library             Collections


*** Variables ***
${excelFile}                ${EXECDIR}/SetupCertVivo_R01.xlsx
${DirectoryReportName}
${excelSheetName}           dataTest



*** Test Cases ***
NumberRotation 00


    NumberRotation_00

*** Keywords ***
NumberRotation_00
    Set Global Variable     ${DirectoryReportName}


    ${value} =    Get Value From User    Informe o numero da linha do teste a ser executado:
 # Abrir excel - Abrir excel, declara variavel e atribuir valor
    Open Excel Document     ${excelFile}        doc_id=doc1

    ${data_01}      Read Excel Cell         ${value}        2       ${excelSheetName}
    ${data_02}      Read Excel Cell         ${value}        3       ${excelSheetName}
    ${data_03}      Read Excel Cell         ${value}        4       ${excelSheetName}
    ${data_04}      Read Excel Cell         ${value}        6       ${excelSheetName}

    ${DirectoryReportName} =        Set Variable        ${EXECDIR}/Resultadode_Testes_Automatizados/${data_01}/${data_02}/${data_03}/${data_04}
    Create Directory        ${DirectoryReportName}
    Log     ${DirectoryReportName}

    Log     ${DirectoryReportName}