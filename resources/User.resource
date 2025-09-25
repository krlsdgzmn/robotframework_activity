*** Settings ***
Library     ../library/UsersLibrary.py
Resource    ../resources/App.resource
Variables   ../variables/users_variable.py


*** Keywords ***
Setup Users
    @{users}=                               Get Random Users
    Set Suite Variable                      @{users}   


Login Action
    [Arguments]     ${username}             ${password}
    Wait Until Element Is Visible           ${x_username_input}
    Input Text      ${x_username_input}     ${username}
    Input Password  ${x_password_input}     ${password}
    Click Button    ${x_login_button}


Create User
    [Arguments]                                      ${user}
    Navigate Action                                  ${x_create_customer_link}

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

    Navigate Action                                  ${x_save_button}
    Wait Until Element Is Visible                    ${x_delete_button}


Create And Verify Five Users
    [Arguments]     @{users}
    FOR     ${user}     IN           @{users}[:5]
        Navigate Action              ${x_customers_link}
        Create User                  ${user}
        Verify User Details          ${user}
    END


Verify User Details
    [Arguments]         ${user}
    Navigate Action     ${x_customers_link}
    Navigate Action     ${x_refresh_button}

    # Verify the table row user's name
    ${row_text}=                    Get Text        ${x_row}
    ${name}=                        Evaluate        """${row_text}""".split("\\n")[-1]

    Should Be Equal As Strings      ${name}         ${user["name"]}

    # Verify all details
    Navigate Action     ${x_row}

    Wait Until Element Is Visible                      ${x_first_name_input}
    ${first_name}=          Get Element Attribute      ${x_first_name_input}            value
    ${last_name}=           Get Element Attribute      ${x_last_name_input}             value
    ${email}=               Get Element Attribute      ${x_email_input}                 value
    ${birthday}=            Get Element Attribute      ${x_birthday_input}              value
    ${address}=             Get Element Attribute      ${x_address_input}               value
    ${city}=                Get Element Attribute      ${x_city_input}                  value
    ${state}=               Get Element Attribute      ${x_stateAbbr_input}             value
    ${zipcode}=             Get Element Attribute      ${x_zipcode_input}               value
    ${password}=            Get Element Attribute      ${x_password_input}              value
    ${confirm_password}=    Get Element Attribute      ${x_confirm_password_input}      value

    Should Be Equal As Strings    ${first_name}        ${user["first_name"]}
    Should Be Equal As Strings    ${last_name}         ${user["last_name"]}
    Should Be Equal As Strings    ${email}             ${user["email"]}
    Should Be Equal As Strings    ${birthday}          ${user["iso_birthday"]}
    Should Be Equal As Strings    ${address}           ${user["address"]["street"]} ${user["address"]["suite"]}
    Should Be Equal As Strings    ${city}              ${user["address"]["city"]}
    Should Be Equal As Strings    ${state}             ${user["address"]["state"]}
    Should Be Equal As Strings    ${zip_code}          ${user["address"]["zipcode"]}
    Should Be Equal As Strings    ${password}          ${user["password"]}
    Should Be Equal As Strings    ${confirm_password}  ${user["password"]}


Update Rows 6-10
    [Arguments]         @{users}
    FOR    ${i}    IN RANGE     5
        Navigate Action     ${x_customers_link}
        Navigate Action     ${x_refresh_button}

        ${index}=               Evaluate        ${i} + 6
        ${user}=                Set Variable    ${users}[${i}]
        ${current_xpath}=       Set Variable    ${x_i_row}\[${index}\]
        Navigate Action         ${current_xpath}

        Clear And Input Text   ${x_first_name_input}         ${user["first_name"]}
        Clear And Input Text   ${x_last_name_input}          ${user["last_name"]}
        Clear And Input Text   ${x_email_input}              ${user["email"]}
        Input Text             ${x_birthday_input}           ${user["birthday"]}
        Clear And Input Text   ${x_address_input}            ${user["address"]["street"]} ${user["address"]["suite"]}
        Clear And Input Text   ${x_city_input}               ${user["address"]["city"]}
        Clear And Input Text   ${x_stateAbbr_input}          ${user["address"]["state"]}
        Clear And Input Text   ${x_zipcode_input}            ${user["address"]["zipcode"]}
        Clear And Input Text   ${x_password_input}           ${user["password"]}
        Clear And Input Text   ${x_confirm_password_input}   ${user["password"]}

        Navigate Action         ${x_save_button}
    END
