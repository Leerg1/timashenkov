*** Settings ***
Resource   pageobject.robot

*** Test Cases ***

get a title of a third google answer
    open a search page  https://www.google.com
    send a search request   Python
    ${search_result} =  get a third search result
    select a search result  ${search_result}
    get current title
    close browser
