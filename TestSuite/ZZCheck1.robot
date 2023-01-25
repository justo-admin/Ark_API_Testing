*** Settings ***
Library               RequestsLibrary
Library               Collections
Library               OperatingSystem 
Library               JSONLibrary
Resource              ../Resources/Variables.robot
Resource              ../Resources/APIKeywords.robot

# *** Variables ***
# ${loop_cnt}        100

# *** Test Cases ***

# Check Loop1
#     FOR    ${counter}    IN RANGE    0    1    
#         Log    ${counter}
#     END

