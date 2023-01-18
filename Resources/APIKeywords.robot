*** Settings ***
Library               RequestsLibrary
Library               Collections
Library               OperatingSystem 
Library               JSONLibrary
Resource              Variables.robot

*** Keywords ***
Create Auth Header With Token
    [Arguments]        ${token}
    ${auth_header}               Create Dictionary  Authorization=Bearer ${token}
    Set Global Variable    ${GET_HEADERS}        ${auth_header}
    Set To Dictionary    ${auth_header}     Content-Type=application/json
    Set Global Variable    ${POST_HEADER}        ${auth_header}
    Log    ${POST_HEADER}

Get Member by Org and Type
    [Arguments]    ${Org_Admin_Id1}    ${MEMBER_TYPE}
    ${resp}=    GET On Session  host_server    /api/organization/${Org_Admin_Id1}/member/${MEMBER_TYPE}  headers=${GET_HEADERS}  expected_status=200
    Status Should Be                 200  ${resp}
    ${json}=    evaluate    json.loads('''${resp.content}''')    json
    [Return]         ${json['data'][0]['email']}
