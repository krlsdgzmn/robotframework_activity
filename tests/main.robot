*** Settings ***
Resource     ../resources/User.resource


*** Test Cases ***
# Task 1 and Task 2
TEST-000001
    [Documentation]     Add and verify the details of the first 5 added users
    [Setup]             Setup Users

    Launch Browser                 url=${URL}
    Login Action                   username=${USERNAME}    password=${PASSWORD}
    Create And Verify Users        @{users[:5]}


# Task 3
TEST-000002
    [Documentation]     Update the user details from row 6-10

    Update Rows 6-10    @{users[5:]}


# Task 4
TEST-000003
    [Documentation]     Print all the data in the table 

    Log Table Data
