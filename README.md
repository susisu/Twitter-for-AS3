Twitter for AS3
===============
ActionScript 3 library for Twitter API v1.1

This is an *unofficial* project. Don't ask your question to the Twitter official.

# Requirements
* [as3crypto](http://code.google.com/p/as3crypto/)

# Usage
## First steps
If you are not used to dealing with Twitter authentication and APIs, it may help you reading the [documentation](https://dev.twitter.com/overview/documentation) of Twitter.

1.
Get the consumer key and the consumer secret for your application.

Please login to https://dev.twitter.com/ with your twitter account and create or select your application.
You can get the keys from "Keys and Access Tokens" tab of the your app's page.

2.
Create an instance of `Twitter` class.

*If you already have access tokens, please go to 6*.

Specify your keys to its arguments.
``` actionscript
var twitter:Twitter = new Twitter(<your consumer key>, <your consumer secret>);
```

3.
Get the request token and the request token secret.

First, send a request by `twitter.oauth_requestToken()`
``` actionscript
var rtRequest:TwitterRequest = twitter.oauth_requestToken();
```
and add an event listener for `TwitterRequestEvent.COMPLETE` to `rtRequest`.
``` actionscript
rtRequest.addEventListener(TwitterRequestEvent.COMPLETE, <listener>);
```

As the request is complete, you can get the URL to authenticate the app on your account by
``` actionscript
twitter.getOAuthAuthorizeURL();
```
and open the URL in your browser.

After authentication you get a PIN, that is used in the next step.

4.
Get the access token and the access token secret.

Let `pin` be the PIN you've get, send a request by `twitter.oauth_accessToken()`
``` actionscript
var atRequest:TwitterRequest = twitter.oauth_accessToken(pin);
```
and also add an event listener for `TwitterRequestEvent.COMPLETE` to `atRequest`.
``` actionscript
atRequest.addEventListener(TwitterRequestEvent.COMPLETE, <listener>);
```

If it's complete, you are ready to use the REST APIs.

5.
For a test, try to post a tweet.

``` actionscript
twitter.statuses_update("Hello!");
```

6.
If you already have the access token and the access token secret, you can sepcify them when you create an `Twitter` instance.
``` actionscript
var twitter:Twitter = new Twitter(<consumer key>, <consumer secret>, <access token>, <access token secret>);
```
Then you can use the REST APIs immediately.

## Error handling
To handle errors, add an event listener for `TwitterErrorEvent` to the request.
This is an example for handling client errors (HTTP 4xx), and you can also handle server errors (HTTP 5xx) with `TwitterErrorEvent.SERVER_ERROR` in the same way.
``` actionscript
var request:TwitterRequest = twitter.statuses_update(...);
request.addEventListener(TwitterErrorEvent.CLIENT_ERROR,
    function(event:TwitterErrorEvent):void
    {
        /* error handling code here */
        event.preventDefault();
    }
);
```

# Example
An example app is in `example` directory.

# License
The MIT License

# Author
Susisu ([Twitter](https://twitter.com/susisu2413), [GitHub](https://github.com/susisu))
