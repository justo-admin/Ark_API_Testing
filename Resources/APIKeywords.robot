*** Settings ***
Library               RequestsLibrary
Library               Collections
Library               OperatingSystem 
Library               JSONLibrary
Resource              Variables.robot
Library               ../Utils/csv_pandas.py

*** Keywords ***

Get Server Test and Counter
    ${response}=    GET  ${ARK_STAGE_SERVER}
    Create Session    host_server  ${ARK_STAGE_SERVER}     verify=true
    ${json}=    Load JSON From File    ${counter_file_path}
    Set Global variable    ${COUNTER}    ${json['counter']}
    Log    ${COUNTER}

Update Counter in File
    ${COUNTER}=    Evaluate    ${COUNTER}+1
    ${counter_dict}=    Create Dictionary    counter=${COUNTER}
    ${counter_update}=    Convert JSON to String    ${counter_dict}
    Create File    ${counter_file_path}    ${counter_update}    UTF-8

Create Auth Header With Token
    [Arguments]        ${token}
    ${auth_header}               Create Dictionary  Authorization=Bearer ${token}
    Set Global Variable    ${GET_HEADERS}        ${auth_header}
    Set To Dictionary    ${auth_header}     Content-Type=application/json
    Set Global Variable    ${POST_HEADER}        ${auth_header}
    Log    ${POST_HEADER}

Create an Organization 
    [Arguments]    ${new_org} 
    ${resp}=    POST On Session    host_server  /api/staff/organization   headers=${POST_HEADER}     
    ...    json=${new_org}  expected_status=anything
    Status Should Be                 200  ${resp} 
    log         ${resp.content}
    ${json}=    evaluate    json.loads('''${resp.content}''')    json
    #log         ${json}
    Set Global Variable     ${created_org_id}        ${json['data']['id']}
    Log         ${created_org_id}

Get Member by Org and Type
    [Arguments]    ${Org_Admin_Id1}    ${MEMBER_TYPE}
    ${resp}=    GET On Session  host_server    /api/organization/${Org_Admin_Id1}/member/${MEMBER_TYPE}  headers=${GET_HEADERS}  expected_status=200
    Status Should Be                 200  ${resp}
    ${json}=    evaluate    json.loads('''${resp.content}''')    json
    [Return]         ${json['data'][0]['email']}

# Get a New Member from File
#     Log    ${new_member}       
#     ${mem_info}=    getUserFromFile
#     Log    ${mem_info}
#     Set To Dictionary   ${new_member}     firstName=${mem_info}[0]    lastName=${mem_info}[1]    phone=${mem_info}[2] 
#     ...    email=${mem_info}[3]    password=${mem_info}[4]    
#     Log    ${new_member}
#     [Return]    ${new_member}  

Register a New Member
    [Arguments]    ${new_member}
    Log    ${REGISTER_MEMBER_HEADER}
    ${resp}=    POST On Session    host_server        /api/auth/register    headers=${REGISTER_MEMBER_HEADER}    json=${new_member}    expected_status=anything
    Status Should Be                 200  ${resp} 
    ${json}=    evaluate    json.loads('''${resp.content}''')    json
    Should Be Equal       Success     ${json['message']}        
    #${new_member_token} =    Set Variable    ${json['data']} 


User Login
    [Arguments]    ${user_cred}
    ${resp}=    POST On Session    host_server  /api/auth/login     json=${user_cred}  expected_status=anything
    Status Should Be                 200  ${resp} 
    log         ${resp}
    log         ${resp.status_code}
    log         ${resp.headers}
    log         ${resp.content}
    ${json}=    evaluate    json.loads('''${resp.content}''')    json
    #log         ${json}
    Set Global Variable     ${auth_token}        ${json['token']}
    log         ${auth_token}
    [Return]    ${auth_token}

