*** Settings ***
Library               RequestsLibrary
Library               Collections
Library               OperatingSystem 
Library               JSONLibrary
Resource              ../Resources/Variables.robot
Resource              ../Resources/APIKeywords.robot
Library               ../Utils/csv_pandas.py

*** Test Cases ***

# Get Server Test
#     ${response}=    GET  ${ARK_STAGE_SERVER}
#     Create Session    host_server  ${ARK_STAGE_SERVER}     verify=true

# StagAdmin Login Test 
#     ${resp}=    POST On Session    host_server  /api/auth/login  data=${OrgStagAdmin_cred}  expected_status=anything
#     Status Should Be                 200  ${resp} 
#     log         ${resp}
#     log         ${resp.status_code}
#     log         ${resp.headers}
#     log         ${resp.content}
#     ${json}=    evaluate    json.loads('''${resp.content}''')    json
#     #log         ${json}
#     Set Global Variable     ${token}        ${json['token']}
#     log         ${token}
#     Create Auth Header With Token        ${token}
    
# Get My Organization Test
#     #${token}    Set Variable             ycnhhzdxon
#     ${resp}=    GET On Session  host_server    /api/my-organization      headers=${GET_HEADERS}  expected_status=200
#     Status Should Be                 200  ${resp} 
#     ${json}=    evaluate    json.loads('''${resp.content}''')    json
#     log         ${json['data']}
#     Set Global Variable     ${Org_Admin_Id1}    ${json['data']['Admin'][0]['id']}
#     Log     ${Org_Admin_Id1}
#     ${Org_Title_Actual}    Set Variable        ${json['data']['Admin'][0]['title']}
#     Should Be Equal    ${OrgStage_Title}    ${Org_Title_Actual}      

    
# Get My Groups Test
#     #${token}=    Set Variable             ycnhhzdxon
#     ${resp}=    GET On Session  host_server    /api/my-group  headers=${GET_HEADERS}  expected_status=200
#     Status Should Be    200      ${resp} 
#     ${json}=    evaluate    json.loads('''${resp.content}''')    json
#     log         ${json['data']}
#     Set Global Variable     ${Org_Group_Id1}    ${json['data']['myGroup']['Moderator'][0]['id']}
#     Log    ${Org_Group_Id1}
#     Log     ${json['data']['myGroup']['Moderator'][0]['title']}
#     ${Group_Title_Actual}    Set Variable        ${json['data']['myGroup']['Moderator'][0]['title']}
#     Should Contain    ${Group_Title_Actual}        ${StageGroup_Title}


# Get My Organization Posts Test
#     #${token}=    Set Variable             ycnhhzdxon
#     ${resp}=    GET On Session  host_server    /api/post/organization/${Org_Admin_Id1}  headers=${GET_HEADERS}  expected_status=200
#     Status Should Be                 200  ${resp} 
#     ${json}=    evaluate    json.loads('''${resp.content}''')    json
#     log         ${json['data']}
#     ${Org_Post_Desc1}    Set Variable        ${json['data'][0]['description']}
#     Should Contain        ${Org_Post_Desc1}        ${StageOrgPost1_Desc}   

# Get My Posts Test
#     #${token}=    Set Variable             ycnhhzdxon
#     ${resp}=    GET On Session  host_server    /api/post/my-post  headers=${GET_HEADERS}  expected_status=200
#     Status Should Be                 200  ${resp} 
#     ${json}=    evaluate    json.loads('''${resp.content}''')    json
#     log         ${json['data']}
#     Should Contain        ${json['data'][0]['association_type']}        organization_post
#     Should Contain        ${json['data'][1]['association_type']}        group_post
#     ${Org_Post_Desc1}    Set Variable        ${json['data'][0]['description']}
#     Should Contain        ${Org_Post_Desc1}    ${StageOrgPost1_Desc}  
#     ${Group_Post_Desc1}    Set Variable        ${json['data'][1]['description']}
#     Should Contain        ${Group_Post_Desc1}    ${StageGroupPost1_Desc}        

# Get My Group Posts Test
#     #${token}=    Set Variable             ycnhhzdxon
#     ${resp}=    GET On Session  host_server    /api/post/organization/${Org_Admin_Id1}  headers=${GET_HEADERS}  expected_status=200
#     Status Should Be                 200  ${resp} 
#     ${json}=    evaluate    json.loads('''${resp.content}''')    json
#     log         ${json['data']}
#     Should Contain     ${json['message']}      Success
#     ${Org_Post_Title1}    Set Variable        ${json['data'][0]['title']}
#     Should Contain        ${StageOrgPost1_Desc}        ${Org_Post_Title1}


