*** Settings ***
Library     ${EXECDIR}/UseFul/usefulFunctions.py
Library     OperatingSystem


*** Variable ***
${statusCheck}      PASSOU!
${fileName}         ${EXECDIR}/Results/Test_1001.log
${stringSearch}     200 OK
${countCheckNumber}     3

*** Test Case ***
Localizar Sring
    LocalizarSring

*** Keywords ***

LocalizarSring
    log     ${fileName}
    log     ${stringSearch}

    #${count} =       Get Count      ${fileName}      ${fileName}
    #Should Be True	-1 < ${count} < 1

    ${TextFileContent}=     Get File        ${fileName}
    ${count} =       Get Count       ${TextFileContent}      REGISTER
    Should Be True      ${count} > ${countCheckNumber}
    Log     ${count}
