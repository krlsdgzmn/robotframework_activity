*** Settings ***
Resource     ../resources/User.resource


*** Test Cases ***
TEST-000001
    [Documentation]     Verify the details of the first 5 added users

    Launch Browser      url=${URL}
    Login Action        username=${USERNAME}    password=${PASSWORD}

    @{users}                                    Get Random Users
    Create And Verify Five Users                @{users}
    Sleep                                       3s
