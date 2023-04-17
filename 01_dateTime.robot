
*** Settings ***
Library  DateTime


*** Test Cases ***
Manipulate Current Time test
    Manipulate current time

*** Keywords ***
Manipulate current time
    ${CurrentDate}=  Get Current Date  result_format=%Y-%mm-%dd %HH:%MM:%SS.%ff

    ${datetime} =	Convert Date  ${CurrentDate}  datetime
    Log  ${datetime.year}
    Log	 ${datetime.month}
    Log	 ${datetime.day}
    Log	 ${datetime.hour}
    Log	 ${datetime.minute}
    Log	 ${datetime.second}
    Log	 ${datetime.microsecond}

    #${date} =	Get Current Date        result_format=timestamp
    #${timestamp} =  Get Timestamp       result_format=%Y%mm%dd%HH%MM%SS
    ${CurrentDate}=  Get Current Date  result_format=%Y%m%d%H%M%S

    log     ${CurrentDate}