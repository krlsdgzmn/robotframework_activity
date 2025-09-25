*** Settings ***
Resource     ../resources/User.resource


*** Test Cases ***
TEST-000001
    [Documentation]     Add and verify the details of the first 5 added users
    [Setup]             Setup Users

    Launch Browser                 url=${URL}
    Login Action                   username=${USERNAME}    password=${PASSWORD}
    Create And Verify Five Users   @{users}
