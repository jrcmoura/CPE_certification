*** Settings ***
Documentation       Documentação para o testes automaticos VIVO - DUT_100-001
#                   Produto Versão: VIVO-B2B-VOIP-R1A

Library     Collections
Library     OperatingSystem
Library     String
Library     Process
Library     ExcelLibrary
Library     DateTime
Library     Dialogs


# ------------------------------------------- xxx ---------------------------------------------------

*** Variable ***

${excelFile}                ${EXECDIR}/DataTest/VariablesDataTest_R04.xlsx
${SetupCertVivo}            ${EXECDIR}/SetupCertVivo_R01.xlsx
${excelSheetName}           dataTest
${DirectoryReportName}
${CurrentDateTime}
${valueTestSelect}
${FlagTestselected}             0
${countStringVerification}      0
${StringVerification}           200 OK
${TimesStringverification}      3


# ------------------------------------------- xxx ---------------------------------------------------

*** Test Cases ***

    # Teste case - que executa uma chamada SIPP para um numero especifico que sera atendido manualmente
    # Abre um arquivo excel ${excelFile} e registra 4 parametros para execucao da chamada
    # Tipo de Chamada   - SIPP para um numero previamente definido no arquivo Excel
    # Invoca a Keywords - Test_Case_SIPP_PSTN
Teste de certificacao - DUT_100-1001

    Open Excel Document     ${excelFile}        doc_id=doc1

    ${TestName}                     Read Excel Cell     2       2       ${excelSheetName}
    ${ShortStringPacketSniffer}     Read Excel Cell     2       6       ${excelSheetName}
    ${uac_String_RXXXX}             Read Excel Cell     2       8       ${excelSheetName}
    ${SleepTest}                    Read Excel Cell     2       4       ${excelSheetName}

    Close All Excel Documents

    Test_Case_SIPP_PSTN     ${TestName}
    ...                     ${ShortStringPacketSniffer}
    ...                     ${uac_String_RXXXX}
    ...                     ${SleepTest}


# ------------------------------------------- xxx ---------------------------------------------------

    # Teste case - que executa uma chamada SIPP para um numero especifico que sera atendido por uma instancia SIPP
    # Abre um arquivo excel ${excelFile} e registra 7 parametros para execucao da chamada
    # Tipo de Chamada   - SIPP para SIPP - A para B
    # Invoca a Keywords - Test_Case_SIPP_SIPP
Teste de certificacao - DUT_100-1003

   # Abrir excel - Abrir excel, declara variavel e atribuir valor
    Open Excel Document     ${excelFile}        doc_id=doc1

    ${TestName}                     Read Excel Cell     4       2       ${excelSheetName}
    ${ShortStringPacketSniffer}     Read Excel Cell     4       6       ${excelSheetName}
    ${uas_Register_RXXXX}           Read Excel Cell     4       9       ${excelSheetName}
    ${uas_String_RXXXX}             Read Excel Cell     4       7       ${excelSheetName}
    ${uac_String_RXXXX}             Read Excel Cell     4       8       ${excelSheetName}
    ${SleepTest}                    Read Excel Cell     4       4       ${excelSheetName}
    ${SleepProcess}                 Read Excel Cell     4       5       ${excelSheetName}

    Close All Excel Documents

   # Invocar Keyword - Passa 8 parametros para execucao dos processos
    Test_Case_SIPP_SIPP     ${TestName}
    ...                     ${ShortStringPacketSniffer}
    ...                     ${uas_Register_RXXXX}
    ...                     ${uas_String_RXXXX}
    ...                     ${uac_String_RXXXX}
    ...                     ${SleepTest}
    ...                     ${SleepProcess}


# ------------------------------------------- xxx ---------------------------------------------------

    # Teste case - que executa uma chamada SIPP para um numero especifico que sera atendido por uma instancia SIPP
    # Abre um arquivo excel ${excelFile} e registra 7 parametros para execucao da chamada
    # Tipo de Chamada   - SIPP para SIPP - B para A
    # Invoca a Keywords - Test_Case_SIPP_SIPP
