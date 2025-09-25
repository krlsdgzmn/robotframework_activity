*** Settings ***
Library     SeleniumLibrary


*** Keywords ***
Launch Browser
    [Arguments]    ${url}
    ${options}     Evaluate             sys.modules['selenium.webdriver'].ChromeOptions()   sys
    Call Method    ${options}           add_argument                --start-maximized
    Call Method    ${options}           add_argument                --incognito
    Open Browser   ${url}               chrome                      options=${options}


Navigate Action
    [Arguments]     ${action}
    Wait Until Element Is Visible       ${action}
    Click Element   ${action}


Clear And Input Text
    [Arguments]     ${locator}          ${text}
    Wait Until Element Is Visible       ${locator}
    Press Keys      ${locator}          CTRL+a      BACKSPACE
    Input Text      ${locator}          ${text}
