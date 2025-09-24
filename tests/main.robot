*** Settings ***
Resource     ../resources/User.resource


*** Test Cases ***
TEST-000001
    [Documentation]     Verify first 5 users added details
    Launch Browser      url=${URL}
    Login Action        username=${USERNAME}    password=${PASSWORD}
    Sleep               3s
