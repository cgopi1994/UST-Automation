# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***

User Authentication - Invalid
    [Tags]    Authentication
    GoTo      ${login_url}
    TypeText              Username                    gopi@sf.com
    TypeSecret            Password                    Test1234
    ClickText             Log In
    VerifyText            Please check your username and password. If you still can't log in, contact your Salesforce administrator.

User Authentication - Valid 
    [Tags]        Authentication
    Appstate      Home

Navigation
    [Tags]        Navigation
    Appstate      Home
    LaunchApp     Service
    ClickText     Cases
    VerifyText    New
    VerifyText    Recently Viewed 
    VerifyText    Cases
    LaunchApp     Sales
    ClickText     Leads
    VerifyText    Change Owner
    VerifyText    New
    
Case Create
    [Tags]        Case
    Appstate          Home
    LaunchApp         Service
    ClickText         Cases
    VerifyText        New
    ClickText         New
    UseModal          On

    Picklist          Status    New
    PickList          Type      Sample Cases
    PickList          Case Origin    Web
    PickList          Case Reason    New problem
    PickList          Priority       Low
    TypeText          Subject        Case Subject Area
    TypeText          Description    Case Description Area
    TypeText          Web Phone      34567834
    ClickText           Save         anchor=2
    UseModal            Off
    Sleep               1
    
    VerifyField         Status       New
    VerifyField         Type         Sample Cases
    VerifyField         Case Origin    Web
    VerifyField         Case Reason    New problem
    VerifyField         Subject        Case Subject Area
    VerifyField         Description    Case Description Area
    VerifyField         Web Phone      34567834
    ${case}=             GetFieldValue    Case Number
    Set Suite Variable   ${case_num}     ${case}


Case Update
    [tags]                    Case
    Appstate                  Home
    LaunchApp                 Service
    ClickText                 Cases
    ClickText                 ${case_num}
    VerifyText                Edit
    ClickText                 Edit
    
    UseModal                  On
    VerifyText                Edit ${case_num}  
    PickList                  Type    Trial
    PickList                  Priority    High
    TypeText                  Subject   Updated Case Subject
    ClickText                 Save                 anchor=2
    UseModal                  Off
    Sleep                     1

    VerifyField               Type                 Trial
    VerifyField               Priority             High
    VerifyField               Subject              Updated Case Subject

Case Assignment 
    [tags]                    Case
    Appstate                  Home
    LaunchApp                 Service
    ClickText                 Cases
    ClickText                 ${case_num}
    VerifyText                Change Owner
    ClickText                 Change Owner
    VerifyText                Change Case Owner
    TypeText                  Search Users...    Integration User
    ClickText                 Integration User
    ClickText             Send notification email
    VerifyText            Submit
    ClickText             Submit
    Sleep                 1
    VerifyText               Integration User


CreateLead with ${LeadName}
    [tags]                    Lead
    CreateLead              ${FirstName}    ${LastName}    ${Name}    ${Status}    ${Email}                
    Set Suite Variable    ${lead}           ${FirstName} ${LastName}
    #Set Suite Variable     ${lead}    Tina Smith
    
Update Lead
    [tags]            Lead
    Appstate                  Home
    LaunchApp                 Sales
    ClickText                 Leads
    VerifyText                ${lead} 
    ClickText                 ${lead} 
    VerifyText                Edit    anchor=2
    ClickText                 Edit    anchor=2
    
    UseModal                  On
    VerifyText                Edit ${lead}  
    PickList                  Lead Status    Contacted
    TypeText                  City   New York
    TypeText                  Description    Updated as per the new inputs
    ClickText                 Save           anchor=2
    UseModal                  Off
    Sleep                     1

    VerifyText                Details
    ClickText                 Details
    VerifyField               Lead Status    Contacted
    VerifyField               Address     New York      
    VerifyField               Description    Updated as per the new inputs

Lead Button
    [tags]            Lead
    Appstate                  Home
    LaunchApp                 Sales
    ClickText                 Leads
    VerifyText                ${lead} 
    ClickText                 ${lead} 
    VerifyText                Convert
    VerifyText                Edit
    VerifyText                Delete
    VerifyText                Show more actions
    ClickText                 Show more actions
    VerifyText                Clone
    VerifyText                Change Owner
    VerifyText                Sharing
    VerifyText                Sharing Hierarchy 
    VerifyText                Check for New Data
    VerifyText                Printable View                   
    
#Delete Test Data
#    [tags]                    Test data
#    ClickText                 Leads
#    VerifyText                Change Owner
#    Set Suite Variable        ${data}                     Tina Smith
#    RunBlock                  NoData                      timeout=180s                exp_handler=DeleteLeads
#    Set Suite Variable        ${data}                     Diana Mian
#    RunBlock                  NoData                      timeout=180s                exp_handler=DeleteLeads
#    Set Suite Variable        ${data}                     Roma Alice
#    RunBlock                  NoData                      timeout=180s                exp_handler=DeleteLeads


