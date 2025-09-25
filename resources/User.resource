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

    Wait Until Element Is Visible                    ${x_first_name_input}
    Input Text      ${x_first_name_input}            ${user["first_name"]}
    Input Text      ${x_last_name_input}             ${user["last_name"]}
    Input Text      ${x_email_input}                 ${user["email"]}
    Input Text      ${x_birthday_input}              ${user["birthday"]}
    Input Text      ${x_address_input}               ${user["address"]["street"]} ${user["address"]["suite"]}
    Input Text      ${x_city_input}                  ${user["address"]["city"]}
    Input Text      ${x_stateAbbr_input}             ${user["address"]["state"]}
    Input Text      ${x_zipcode_input}               ${user["address"]["zipcode"]}
    Input Text      ${x_password_input}              ${user["password"]}
    Input Text      ${x_confirm_password_input}      ${user["password"]}

    Click Element   ${x_save_button}
    Wait Until Element Is Visible                    ${x_delete_button}


Create Five Users
    [Arguments]     @{users}
    FOR     ${user}     IN           @{users}[:5]
        Navigate Link                ${x_customers_link}
        Create User                  ${user}
        Verify User From Dashboard   ${user}
    END


Verify User From Dashboard
    [Arguments]         ${user}
    Navigate Link       ${x_customers_link}

    Wait Until Element Is Visible               ${x_refresh_button}
    Click Button                                ${x_refresh_button}

    Wait Until Element Is Visible               ${x_row}
    ${retrieved_text}             Get Text      ${x_row}
    ${name}                       Evaluate      """${retrieved_text}""".split("\\n")[-1]
    Should Be Equal As Strings    ${name}       ${user["name"]}
