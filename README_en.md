Twitter for AS3
===============

#Note
* This is an unofficial project. Don't ask your questions to the Twitter official.
* [as3crypto](http://code.google.com/p/as3crypto/) is required.

#First steps
1.
Login to https://dev.twitter.com/ with your twitter account, create your application, and get the consumer key and the consumer key secret.

2.
Make an instance of Twitter

    var twitter:Twitter = new Twitter(<your consumer key>, <your consumer key secret>);

3.
Get the request token and the request token secret

    var rtRequest:TwitterRequest = twitter.oauth_requestToken();

You should add an event listener of TwitterRequestEvent.COMPLETE to rtRequest.  
After completing this, get the URL of authorization page with twitter.getOAuthAuthorizeURL(),
open the page in your browser, authorize your application, and get the PIN.

4.
Get the access token and the access token secret

Let 'pin' be the PIN you've get.

    var atRequest:TwitterRequest = twitter.oauth_accessToken(pin);

You should also add an event listener of TwitterRequestEvent.COMPLETE to atRequest. 
After completing this, you can use all the APIs.

5.
Post a status by way of experiment

    twitter.statuses_update("Hello!");

6.
If you have already get the access token and the access token secret, you can call the constructor with these tokens.
  
    var twitter:Twitter = new Twitter(<consumer key>, <consumer key secret>, <access token>, <access token secret>);

Then you can use all the APIs immediately, without the complicated process I've mentioned above.

Please see also: https://dev.twitter.com/docs/api/1.1


#Error handling
To handle errors, add some event listener for TwitterErrorEvent to the request.

	var request:TwitterRequest = twitter.statuses_update(...);
	request.addEventListener(TwitterErrorEvent.CLIENT_ERROR,
		function(event:TwitterErrorEvent):void
		{
			/*
				error handling
			*/
			event.preventDefault();
		});

This is an example for client error (HTTP 4xx).
You can also handle server errors (HTTP 5xx) with TwitterErrorEvent.SERVER_ERROR the same way.
