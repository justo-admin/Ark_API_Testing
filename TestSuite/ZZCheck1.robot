*** Settings ***
Library               RequestsLibrary
Library               Collections
Library               OperatingSystem 
Library               JSONLibrary

*** Variables ***
${loop_cnt}        100

*** Test Cases ***

Check Loop1
    FOR    ${counter}    IN RANGE    1    100    
        Log    ${counter}
    END