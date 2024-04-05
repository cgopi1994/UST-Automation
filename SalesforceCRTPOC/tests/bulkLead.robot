*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite
Test Template                   CreateBulkLead

*** Test Cases ***
CreateBulkLead with ${LeadName}
    
*** Keywords ***
CreateBulkLead
    [Arguments]    ${LeadName}    ${FirstName}    ${LastName}    ${Name}    ${Status}    ${Email}
    Appstate                  Home            
    LaunchApp                 Sales
    ClickText                 Leads
    VerifyText                Change Owner
    ClickText                 New
    VerifyText                Lead Information
    
    UseModal                  On                          # Only find fields from open modal dialog
    Picklist                  Salutation                  Ms.
    TypeText                  First Name                  ${FirstName}
    TypeText                  Last Name                   ${LastName}
    Picklist                  Lead Status                 ${Status}
    # generate random phone number, just as an example
    # NOTE: initialization of random number generator is done on suite setup
    ${rand_phone}=            Generate Random String      14                          [NUMBERS]
    # concatenate leading "+" and random numbers
    ${phone}=                 SetVariable                 +${rand_phone}
    TypeText                  Phone                       ${phone}                    First Name
    TypeText                  Company                     Growmore                    Last Name
    TypeText                  Title                       Manager                     Address Information
    TypeText                  Email                       ${Email}       Rating
    TypeText                  Website                     https://www.growmore.com/
    Picklist                  Lead Source                 Partner
    ClickText                 Save                        partial_match=False
    UseModal                  Off
    Sleep                     1
    
    ClickText                 Details
    VerifyField               Name                        ${Name}
    VerifyField               Lead Status                 ${Status}
    VerifyField               Phone                       ${phone}
    VerifyField               Company                     Growmore
    VerifyField               Website                     https://www.growmore.com/
    