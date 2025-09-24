*** Settings ***
Library     SeleniumLibrary
Variables   ../variables/users_variable.py


*** Variables ***


*** Test Cases ***
TEST-000001
    [Documentation]     Verify first 5 users added details
    Launch Browser      url=${URL}
    Login Action        username=${USERNAME}    password=${PASSWORD}
    Sleep               3s



*** Keywords ***
Launch Browser
    [Arguments]     ${url}
    Open Browser    url=${url}    browser=chrome    options=add_argument("--start-maximized")


Login Action
    [Arguments]     ${username}             ${password}
    Wait Until Element Is Visible           ${x_username_input}
    Input Text      ${x_username_input}     ${username}
    Input Password  ${x_password_input}     ${password}
    Click Button    ${x_login_button}