Invite a Member to Org
    [Arguments]    ${ids_to_Invite}    ${role_to_invite}    ${org_id}
    ${invite_body}=    Create Dictionary    emails=${ids_to_Invite}    roleId=${role_to_invite}
    ${resp}=    POST On Session    host_server  /api/organization/${org_id}/invite-member   headers=${POST_HEADER}   json=${invite_body}  expected_status=anything
    Status Should Be                 200  ${resp} 
    ${json}=    evaluate    json.loads('''${resp.content}''')    json
    Should Be Equal         ${json['message']}    Success
    
User Accepting Org Invite
    [Arguments]         ${org_id}
    ${accept_inv_body}    Create Dictionary    invitedFor=organization    inivitedForId=${org_id}
    ${resp}=    PUT On Session    host_server  /api/user/get-pending-invites/accept   
    ...    headers=${POST_HEADER}   json=${accept_inv_body}  expected_status=anything
    Status Should Be                 200  ${resp} 
    ${json}=    evaluate    json.loads('''${resp.content}''')    json
    Should Be Equal         ${json['message']}    Success


Get Members in Organization
    [Arguments]        ${org_id}        ${MEMBER_TYPE}
    #${MEMBER_TYPE}=    Set Variable    ${3}
    ${resp}=    GET On Session    host_server   /api/organization/${org_id}/member/${MEMBER_TYPE}    headers=${GET_HEADERS}     
    Status Should Be                 200  ${resp} 
    ${json}=    evaluate    json.loads('''${resp.content}''')    json
    [Return]        ${json['data']}

Invite Members to Group
    [Arguments]    ${org_id}    ${grp_id}    ${members_list}    ${role_id}
    ${invite_body}    Create Dictionary    userId=${members_list}    roleId=${role_id}
    ${resp}=    POST On Session    host_server  /api/organization/${org_id}/group/${grp_id}/invite-member   
    ...    headers=${POST_HEADER}   json=${invite_body}  expected_status=anything
    Status Should Be                 200  ${resp} 
    # ${json}=    evaluate    json.loads('''${resp.content}''')    json
    # [Return]        ${json['data']}

Accept Pending Invites for Group    
    [Arguments]    ${grp_id}
    ${accept_invite_body}=    Create Dictionary    inivitedForId=${grp_id}    invitedFor=group
    ${resp}=    POST On Session    host_server  /api/user/get-pending-invites/accept/
    ...    headers=${POST_HEADER}   json=${accept_invite_body}  expected_status=anything
    Status Should Be                 200  ${resp} 
    ${json}=    evaluate    json.loads('''${resp.content}''')    json
    Log         ${json['message']}

Create Group by Admin
    [Arguments]    ${org_id}    ${new_grp}
    ${resp}=    POST On Session    host_server   /api/organization/${org_id}/group/    
    ...    headers=${GET_HEADERS}     json=${new_grp}    
    Status Should Be                 200  ${resp} 
    ${json}=    evaluate    json.loads('''${resp.content}''')    json
    Should Be Equal       Success     ${json['message']}    
    Set Global Variable    ${grp_id}    ${json['data']['id']}
    [Return]    ${grp_id}

Create a Post by Association
    [Arguments]    ${post_body}
    ${resp}=    POST On Session    host_server  /api/post/  headers=${POST_HEADER}    json=${post_body}    expected_status=anything 
    Status Should Be                 200  ${resp} 
    Log    ${resp.content}
    ${json}=    evaluate    json.loads('''${resp.content}''')    json
    Should Be Equal    ${json['message']}    Success
    Set Global Variable         ${generated_post_id}    ${json['data']['id']} 
    [Return]   ${generated_post_id}

Add Post to Group
    [Arguments]    ${posts_needed_in_each_group}     ${created_group_id}
    #${created_group_id}=    Set Variable    2858f1f4-aaa1-4ac2-9513-8ebb169162e6
    FOR    ${post_count}    IN RANGE    1    ${posts_needed_in_each_group} 
        Log    ${post_count}
        ${grp_post_body}=    Create Dictionary    title= Test Robot Group Post no ${post_count}  
        ...    description= Test Robot Group Post Description Post no ${post_count}    associationType=group
        ...    associationId=${created_group_id}
        Log    ${grp_post_body} 
        ${post_id} =    Create a Post by Association    ${grp_post_body}
    END
    