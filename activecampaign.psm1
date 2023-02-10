# Define the ActiveCampaign module
Function Connect-ActiveCampaign {
    param(
        [Parameter(Mandatory=$true)]
        [string] $ApiKey,
        [Parameter(Mandatory=$true)]
        [string] $Url
    )

    # Store the API key and URL in a global variable for later use
    $global:ActiveCampaignApiKey = $ApiKey
    $global:ActiveCampaignUrl = $Url
}

Function Get-ACContact {
    param(
        [Parameter(Mandatory=$false)]
        [int] $Limit = 50
    )

    # Check if the API key and URL have been set
    if (!$global:ActiveCampaignApiKey) {
        Write-Error "ActiveCampaign API key not set. Use Connect-ActiveCampaign to set the API key."
        return
    }

    if (!$global:ActiveCampaignUrl) {
        Write-Error "ActiveCampaign URL not set. Use Connect-ActiveCampaign to set the URL."
        return
    }

    # Build the URL to retrieve contacts
    $url = "$($global:ActiveCampaignUrl)/api/3/contacts?limit=$Limit"

    # Send a GET request to retrieve the contacts
    $response = Invoke-WebRequest -Uri $url -Headers @{ "Api-Token" = $global:ActiveCampaignApiKey } -Method Get

    # Parse the JSON response and return the contacts
    $contacts = ($response.Content | ConvertFrom-Json).contacts
    return $contacts
}

Function Get-ACContactByCriteria {
    param(
        [Parameter(Mandatory=$true)]
        [string] $Criteria,
        [Parameter(Mandatory=$true)]
        [string] $Value
    )

    # Check if the API key and URL have been set
    if (!$global:ActiveCampaignApiKey) {
        Write-Error "ActiveCampaign API key not set. Use Connect-ActiveCampaign to set the API key."
        return
    }

    if (!$global:ActiveCampaignUrl) {
        Write-Error "ActiveCampaign URL not set. Use Connect-ActiveCampaign to set the URL."
        return
    }

    # Build the URL to retrieve the contact
    $url = "$($global:ActiveCampaignUrl)/api/3/contacts/sync?searchField=$Criteria&searchValue=$Value"

    # Send a GET request to retrieve the contact
    $response = Invoke-WebRequest -Uri $url -Headers @{ "Api-Token" = $global:ActiveCampaignApiKey } -Method Get

    # Parse the JSON response and return the contact
    $contact = ($response.Content | ConvertFrom-Json).contacts
    return $contact
}

Function New-ACContact {
    param(
        [Parameter(Mandatory=$true)]
        [string] $Email,
        [Parameter(Mandatory=$false)]
        [string] $FirstName,
        [Parameter(Mandatory=$false)]
        [string] $LastName,
        [Parameter(Mandatory=$false)]
        [string] $Phone,
        [Parameter(Mandatory=$false)]
        [string] $Company
        )
        # Check if the API key and URL have been set
        if (!$global:ActiveCampaignApiKey) {
            Write-Error "ActiveCampaign API key not set. Use Connect-ActiveCampaign to set the API key."
            return
        }

        if (!$global:ActiveCampaignUrl) {
            Write-Error "ActiveCampaign URL not set. Use Connect-ActiveCampaign to set the URL."
            return
        }

        # Build the JSON payload for the new contact
        $payload = @{
            "contact" = @{
                "email" = $Email
                "firstName" = $FirstName
                "lastName" = $LastName
                "phone" = $Phone
                "company" = $Company
            }
        } | ConvertTo-Json

        # Build the URL to create the contact
        $url = "$($global:ActiveCampaignUrl)/api/3/contacts"

        # Send a POST request to create the contact
        $response = Invoke-WebRequest -Uri $url -Headers @{ "Api-Token" = $global:ActiveCampaignApiKey } -Method Post -Body $payload

        # Parse the JSON response and return the contact ID
        $contactId = ($response.Content | ConvertFrom-Json).contact_id
        return $contactId

}


# Export the functions in the module so they can be used in other scripts
Export-ModuleMember -Function Connect-ActiveCampaign, Get-ACContact, New-ACContact, Get-ACContactByCriteria
