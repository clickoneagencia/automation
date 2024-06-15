*** Settings ***
Documentation  Contact Form
Library  SeleniumLibrary
Library  Process

*** Variables ***
${BROWSER}   chrome

*** Test Cases ***
Verify contact form for ClickOne
    [Documentation]  This test case verifies the contact form
    [Tags]  Functional

    ${chrome_options}=  Create Chrome Options
    Open Browser  https://agenciaclickone.com/   ${BROWSER}  options=${chrome_options}
    Input Text  //*[@id="form-field-name"]  John Doe
    Input Text  //*[@id="form-field-email"]  email@agenciaclickone.com
    Input Text  //*[@id="form-field-message"]  30000000
    Click Element  //*[@id="form-field-Aceptolapoliticadeprivacidad"]
    Click Button  //*[@id="colophon"]/div/div/div/div/section[1]/div[2]/div/div[2]/div/div/div/div/form/div/div[5]/button
    Wait Until Page Contains  Gracias por contactarnos  15
    [Teardown]  Close Browser

*** Keywords ***
Create Chrome Options
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    RETURN    ${options}
