*** Settings ***
Library    RequestsLibrary
Library    Collections


*** Variables ***
${API_BASE_URL}    https://jsonplaceholder.typicode.com
${API_ALIAS}       jsonplaceholder


*** Keywords ***
Create API Session
    Create Session    ${API_ALIAS}    ${API_BASE_URL}    verify=${True}

Get User By Id
    [Arguments]    ${user_id}    ${expected_status}=200
    ${response}=    GET On Session    ${API_ALIAS}    /users/${user_id}    expected_status=${expected_status}
    RETURN    ${response}

Get All Posts
    ${response}=    GET On Session    ${API_ALIAS}    /posts    expected_status=200
    RETURN    ${response}

Get Posts By User
    [Arguments]    ${user_id}
    ${params}=    Create Dictionary    userId=${user_id}
    ${response}=    GET On Session    ${API_ALIAS}    /posts    params=${params}    expected_status=200
    RETURN    ${response}

Create Post
    [Arguments]    ${title}    ${body}    ${user_id}
    ${payload}=    Create Dictionary    title=${title}    body=${body}    userId=${user_id}
    ${response}=    POST On Session    ${API_ALIAS}    /posts    json=${payload}    expected_status=201
    RETURN    ${response}

Update Post
    [Arguments]    ${post_id}    ${title}    ${body}    ${user_id}
    ${payload}=    Create Dictionary    id=${post_id}    title=${title}    body=${body}    userId=${user_id}
    ${response}=    PUT On Session    ${API_ALIAS}    /posts/${post_id}    json=${payload}    expected_status=200
    RETURN    ${response}

Delete Post
    [Arguments]    ${post_id}
    ${response}=    DELETE On Session    ${API_ALIAS}    /posts/${post_id}    expected_status=200
    RETURN    ${response}

Get Post Expecting Not Found
    [Arguments]    ${post_id}
    ${response}=    GET On Session    ${API_ALIAS}    /posts/${post_id}    expected_status=404
    RETURN    ${response}
