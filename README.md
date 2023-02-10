# ActiveCampaignModule
Powershell Module to manage contacts in ActiveCampaign

# Connect to the ActiveCampaign API
Connect-ActiveCampaign -ApiKey "your_api_key" -Url "https://your_account.api-us1.com"

# Create a new contact
$contactId = New-ACContact -Email "jane.doe@example.com" -FirstName "Jane" -LastName "Doe" -Phone "1234567890" -Company "Example Inc."

# Get all ACContacts
Get-ACContact -Limit 0
