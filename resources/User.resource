*** Settings ***
Resource     ../resources/App.resource
Variables   ../variables/users_variable.py


*** Keywords ***
Login Action
    [Arguments]     ${username}             ${password}
    Wait Until Element Is Visible           ${x_username_input}
    Input Text      ${x_username_input}     ${username}
    Input Password  ${x_password_input}     ${password}
    Click Button    ${x_login_button}

