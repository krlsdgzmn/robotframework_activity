*** Settings ***
Library     SeleniumLibrary


*** Keywords ***
Launch Browser
    [Arguments]     ${url}
    Open Browser    url=${url}    browser=chrome    options=add_argument("--start-maximized")


