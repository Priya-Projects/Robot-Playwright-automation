*** Settings ***
#Library           Browser
Resource    ../resources/ui_keywords.resource
Test Teardown    Run Keyword If Test Failed    Take Screenshot On Failure
Suite Teardown    Close Browser

*** Test Cases ***
TC01 - Valid Login Shows Inventory Page
    Open SauceDemo
    Login with Credentials    ${STANDARD_USER}    ${PASSWORD}
    Verify Inventory Page Is Displayed

TC02-Invalid Login shows error page
    Open SauceDemo
    Login with Credentials    ${LOCKED_USER}    ${PASSWORD}
    Verify If Error Message Displayed For LockedUser Login

TC03-Verify The Number of Products
    Open SauceDemo
    Login with Credentials    ${STANDARD_USER}    ${PASSWORD}
    Verify Inventory Page Is Displayed
    Get Products Count

TC04-Verify If products Are Displayed
    Open SauceDemo
    Login with Credentials    ${STANDARD_USER}    ${PASSWORD}
    Verify Inventory Page Is Displayed
    Verify If products Are Displayed

TC05-Products Added To Cart And Cart Badge Matches With Number Of Products Added
    Open SauceDemo
    Login with Credentials    ${STANDARD_USER}    ${PASSWORD}
    Verify Inventory Page Is Displayed
    Add Product To Cart    Sauce Labs Backpack
    Add Product To Cart    Sauce Labs Bolt T-Shirt
    Verify Cart Badge Count On Adding Products    2

TC06-Products Are Removed From Cart And Cart Badge Number Decreases Based On Products Removal
    Open SauceDemo
    Login with Credentials    ${STANDARD_USER}    ${PASSWORD}
    Verify Inventory Page Is Displayed
    Add Product To Cart    Sauce Labs Backpack
    Add Product To Cart    Sauce Labs Bolt T-Shirt
    Verify Cart Badge Count On Adding Products    2
    Remove Product From Cart    Sauce Labs Backpack
    Verify Cart Badge Count On Removal Of Products    1
