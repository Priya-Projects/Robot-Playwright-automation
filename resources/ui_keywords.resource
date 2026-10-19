*** Settings ***
Library    Browser

*** Variables ***
${BASE_URL}    https://www.saucedemo.com/
${STANDARD_USER}    standard_user
${LOCKED_USER}    locked_out_user
${PROBLEM_USER}    problem_user
${PERFORMANCE_GLITCH_USER}    performance_glitch_user
${ERROR_USER}    error_user
${VISUAL_USER}    visual_user

${PASSWORD}    secret_sauce

${PAGE_TITLE}    css=.title

${LOCKEDUSER_ERRORMSG}    role=alert

${PRODUCTS_LIST}    css=.inventory_item

${ADD_TO_CART_BUTTON}    css=[data-test^="add-to-cart"]    #The ^= means “starts with”. This is common to all products.
${ADD_BACKPACK}    id=add-to-cart-sauce-labs-backpack
${ADD_BIKELIGHT}    id=add-to-cart-sauce-labs-bike-light
${ADD_T-SHIRT}    id=add-to-cart-sauce-labs-bolt-t-shirt
${ADD_FLEECEJACKET}    id=add-to-cart-sauce-labs-fleece-jacket
${ADD_ONESIE}    id=add-to-cart-sauce-labs-onesie
${ADD_RED_TSHIRT}    id=add-to-cart-test.allthethings()-t-shirt-(red)
${CART_BADGE}    css=.shopping_cart_badge

${REMOVE_PRODUCT}    CSS=[data-test^="remove"]
${REMOVE_BACKPACK}    id=remove-sauce-labs-backpack
${REMOVE_BIKELIGHT}    id=remove-sauce-labs-bike-light
${REMOVE_T-SHIRT}    id=remove-sauce-labs-bolt-t-shirt
${REMOVE_FLEECEJACKET}    id=remove-sauce-labs-fleece-jacket
${REMOVE_ONESIE}    id=remove-sauce-labs-onesie
${REMOVE_RED_TSHIRT}    id=remove-test.allthethings()-t-shirt-(red)


*** Keywords ***
Take Screenshot On Failure
    Take Screenshot    EMBED    fullPage=True

Open SauceDemo
    New Browser    chromium    headless=False
    New Page    ${BASE_URL}

Login with Credentials
    [Arguments]    ${username}    ${password}
    Fill Text    id=user-name    ${username}
    Fill Text    id=password    ${password}
    Click    id=login-button

#Add T-shirt To Cart
    #click    id=add-to-cart-sauce-labs-bolt-t-shirt

Go To Cart
    Click    css=.shopping_cart_link

#Fill Checkout Info
    click    id=checkout
    Fill Text    id=first-name    ${firstname}
    Fill Text    id=last-name    ${lastname}
    Fill Text    id=postal-code    ${postal-code}
    click    id=continue

 #Finish Checkout
    click    id=finish
    ${promise}=    Promise To Wait For Dowload
    click    id=generate-pdf-order
    ${file_obj}=    Wait For    ${promise}
    Move File    ${file_obj}[saveAs]    ${target_dir}/${file_obj}[suggestedFilename]
    RETURN    ${target_dir}/${file_obj}[suggestedFilename]

Verify Inventory Page Is Displayed
    Get Text    ${PAGE_TITLE}    ==    Products

Verify If Error Message Displayed For LockedUser Login
    Get Text    ${LOCKEDUSER_ERRORMSG}    Contains    user has been locked out

Get Products Count
   #IF ${PRODUCTS_LIST}>    0 
    Get Element Count    ${PRODUCTS_LIST}    ==    6
    #END

Verify If products Are Displayed
    ${Products}=    Get Elements    ${PRODUCTS_LIST}
    FOR    ${Product_name}    IN    @{Products}
        ${Product_DisplayName}    Get Text    ${Product_name} 
        Log    ${Product_DisplayName}
    END    
Add Backpack To Cart
    Click    ${ADD_BACKPACK}
Add BikeLight To Cart
    Click    ${ADD_BIKELIGHT}
Add T-Shirt To Cart
    Click   ${ADD_T-SHIRT} 
Add FleeceJacket To Cart
    Click    ${ADD_FLEECEJACKET}
Add Onesie To Cart
    Click    ${ADD_ONESIE}
Add RedT-Shirt To Cart
    Click    ${ADD_RED_TSHIRT}
    
#Add Products To Cart
    [Arguments]    ${number_of_products}
    FOR    ${i}    IN RANGE    ${number_of_products}
        Click    ${ADD_TO_CART_BUTTON} >> nth=0
    END

Verify Cart Badge Count On Adding Products
    [Arguments]    ${expected_count}
    ${expected}=    Convert To String    ${expected_count}
    Get Text    ${CART_BADGE}    ==    ${expected}

Remove Backpack To Cart
    Click    ${REMOVE_BACKPACK}
Remove BikeLight To Cart
    Click    ${REMOVE_BIKELIGHT}
Remove T-Shirt To Cart
    Click   ${REMOVE_T-SHIRT} 
Remove FleeceJacket To Cart
    Click    ${REMOVE_FLEECEJACKET}
Remove Onesie To Cart
    Click    ${REMOVE_ONESIE}
Remove RedT-Shirt To Cart
    Click    ${REMOVE_RED_TSHIRT}

Add Products To Cart
    [Arguments]    ${number_of_products}
    FOR    ${i}    IN RANGE    ${number_of_products}
        Click    ${ADD_TO_CART_BUTTON} >> nth=0
    END

Add Product To Cart
    [Arguments]    ${product_name}
    Click    css=.inventory_item:has-text("${product_name}") >> role=button[name="Add to cart"]

Remove Product From Cart
    [Arguments]    ${product_name}
    Click    css=.inventory_item:has-text("${product_name}") >> role=button[name="Remove"]
    
Verify Cart Badge Count On Removal Of Products
    [Arguments]    ${expected_count}
    ${expected}=    Convert To String    ${expected_count}
    Get Text    ${CART_BADGE}    ==    ${expected}        