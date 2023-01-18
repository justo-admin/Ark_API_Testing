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
${ARK_STAGE_SERVER}         https://app-stage.thearkofrevival.com/
${SuperAdmin_uid}            admin@justomerchantz.com  
${SuperAdmin_pwd}            P@ssword0123       
${OrgStagAdmin_uid}          stag@getnada.com
${OrgStagAdmin_pwd}          stag@0
${OrgStage_Title}            Ark Stag Test
${StageGroup_Title}          Sample
${StageOrgPost1_Desc}        Test Post
${StageGroupPost1_Desc}      Test Post
${member_1_email}            onestag@getnada.com   
${member_2_email}            threestag@getnada.com
${member_3_email}            vv507209@gmail.com
${post_count}                1
${BROWSER}        Chrome
${DELAY}          0  
&{REGISTER_MEMBER_HEADER}        Content-Type=application/json
&{grp_post_body}         title=Test Post from Robot using JSON No3  
...    description=Test Post from Robot via JSON No3 Desc     isPrivate=true     associationType=group

&{grp_edit_post_body}    title=Edited1 Test Post from Robot using JSON No3  description=Edited1 Test Post from Robot via JSON No3 description     isPrivate=true    isActive=active

&{new_member}    firstName=TestUser    middleName=mid    lastName=One    
...    email=testuser1@getnada.com    password=testuser@1    phone=9911223301    dateOfBirth=01-01-1990
...    gender=male    countryCode=91    registeredFrom=direct    street=Test Street    city=New York    
...    state=Montana    country=United States    zipcode=123123