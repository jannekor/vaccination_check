*** Settings ***

Library    SeleniumLibrary
Library    Dialogs

Test Teardown    Close Application

*** Test Case ***

Check For Free Vaccination Appointments
    Open Browser    browser=Chrome    url=https://hameenlinna.terveytesi.fi/portal#/main
    Maximize Browser Window
    Wait And Click    id=homepage_login_button
    Wait And Click    id=mobiilivarmenne
    Wait Until Element Is Visible    id=username
    Input Text    id=username    0400413206
    Click Element    //input[@value="Jatka"]
    Wait And Click    id=continue-button
    Wait And Click    id=citizenbooking-tile
    Wait And Click    id=NewBookingButton
    Wait And Click    id=contract0
    Wait Until Element Is Visible    //select[@id="select_calendar" and @aria-disabled="false"]
    Click Element    id=select_calendar
    Select From List By Label    id=select_calendar    Kuka tahansa
    Sleep    2s
    ${status}=  Run Keyword And Return Status    Page Should Not Contain     Valitsemallesi vastaanottajalle ei löytynyt vapaita aikoja.
    Run Keyword If    ${status} == True    Sleep    3600s

*** Keywords ***

Wait And Click
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=30s
    Click Element    ${locator}

Close Application
    Click Element    id=navbar_login_button
    Wait Until Page Contains    Tervetuloa kansalaisen terveyspalveluun.
    Close Browser