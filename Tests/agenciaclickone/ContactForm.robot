*** Settings ***
Documentation  Contact Form
Library  SeleniumLibrary

*** Variables ***

*** Test Cases ***
Verify contact form for ClickOne - Google Chrome
    [Documentation]  This test case verifies the contact form
    [Tags]  Functional

    Open Browser  https://agenciaclickone.com/  chrome
    Input Text  //*[@id="form-field-name"]  John Doe
    Input Text  //*[@id="form-field-email"]  email@agenciaclickone.com
    Input Text  //*[@id="form-field-message"]  30000000
    Click Element  //*[@id="form-field-Aceptolapoliticadeprivacidad"]
    Click Button  //*[@id="colophon"]/div/div/div/div/section[1]/div[2]/div/div[2]/div/div/div/div/form/div/div[5]/button
    Wait Until Page Contains  Gracias por contactarnos  15
    Close Browser

Verify contact form for ClickOne - Forefox
    [Documentation]  This test case verifies the contact form
    [Tags]  Functional

    Open Browser  https://agenciaclickone.com/  firefox
    Input Text  //*[@id="form-field-name"]  John Doe
    Input Text  //*[@id="form-field-email"]  email@agenciaclickone.com
    Input Text  //*[@id="form-field-message"]  30000000
    Click Element  //*[@id="form-field-Aceptolapoliticadeprivacidad"]
    Click Button  //*[@id="colophon"]/div/div/div/div/section[1]/div[2]/div/div[2]/div/div/div/div/form/div/div[5]/button
    Wait Until Page Contains  Gracias por contactarnos  15
    Close Browser

*** Keywords ***
