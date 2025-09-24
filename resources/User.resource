*** Settings ***
Library     ../library/UsersLibrary.py
Resource    ../resources/App.resource
Variables   ../variables/users_variable.py


*** Keywords ***
Login Action
    [Arguments]     ${username}             ${password}
    Wait Until Element Is Visible           ${x_username_input}
    Input Text      ${x_username_input}     ${username}
    Input Password  ${x_password_input}     ${password}
    Click Button    ${x_login_button}


Create User
    [Arguments]     ${user}
    Navigate Link   ${x_create_customer_link}

    Input Text      ${x_first_name_input}   ${user["first_name"]}
    Input Text      ${x_last_name_input}    ${user["last_name"]}
    Input Text      ${x_email_input}        ${user["email"]}
    Click Element   ${x_save_button}

    Wait Until Element Is Visible           ${x_delete_button}
