*** Settings ***
Documentation  Contact Form
Library  SeleniumLibrary
Library  Process

*** Variables ***
${BROWSER}   chrome

*** Test Cases ***
Verify contact form render
    [Documentation]  This test case verifies
    [Tags]  Functional

    ${chrome_options}=  Create Chrome Options
    Open Browser  https://fracturasyfracturas.com.co/   ${BROWSER}  options=${chrome_options}
    Wait Until Element Is Visible    xpath=//*[@id="agenda"]/div/div[1]/div    30s
    [Teardown]  Close Browser

*** Keywords ***
Create Chrome Options
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    RETURN    ${options}
