*** Settings ***
Library               RequestsLibrary
Library               Collections
Library               OperatingSystem 
Library               JSONLibrary
Resource              ../Resources/Variables.robot
Resource              ../Resources/APIKeywords.robot
Library               ../Utils/csv_pandas.py
Suite Setup           Get Server Test and Counter

*** Variables ***
${t_org_id}      8f613fd9-3cb2-49d6-9ab8-cb390471b36b
&{api_org_admin}         username=testuser08@getnada.com  password=testuser@8
${file1}        DSC_0876.jpg
${mod_list}         []
${info}          {}
${file_loc}       C:\\Users\\hp\\Pictures\\Flowers\\DSC_8125.jpg
#${file_loc}        ${CURDIR}/DSC_0876.jpg
${Grp_count}        4
@{grp_id_list}      []

*** Test Cases ***

AdminUser Login Test 
    ${admin_token}=    User Login     ${api_org_admin}
    Create Auth Header With Token        ${admin_token}


Add a Post by Organization
    #Log    ${created_group_id}
    ${org_id}=    Set variable    ${t_org_id}
    Log    ${posts_needed_in_org}  
    FOR    ${post_count}    IN RANGE    1    ${posts_needed_in_org}    
        ${org_post_body}=    Create Dictionary    title= Test Robot Post no 00 ${post_count}     isPrivate=true
        ...    description= Test Robot Org Post Description Post no 00 ${post_count}    associationType=organization
        ...    associationId=${org_id}
        Log    ${org_post_body} 
        ${post_id} =    Create a Post by Association    ${org_post_body}
    END
    Log    ${post_id}


AdminUser Creating a Groups
    Log    ${groups_needed}
    FOR    ${group_count}    IN RANGE    1    ${groups_needed}    
        Log    ${group_count}
        ${new_grp}=    Create Dictionary     title= RobotGroup_Org${COUNTER}_Grp${group_count}    description=RobotGroup Group${group_count} Created for Org_${COUNTER} 
        ...    info=${info}   moderator=${mod_list}  
        ${grp_id}=    Create Group by Admin    ${t_org_id}    ${new_grp}
        Set Global variable    ${created_group_id}        ${grp_id}
        Append To List    ${grp_id_list}    ${created_group_id}
        Add Post to Group    ${posts_needed_in_each_group}    ${created_group_id}    
    END

Get All Members in Organization
    ${Member_list1}=    Get Members in Organization    ${t_org_id}     1
    ${Member_list2}=    Get Members in Organization    ${t_org_id}     2
    ${Member_list3}=    Get Members in Organization    ${t_org_id}     3
    ${all_members}=    Combine Lists    ${Member_list1}    ${Member_list2}    ${Member_list3}
    Log    ${all_members}
    ${all_member_Id}=        Create List
    FOR    ${member}    IN    @{all_members}
        Log    ${member['userId']}
        Append To List    ${all_member_Id}    ${member['userId']}
    END
    Set Global Variable    ${all_member_Id}    ${all_member_Id}
    
Invite Member to a Group
    Invite Members to Group    ${t_org_id}    ${grp_id}    ${all_member_Id}      ${role_admin}

Accept Pending Invites for Group
    Accept Pending Invites for Group    ${grp_id}


