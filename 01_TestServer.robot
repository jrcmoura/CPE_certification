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
    DUT_100-1001


# ------------------------------------------- xxx ---------------------------------------------------

*** Keywords ***

DUT_100-1001

    # Parametrizar a data corrente no formato yyyymmddhhmmss
    # Start Process       sipp -sf /home/cdd/sipp/AUTO/R2992_uas_R01.xml 10.10.1.51 -i 10.10.1.44 -p 5061 -m 100 -l 1 -r 1 -rp 1s -aa           shell=yes       alias=process_03

    Start Process       tcpdump -s 0 -i ens192 -w /home/cdd/ManagerTest/Test_1001.pcap      shell=yes       alias=process_01
    Sleep       5 seconds
    Start Process       sipp -sf /home/cdd/sipp/AUTO/register_R2992_R01.xml 10.10.1.51 -i 10.10.1.44 -p 5061 -m 1 -l 1 -r 1 -rp 1s -aa      shell=yes       alias=process_02
    Sleep       5 seconds
    Start Process       sipp -sf /home/cdd/sipp/AUTO/R2992_uas_R01.xml 10.10.1.51 -i 10.10.1.44 -p 5061 -m 100 -l 1 -r 1 -rp 1s -aa           shell=yes       alias=process_03
    Sleep       5 seconds
    Start Process       sipp -sf /home/cdd/sipp/AUTO/R2990_Invite_PSTN_R04.xml 10.10.1.51 -i 10.10.1.42 -p 5060 -m 1 -d 10s -s 8930276847 -l 1 -r 1 -rp 1s -aa      shell=yes       alias=process_04
    Sleep       35 seconds
    Terminate Process       process_01
    Process Should Be Stopped       process_01
    Terminate Process       process_02      kill=true
    Terminate Process       process_03      kill=true
    Terminate Process       process_04      kill=true
# ------------------------------------------- xxx ---------------------------------------------------
