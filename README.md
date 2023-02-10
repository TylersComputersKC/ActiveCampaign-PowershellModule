# ActiveCampaignModule
Powershell Module for ActiveCampaign

# Connect to the ActiveCampaign API
Connect-ActiveCampaign -ApiKey "your_api_key" -Url "https://your_account.api-us1.com"

# Get a single contact by email
$contact = Get-ACContactByCriteria -Criteria "email" -Value "john.doe@example.com"

# Get a single contact by phone number
$contact = Get-ACContactByCriteria -Criteria "phone" -Value "1234567890"

# Get a single contact by name
$contact = Get-ACContactByCriteria -Criteria "name" -Value "John Doe"

# Create a new contact
$contactId = New-ACContact -Email "jane.doe@example.com" -FirstName "Jane" -LastName "Doe" -Phone "1234567890" -Company "Example Inc."

# Get all ACContacts
Get-ACContact -Limit 0
