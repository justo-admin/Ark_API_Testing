*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library            SeleniumLibrary
Library            RequestsLibrary
Library            Collections

*** Variables ***
${ARK_STAGE_SERVER}          https://app-stage.thearkofrevival.com/
&{SupportAdmin_cred}           username=admin@justomerchantz.com  password=P@ssword0123
${counter_file_path}        Source\\DO_NOT_UPDATE.json
&{REGISTER_MEMBER_HEADER}        Content-Type=application/json
${role_admin}              ${1}
${role_moderator}          ${2}
${role_member}             ${3}
#${post_count}                1
${groups_needed}              1
${posts_needed_in_each_group}   3
${posts_needed_in_org}           3
${members_needed}                2

#&{OrgStagAdmin_cred}         username=stag@getnada.com  password=stag@0
# ${OrgStage_Title}            Ark Stag Test
# ${StageGroup_Title}          Sample
${StageOrgPost1_Desc}        Test Post
${StageGroupPost1_Desc}      Test Post
${member_1_email}            onestag@getnada.com   
${member_2_email}            threestag@getnada.com
${member_3_email}            vv507209@gmail.com


# &{grp_edit_post_body}    title=Edited1 Test Post from Robot using JSON No3  description=Edited1 Test Post from Robot via JSON No3 description     isPrivate=true    isActive=active

# &{new_member}    firstName=Test    middleName=mid    lastName=User
# ...    email=testuser1@getnada.com    password=testuser@1    phone=9911223301    dateOfBirth=01-01-1990
# ...    gender=male    countryCode=91    registeredFrom=direct    street=Test Street    city=New York    
# ...    state=Montana    country=United States    zipcode=123123

# &{new_org}    title=TestRobotOrg1    description=TestRobotOrg1    address=Address Robot Json1
# ...    email=testorgr1@getnada.com    website=www.testorgr1.com    phone=9900001111    
# ...    about=Address For First Org created for testing APIs through Robot Json

#&{new_grp}    title= TestGroupviaAPI6    description=TestGroupviaAPIDesc6