# my-todo Test
#     ${token}    Set Variable         evhmdkyufh
#     ${params}=    Create Dictionary    status=incomplete
#     ${resp}=    GET On Session  host_server    /api/todo/my-todo/    params=${params}     headers=${GET_HEADERS}  expected_status=200
#     Status Should Be                 200  ${resp} 
#     ${json}=    evaluate    json.loads('''${resp.content}''')    json
#     log         ${json['data']}
#     Set Global Variable     ${my-todo_Id1}    ${json['data'][1]['id']} 
#     Log     ${my-todo_Id1}
#     ${my-todo-title_Actual}    Set Variable        ${json['data'][1]['title']}
#     #Should Be Equal    ${my-todo-title}     ${my-todo-title_Actual}


# Get Members by Org Based on Type Admin
#     #${token}=    Set Variable             ycnhhzdxon
#     ${member_list}=    Get Member by Org and Type    ${Org_Admin_Id1}    1
#     Log    ${member_list}
#     Should Contain    ${member_list}    ${member_1_email}

# Get Members by Org Based on Type Moderator
#     #${token}=    Set Variable             ycnhhzdxon
#     ${member_list}=    Get Member by Org and Type    ${Org_Admin_Id1}    2
#     Should Contain    ${member_list}    ${member_2_email}

# Get Members by Org Based on Type Member
#     #${token}=    Set Variable             ycnhhzdxon
#     ${member_list}=    Get Member by Org and Type    ${Org_Admin_Id1}    3
#     Should Contain    ${member_list}    ${member_3_email}

# Add a Post by Group
#     # ${token}=    Set Variable             tsubveoklt
#     # Create Auth Header With Token        ${token}
#     ${Org_Group_Id1}=    Set Variable     d39c7dc9-df32-4cf1-be9e-d59a88013283
#     Log    ${grp_post_body}
#     Set To Dictionary    ${grp_post_body}    associationId=${Org_Group_Id1}
#     ${resp}=    POST On Session    host_server  /api/post/  headers=${POST_HEADER}    json=${grp_post_body}    expected_status=anything                                                         
#     Status Should Be                 200  ${resp} 
#     Log    ${resp.content}
#     ${json}=    evaluate    json.loads('''${resp.content}''')    json
#     Should Be Equal    ${json['message']}    Success
#     Set Global Variable         ${generated_post_id1}    ${json['data']['id']} 
#     Log   ${generated_post_id1}
    
# Get Post by Id Check
#     #${token}=    Set Variable             ycnhhzdxon
#     #${generated_post_id1}=    Set Variable    8ad1e3fa-cc1c-41ef-ba4a-8e227153747a
#     ${resp}=    GET On Session  host_server    /api/post/${generated_post_id1}  headers=${GET_HEADERS}  expected_status=200
#     Status Should Be                 200  ${resp} 
#     ${json}=    evaluate    json.loads('''${resp.content}''')    json
#     log         ${json['data']}
#     ${Org_Post_Desc1}    Set Variable        ${json['data']['description']}
#     Should Contain        ${Org_Post_Desc1}    Test Post from Robot via JSON    

# Edit a Post by Group
#     # ${token}=    Set Variable             tsubveoklt
#     # Create Auth Header With Token        ${token}
#     ${Org_Group_Id1}=    Set Variable     d39c7dc9-df32-4cf1-be9e-d59a88013283
#     #${post_id}=    Set Variable     ${generated_post_id1}
#     Log    ${grp_edit_post_body}  
#     ${resp}=    POST On Session    host_server  /api/post/${generated_post_id1}    headers=${POST_HEADER}    json=${grp_edit_post_body} 
#     Status Should Be                 200  ${resp} 
#     Log    ${resp.content}
#     ${json}=    evaluate    json.loads('''${resp.content}''')    json
#     Should Be Equal    ${json['message']}    Success
#     Set Global Variable         ${generated_post_id1}    ${json['data']['id']} 
#     Log   ${generated_post_id1}


 
Register a New Member Test
    Log    ${new_member}       
    ${mem_info}=    getUserFromFile
    Log    ${mem_info}
    Set To Dictionary   ${new_member}     firstName=${mem_info}[0]    lastName=${mem_info}[1]    phone=${mem_info}[2] 
    ...    email=${mem_info}[3]    password=${mem_info}[4]    
    Log    ${new_member}
    Log    ${REGISTER_MEMBER_HEADER}
    ${resp}=    POST On Session    host_server        /api/auth/register    headers=${REGISTER_MEMBER_HEADER}    json=${new_member}    expected_status=anything
    Status Should Be                 200  ${resp} 
    ${json}=    evaluate    json.loads('''${resp.content}''')    json
    Should Be Equal    ${json['message']}    Success    
    ${new_member_data} =    Set Variable    ${json['data']} 

Create an Organization
    