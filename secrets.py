import os

# Go to http://dev.twitter.com and create an app.
# The consumer key and secret will be generated for you after
consumer_key = os.environ.get("consumer_key")
consumer_secret = os.environ.get("consumer_secret")

# After the step above, you will be redirected to your app's page.
# Create an access token under the the "Your access token" section
access_token = os.environ.get("access_token")
access_token_secret = os.environ.get("token_secret")