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


Create Five Users
    @{users}            Get Random Users
    FOR     ${user}     IN      @{users}[:5]
        Navigate Link   ${x_customers_link}
        Create User     ${user}
        Verify User     ${user}
    END


Verify User
    [Arguments]         ${user}
    Navigate Link       ${x_customers_link}

    Wait Until Element Is Visible           ${x_refresh_button}   
    Click Button        ${x_refresh_button}

    Wait Until Element Is Visible           ${x_row}   
    ${retrieved_text}   Get Text            ${x_row}
    ${last_name}        Evaluate            "${retrieved_text}".replace("\\n", "").split(" ")[1]
    Log To Console      Original:${user["last_name"]}
    Log To Console      Retrieved:${last_name}
