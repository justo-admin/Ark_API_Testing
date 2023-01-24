*** Settings ***
Library               RequestsLibrary
Library               Collections
Library               OperatingSystem 
Library               JSONLibrary
Resource              ../Resources/Variables.robot
Resource              ../Resources/APIKeywords.robot
Library               ../Utils/csv_pandas.py
Suite Setup           Get Server Test and Counter
Suite Teardown         Update Counter in File

*** Test Cases ***

SupportAdmin Login Test 
    ${support_admin_token}=    User Login     ${SupportAdmin_cred}
    log         ${support_admin_token} 
    Create Auth Header With Token        ${support_admin_token}

Create an Organization Test
    #Log    ${new_org} 
    ${new_org}=    Create Dictionary     title=TestRobotOrg${COUNTER}    description=TestRobotOrg${COUNTER}    address=Address Robot Json${COUNTER}
    ...    email=testorgr${COUNTER}@getnada.com    website=www.testorgr${COUNTER}.com    phone=990000111${COUNTER}    
    ...    about=Address For Org ${COUNTER} created for testing APIs through Robot 
    Create an Organization     ${new_org} 

# Get and Register new Member from File
#     ${new_member}=   Get a New Member from File
#     Set Global Variable    ${member_email}    ${new_member['email']}
#     Set Global Variable    ${member_password}    ${new_member['password']}
#     Register a New Member    ${new_member}

Create and Register new User
    &{new_member}=    Create Dictionary    firstName=Admin${COUNTER}    middleName=mid    lastName=User${COUNTER}
    ...    email=adminuser0${COUNTER}@getnada.com    password=adminuser@${COUNTER}    phone=991122330${COUNTER}    dateOfBirth=01-01-1990
    ...    gender=male    countryCode=91    registeredFrom=direct    street=Test Street    city=New York    
    ...    state=Montana    country=United States    zipcode=123123
    Set Global Variable    ${member_email}    ${new_member['email']}
    Set Global Variable    ${member_password}    ${new_member['password']}
    Register a New Member    ${new_member}
    Log To Console    ${member_email}    ${member_password}

Invite a User as Admin to Org
    #${member_email}    ${member_password}    Register a New Member
    # ${created_org_id}=    Set Variable   ff326926-6ae0-4973-b95e-d227a48054fd        
    # ${member_email}=      Set Variable    TestUser10@getnada.com
    ${ids_to_Invite}=    Create List    ${member_email}
    Invite a User to Org    ${ids_to_Invite}    ${role_admin}    ${created_org_id}

AdminUser Login Test 
    ${user_creds}    Create Dictionary    username=${member_email}    password=${member_password}
    ${admin_token}=    User Login     ${user_creds}
    Create Auth Header With Token        ${admin_token}

AdminUser Accepting Org Invite
    User Accepting Org Invite        ${created_org_id}



