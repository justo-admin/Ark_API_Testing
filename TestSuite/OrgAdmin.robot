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
${t_org_id}      24b2e9af-5220-4c6a-947c-a4ca13b744de
&{api_org_admin}         username=adminuser012@getnada.com  password=adminuser@12
${file1}        DSC_0876.jpg
${mod_list}         []
${info}          {}
${file_loc}       C:\\Users\\hp\\Pictures\\Flowers\\DSC_8125.jpg
#${file_loc}        ${CURDIR}/DSC_0876.jpg
${Grp_count}        4
@{member_email_list}
@{member_password_list}

*** Test Cases ***

AdminUser Login Test 
    ${admin_token}=    User Login     ${api_org_admin}
    Create Auth Header With Token        ${admin_token}


Registering Members for the Organization
    FOR    ${mem_count}    IN RANGE    30    ${members_needed} 
        &{new_member}=    Create Dictionary    firstName=TestO${COUNTER}M${mem_count}    middleName=mid    lastName=UserO${COUNTER}M${mem_count}
        ...    email=org0${COUNTER}user${mem_count}@getnada.com    password=testuser@${mem_count}    phone=9911223${COUNTER}${mem_count}    dateOfBirth=01-01-1990
        ...    gender=male    countryCode=91    registeredFrom=direct    street=Test Street    city=New York    
        ...    state=Montana    country=United States    zipcode=123123
        Register a New Member    ${new_member}
        Set Global Variable    ${member_email}    ${new_member['email']}
        Set Global Variable    ${member_password}    ${new_member['password']}
        Append To List    ${member_email_list}    ${member_email}
        Append To List    ${member_password_list}    ${member_password}
    END

Invite Members to the Org
        Invite a User to Org    ${member_email_list}    ${role_member}    ${t_org_id}
        Log    ${member_email_list}

 
# Add a Post by Organization
#     #Log    ${created_group_id}
#     ${org_id}=    Set variable    ${t_org_id}
#     Log    ${posts_needed_in_org}  
#     FOR    ${post_count}    IN RANGE    0    ${posts_needed_in_org}    
#         ${org_post_body}=    Create Dictionary    title= Test Robot Post no 00 ${post_count}     isPrivate=true
#         ...    description= Test Robot Org Post Description Post no 00 ${post_count}    associationType=organization
#         ...    associationId=${org_id}
#         Log    ${org_post_body} 
#         ${post_id} =    Create a Post by Association    ${org_post_body}
#     END

# Get All Members in Organization
#     ${Member_list1}=    Get Members in Organization    ${t_org_id}     1
#     ${Member_list2}=    Get Members in Organization    ${t_org_id}     2
#     ${Member_list3}=    Get Members in Organization    ${t_org_id}     3
#     ${all_members}=    Combine Lists    ${Member_list1}    ${Member_list2}    ${Member_list3}
#     Log    ${all_members}
#     ${all_member_Id}=        Create List
#     FOR    ${member}    IN    @{all_members}
#         Log    ${member['userId']}
#         Append To List    ${all_member_Id}    ${member['userId']}
#     END
#     Set Global Variable    ${all_member_Id}    ${all_member_Id}

# AdminUser Creating a Groups
#     Log    ${groups_needed}
#     ${grp_id_list}    Create List
#     FOR    ${group_count}    IN RANGE    0    ${groups_needed}    
#         Log    ${group_count}
#         ${new_grp}=    Create Dictionary     title= RobotGroup_Org${COUNTER}_Grp${group_count}    description=RobotGroup Group${group_count} Created for Org_${COUNTER} 
#         ...    info=${info}   moderator=${mod_list}  
#         ${grp_id}=    Create Group by Admin    ${t_org_id}    ${new_grp}
#         Set Global variable    ${created_group_id}        ${grp_id}
#         Append To List    ${grp_id_list}    ${created_group_id}
#         #Add Post to Group    ${posts_needed_in_each_group}    ${created_group_id}    
#         Invite Members to Group    ${t_org_id}    ${grp_id}    ${all_member_Id}      ${role_member}
#     END

# Invite Member to a Group As Admin
#     Invite Members to Group    ${t_org_id}    ${grp_id}    ${all_member_Id}      ${role_admin}

# Accept Pending Invites for Group
#     Accept Pending Invites for Group    ${grp_id}


MemberUser Login and Accept Org Invite
    Log    ${member_email_list}
    Log    ${member_password_list}
    FOR    ${i}    IN RANGE    0    10
        ${member_cred}=    Create Dictionary    username=${member_email_list}[${i}]    password=${member_password_list}[${i}]
        ${member_token}=    User Login     ${member_cred}
        Create Auth Header With Token        ${member_token}
        User Accepting Org Invite        ${t_org_id}
    END
    
