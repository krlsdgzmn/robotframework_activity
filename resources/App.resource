*** Settings ***
Library     SeleniumLibrary


*** Keywords ***
Launch Browser
    [Arguments]    ${url}
    ${options}     Evaluate             sys.modules['selenium.webdriver'].ChromeOptions()   sys
    ${prefs}       Create Dictionary    credentials_enable_service=${False}                 profile.password_manager_enabled=${False}
    Call Method    ${options}           add_experimental_option     prefs                   ${prefs}
    Call Method    ${options}           add_argument                --start-maximized
    Open Browser   ${url}               chrome                      options=${options}
