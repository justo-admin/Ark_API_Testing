*** Settings ***
Documentation  API Testing in Robot Framework
Library  SeleniumLibrary
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Keywords ***
Do a POST Request and validate the response code, response body, and response headers
    [documentation]  This test case verifies that the response code of the POST Request should be 201,
    ...  the response body contains the 'id' key with value '101',
    ...  and the response header 'Content-Type' has the value 'application/json; charset=utf-8'.
    [tags]  Regression
    Create Session  mysession  https://jsonplaceholder.typicode.com  verify=true
    &{body}=  Create Dictionary  title=foo  body=bar  userId=9000
    &{header}=  Create Dictionary  Cache-Control=no-cache
    ${response}=  POST On Session  mysession  /posts  data=${body}  headers=${header}
    Status Should Be  201  ${response}  #Check Status as 201

    #Check id as 101 from Response Body
    ${id}=  Get Value From Json  ${response.json()}  id
    ${idFromList}=  Get From List   ${id}  0
    ${idFromListAsString}=  Convert To String  ${idFromList}
    Should be equal As Strings  ${idFromListAsString}  101

    #Check the value of the header Content-Type
    ${getHeaderValue}=  Get From Dictionary  ${response.headers}  Content-Type
    Should be equal  ${getHeaderValue}  application/json; charset=utf-8