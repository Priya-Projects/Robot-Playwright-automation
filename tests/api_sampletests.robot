*** Settings ***
Resource      ../resources/api_keywords.resource
Suite Setup   Create API Session
Test Tags     api


*** Test Cases ***
API01 - Get Single User Returns Correct Details
    ${response}=    Get User By Id    1
    ${user}=    Set Variable    ${response.json()}
    Should Be Equal As Integers    ${user}[id]    1
    Should Not Be Empty    ${user}[name]
    Should Contain    ${user}[email]    @

API02 - Get All Posts Returns A List
    ${response}=    Get All Posts
    ${posts}=    Set Variable    ${response.json()}
    ${count}=    Get Length    ${posts}
    Should Be True    ${count} > 0

API03 - Posts Filtered By User Belong To That User
    ${response}=    Get Posts By User    1
    FOR    ${post}    IN    @{response.json()}
        Should Be Equal As Integers    ${post}[userId]    1
    END

API04 - Create Post Returns Created Data
    ${response}=    Create Post    My title    My body    1
    Should Be Equal As Integers    ${response.status_code}    201
    Should Be Equal    ${response.json()}[title]    My title
    Should Be Equal    ${response.json()}[body]    My body
    Should Not Be Empty    ${response.json()}[id]

API05 - Update Post Returns Updated Data
    ${response}=    Update Post    1    Updated title    Updated body    1
    Should Be Equal    ${response.json()}[title]    Updated title

API06 - Delete Post Returns Success
    ${response}=    Delete Post    1
    Should Be Equal As Integers    ${response.status_code}    200

API07 - Unknown Post Returns 404
    ${response}=    Get Post Expecting Not Found    99999
    Should Be Equal As Integers    ${response.status_code}    404