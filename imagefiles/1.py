from os import uname

# Update this if statement to something that will match your production environment.
# In this example, 'webfaction' is in the hostname of the production server.
if 'webfaction' in uname()[1]:
        # Update this to point to your production database.
        settings.database_uri = 'postgres://username:password@database-host.com/database_name'

# Update this with your Janrain API key
settings.janrain_api_key = 'ThisIsntARealKey'

# Add your Janrain domain (without the .rpxnow.com suffix)
settings.janrain_domain = 'my-janrain-domain'

# Enable captchas during registration
settings.enable_captchas = True