Teste de certificacao - DUT_100-1004

   # Abrir excel - Abrir excel, declara variavel e atribuir valor
    Open Excel Document     ${excelFile}        doc_id=doc1

    ${TestName}                     Read Excel Cell     5       2       ${excelSheetName}
    ${ShortStringPacketSniffer}     Read Excel Cell     5       6       ${excelSheetName}
    ${uas_Register_RXXXX}           Read Excel Cell     5       9       ${excelSheetName}
    ${uas_String_RXXXX}             Read Excel Cell     5       7       ${excelSheetName}
    ${uac_String_RXXXX}             Read Excel Cell     5       8       ${excelSheetName}
    ${SleepTest}                    Read Excel Cell     5       4       ${excelSheetName}
    ${SleepProcess}                 Read Excel Cell     5       5       ${excelSheetName}

    Close All Excel Documents

   # Invocar Keyword - Passa 7 parametros para execucao dos processos
    Test_Case_SIPP_SIPP     ${TestName}
    ...                     ${ShortStringPacketSniffer}
    ...                     ${uas_Register_RXXXX}
    ...                     ${uas_String_RXXXX}
    ...                     ${uac_String_RXXXX}
    ...                     ${SleepTest}
    ...                     ${SleepProcess}


# ------------------------------------------- xxx ---------------------------------------------------

*** Keywords ***

ManipulateCurrentTme

    # Parametrizar a data corrente no formato yyyymmddhhmmss
    ${CurrentDateTime}=  Get Current Date       result_format=%Y%m%d%H%M%S
    [return]        ${CurrentDateTime}


# ------------------------------------------- xxx ---------------------------------------------------

CreateDirectoryReports

    # Solicitar informacao manual do operador para determinar os parametros de emissao dos relatorios
    ${valueTestSelect}      Get Value From User     Digite o numero da linha do teste a ser executado (Ex. 10):

    # Abrir excel - Abrir excel, declara variavel e atribuir valor
    Open Excel Document     ${SetupCertVivo}        doc_id=doc2
    ${manufacturerAlias}        Read Excel Cell         ${valueTestSelect}      2       ${excelSheetName}
    ${productType}              Read Excel Cell         ${valueTestSelect}      3       ${excelSheetName}
    ${productName}              Read Excel Cell         ${valueTestSelect}      4       ${excelSheetName}
    ${firmwareAlias}            Read Excel Cell         ${valueTestSelect}      6       ${excelSheetName}
    Close All Excel Documents

    ${DirectoryReportName} =        Set Variable        ${EXECDIR}/Resultadode_Testes_Automatizados/${manufacturerAlias}/${productType}/${productName}/${firmwareAlias}
    Create Directory        ${DirectoryReportName}
    [return]        ${DirectoryReportName}


# ------------------------------------------- xxx ---------------------------------------------------

    # Keyword que executa uma chamada SIPP para um numero especifico que sera atendido manualmente
    # Recebe 4 parametros do Test  Case e executa os processos para a chamada
    # Tipo de Chamada   - SIPP para PSTN ou CELULAR
Test_Case_SIPP_PSTN
    [Arguments]     ${TestName}
    ...             ${ShortStringPacketSniffer}
    ...             ${uac_String_RXXXX}
    ...             ${SleepTest}


    Log     ${FlagTestselected}
    IF  ${FlagTestSelected} <= 0
        # Solicita parametrizacao para montagem da estrutura de arquivos para registros de logs.
        ${DirectoryReportLocal} =    CreateDirectoryReports
        Set Global Variable     ${DirectoryReportName}      ${DirectoryReportLocal}
        # Solicita parametrizacao da data corrente no formato yyyymmddhhmmss.
        ${CurrentDateTimeLocal} =     ManipulateCurrentTme
        Set Global Variable     ${CurrentDateTime}      ${CurrentDateTimeLocal}
        Set Global Variable     ${FlagTestSelected}     1
    END


    ${StringPacketSniffer} =        Set Variable        ${ShortStringPacketSniffer}${DirectoryReportName}/${TestName}_DUMP_${CurrentDateTime}.pcap
    ${FileLogPath} =                Set Variable        ${DirectoryReportName}/${TestName}_LOG_${CurrentDateTime}.log
    ${FileStatPath} =               Set Variable        ${DirectoryReportName}/${TestName}_STAT_${CurrentDateTime}.csv

    # Run the capture packet data from a network
    Start Process       ${StringPacketSniffer}      shell=yes       alias=process_dumpcmd
    # Start SIPP client
    Start Process       ${uac_String_RXXXX} -trace_msg -message_file ${FileLogPath} -trace_stat -stf ${FileStatPath}     shell=yes      alias=process_sipp_uac
    # Pauses the test by in seconds
    Sleep       ${SleepTest}
    # Terminate Process capture packet data from a network
    Terminate Process       process_dumpcmd
    Process Should Be Stopped       process_dumpcmd
    # Terminate Process sipp uac
    Terminate Process       process_sipp_uac    kill=true

    ${TextFileContent}=     Get File        ${FileLogPath}
    ${countStringVerification} =       Get Count        ${TextFileContent}     ${StringVerification}
    Should Be True      ${countStringVerification} >= ${TimesStringverification}


