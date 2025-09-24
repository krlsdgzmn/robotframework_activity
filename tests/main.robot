*** Settings ***
Resource     ../resources/User.resource


*** Test Cases ***
TEST-000001
    [Documentation]     Verify the details of the first 5 added users
    Launch Browser      url=${URL}
    Login Action        username=${USERNAME}    password=${PASSWORD}

    ${users}            Get Random Users
    FOR     ${user}     IN      @{users}[:5]
        Navigate Link   ${x_customers_link}
        Create User     ${user}
    END

    Sleep               3s
