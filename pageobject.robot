*** Settings ***
Library    Collections
Library    SeleniumLibrary


*** Keywords ***

open a search page
    [Arguments]  ${url}
    open browser  ${url}  Chrome
    wait until element is visible  xpath=//img[@alt='Google']

send a search request
    [Arguments]  ${query_data}
    wait until element is visible  xpath=//input[@role="combobox"]  timeout=10s
    input text  xpath=//input[@role="combobox"]  text=${query_data}
    wait until element is visible  identifier:btnK  timeout=10s
    click element  identifier:btnK
    wait until element is visible  identifier:gsr  timeout=10s

get a third search result
    ${links_count} =  Get Element Count  xpath=//h3
    ${list_links_positions}  create list
    ${expected_position} =  Get Horizontal Position  xpath=(//h3)[1]
    FOR  ${i}  IN RANGE  1  ${links_count}
        ${link_position} =  Get Horizontal Position  xpath=(//h3)[${I}]
        append to list  ${list_links_positions}  ${link_position}
        ${google_answers_count} =  evaluate  ${list_links_positions}.count(${expected_position})
        exit for loop if	'${google_answers_count}' == '3'
    END
    ${search_result} =  get text  (//h3)[${i}]
    [Return]  ${search_result}

select a search result
    [Arguments]  ${search_result}
    wait until element is visible  locator=//*[text()='${search_result}']  timeout=10s
    click element  locator=//*[text()='${search_result}']

get current title
    ${current_title} =  get title
    log to console  ${current_title}
    [Return]  ${current_title}
