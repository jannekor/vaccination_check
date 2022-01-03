*** Settings ***

Library    SeleniumLibrary
Library    Dialogs

Test Teardown    Close Application

*** Test Case ***

Check For Free Vaccination Appointments
    Open Browser    browser=Chrome    url=https://hameenlinna.terveytesi.fi/portal#/main
    Maximize Browser Window
    Wait And Click    id=login-button-body
    Wait And Click    id=mobiilivarmenne
    Wait Until Element Is Visible    id=username
    # Add phone number below as argument
    Input Text    id=username    # <phone_number_here>
    Click Element    //input[@value="Jatka"]
    Wait And Click    id=continue-button
    Wait And Click    //button[text()=" Varaa uusi aika "]
    Wait And Click    id=NewBookingButton
    Wait And Click    id=contract1
    Wait Until Element Is Visible    //button[@id="select_contract" and @aria-disabled="false"]
    Wait And Click    id=select_contract
    Sleep    2s
    Wait And Click    //a//b[text()="Kolmas koronarokoteannos kaikille 18 vuotta täyttäneille"]
    Wait Until Element Is Visible    //select[@id="select_careunit" and @aria-disabled="false"]    timeout=30s
    Wait And Click    id=select_careunit
    Select From List By Label    id=select_careunit    Verkatehdas
    Wait Until Element Is Visible    //select[@id="select_calendar" and @aria-disabled="false"]
    Select From List By Label    id=select_calendar    Kuka tahansa
    ${status}=  Run Keyword And Return Status    Page Should Not Contain     Valitsemallesi vastaanottajalle ei löytynyt vapaita aikoja.
    Run Keyword If    ${status} == True    Sleep    7200s
    Run Keyword If    ${status} == False    Fail    msg="No vaccination appointments available."

*** Keywords ***

Wait And Click
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=30s
    Click Element    ${locator}

Close Application
    # Sleep  7200s
    Click Element    id=navbar_login_button
    Wait Until Page Contains    Tervetuloa kansalaisen terveyspalveluun
    Close Browser