# ------------------------------------------- xxx ---------------------------------------------------

    # Keywords - que executa uma chamada SIPP para um numero especifico, entra em uma interface FXO e sera atendido em uma instancia do SIPP
    # Recebe 7 parametros do Test  Case e executa os processos para a chamada
    # Tipo de Chamada   - SIPP para SIPP
Test_Case_SIPP_SIPP
    [Arguments]     ${TestName}
    ...             ${ShortStringPacketSniffer}
    ...             ${uas_Register_RXXXX}
    ...             ${uas_String_RXXXX}
    ...             ${uac_String_RXXXX}
    ...             ${SleepTest}
    ...             ${SleepProcess}

    IF  ${FlagTestSelected} <= 0
        # Solicita parametrizacao para montagem da estrutura de arquivos para registros de logs.
        ${DirectoryReportLocal} =    CreateDirectoryReports
        Set Global Variable     ${DirectoryReportName}      ${DirectoryReportLocal}
        # Solicita parametrizacao da data corrente no formato yyyymmddhhmmss.
        ${CurrentDateTimeLocal} =     ManipulateCurrentTme
        Set Global Variable     ${CurrentDateTime}      ${CurrentDateTimeLocal}
        Set Global Variable     ${FlagTestSelected}     1
    END


    ${StringPacketSniffer} =        Set Variable        ${ShortStringPacketSniffer}${DirectoryReportName}/${TestName}_DUMP_${CurrentDateTime}.pcap
    ${FileLogPath} =                Set Variable        ${DirectoryReportName}/${TestName}_LOG_${CurrentDateTime}.log
    ${FileStatPath} =               Set Variable        ${DirectoryReportName}/${TestName}_STAT_${CurrentDateTime}.csv


    # Inicia processo - Iniciar captura de pacote
    Start Process       ${StringPacketSniffer}      shell=yes       alias=process_dumpcmd
    Sleep       5 seconds
    # Inicia processo - Register Ramal UAS RXXXX - Ver VariablesDataTest_R01.xlsx
    Start Process       ${uas_Register_RXXXX}       shell=yes     alias=process_sipp_uas_reg
    Sleep       5 seconds
    #Start process - Instanciar SIPP server Ramal RXXXX - Ver VariablesDataTest_R01.xlsx
    Start Process       ${uas_String_RXXXX}         shell=yes      alias=process_sipp_uas
    # Pausa a execucao - Aguarda que o server UAS estabilize
    Sleep       5 seconds
    # Inicia processo - Instanciar e regitrar SIPP UAC Ramal RXXXX - Ver VariablesDataTest_R01.xlsx
    Start Process       ${uac_String_RXXXX} -trace_msg -message_file ${FileLogPath} -trace_stat -stf ${FileStatPath}        shell=yes      alias=process_sipp_uac
    # Pausa a execucao - Aguardar troca de mensagens e audio
    Sleep       ${SleepTest}

    # Finaliza processo - capture packet
    Terminate Process       process_dumpcmd
    Process Should Be Stopped       process_dumpcmd
    # Finaliza processo - process sipp uas register
    Terminate Process       process_sipp_uas_reg        kill=true
    # Finaliza processo - sipp uas
    Terminate Process       process_sipp_uas    kill=true
    #Finaliza processo - sipp uac
    Terminate Process       process_sipp_uac    kill=true
    Sleep       ${SleepProcess}
    ${TextFileContent}=     Get File        ${FileLogPath}
    ${countStringVerification} =        Get Count       ${TextFileContent}     ${StringVerification}
    Should Be True      ${countStringVerification} >= ${TimesStringverification}

    # ------------------------------------------- xxx ---------------------------------------------------