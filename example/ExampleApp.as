/*
 * An exmaple app for Twitter for AS3
 *
 * copyright (c) 2015 Susisu
 */

package
{
    
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFieldType;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;

    import isle.susisu.twitter.Twitter;
    import isle.susisu.twitter.TwitterRequest;
    import isle.susisu.twitter.events.TwitterRequestEvent;
    import isle.susisu.twitter.events.TwitterErrorEvent;
    
    [SWF(width="480", height="360", backgroundColor="0x000000", frameRate="60")]
    public class ExampleApp extends Sprite
    {
        
        private var outputConsole:TextField;
        private var openBrowserButton:Sprite;
        private var pinInputField:TextField;
        private var getAccessTokenButton:Sprite;
        private var tweetInputField:TextField;
        private var tweetButton:Sprite;
        
        private var twitter:Twitter;

        public function ExampleApp()
        {
            // Replace <consumer key> and <consumer key secret> with your app's
            this.twitter = new Twitter("<consumer key>","<consumer key secret>");

            // Create UI
            // Output console
            this.outputConsole = new TextField();
            this.outputConsole.width = 480;
            this.outputConsole.height = 180;
            this.outputConsole.border = true;
            this.outputConsole.background = true;
            this.outputConsole.backgroundColor = 0xffffff;
            this.outputConsole.text = "";
            this.addChild(this.outputConsole);

            // "Open browser" button
            this.openBrowserButton = new Sprite();
            var openBrowserButtonText:TextField = new TextField();
            openBrowserButtonText.width = 80;
            openBrowserButtonText.height = 20;
            openBrowserButtonText.background = true;
            openBrowserButtonText.backgroundColor = 0xc0c0c0;
            openBrowserButtonText.border = true;
            openBrowserButtonText.text = "Open browser";
            this.openBrowserButton.addChild(openBrowserButtonText);
            this.openBrowserButton.y = 180;
            this.openBrowserButton.buttonMode = true;
            this.openBrowserButton.mouseChildren = false;
            this.addChild(this.openBrowserButton);
            this.openBrowserButton.addEventListener(MouseEvent.CLICK, onOpenBrowserButtonClick);

            // PIN input field
            this.pinInputField = new TextField();
            this.pinInputField.x = 80;
            this.pinInputField.y = 180;
            this.pinInputField.width = 200;
            this.pinInputField.height = 20;
            this.pinInputField.background = true;
            this.pinInputField.backgroundColor = 0xffffff;
            this.pinInputField.border = true;
            this.pinInputField.type = TextFieldType.INPUT;
            this.pinInputField.text = "Input PIN here";
            this.addChild(this.pinInputField);

            // "Get access token" button
            this.getAccessTokenButton = new Sprite();
            var getAccessTokenButtonText:TextField = new TextField();
            getAccessTokenButtonText.width = 200;
            getAccessTokenButtonText.height = 20;
            getAccessTokenButtonText.background = true;
            getAccessTokenButtonText.backgroundColor = 0xc0c0c0;
            getAccessTokenButtonText.border = true;
            getAccessTokenButtonText.text = "Get access tokens";
            this.getAccessTokenButton.addChild(getAccessTokenButtonText);
            this.getAccessTokenButton.x = 280;
            this.getAccessTokenButton.y = 180;
            this.getAccessTokenButton.buttonMode = true;
            this.getAccessTokenButton.mouseChildren = false;
            this.addChild(this.getAccessTokenButton);
            this.getAccessTokenButton.addEventListener(MouseEvent.CLICK, onGetAccessTokenButtonClick);

            // Tweet input field
            this.tweetInputField = new TextField();
            this.tweetInputField.y = 200;
            this.tweetInputField.width = 480;
            this.tweetInputField.height = 140;
            this.tweetInputField.background = true;
            this.tweetInputField.backgroundColor = 0xffffff;
            this.tweetInputField.border = true;
            this.tweetInputField.type = TextFieldType.INPUT;
            this.tweetInputField.text = "Input your tweet here"
            this.addChild(this.tweetInputField);

            // Tweet button
            this.tweetButton = new Sprite();
            var tweetButtonText:TextField = new TextField();
            tweetButtonText.width = 480;
            tweetButtonText.height = 20;
            tweetButtonText.background = true;
            tweetButtonText.backgroundColor = 0xc0c0c0;
            tweetButtonText.border = true;
            tweetButtonText.text = "Tweet";
            this.tweetButton.addChild(tweetButtonText);
            this.tweetButton.y = 340;
            this.tweetButton.buttonMode = true;
            this.tweetButton.mouseChildren = false;
            this.addChild(this.tweetButton);
            this.tweetButton.addEventListener(MouseEvent.CLICK, onTweetButtonClick);

            this.outputConsole.appendText("1. Click \"open browser\" button\n2. Authorize the app and get PIN\n3. Input PIN\n4. Get access tokens\n5. Tweet!\n");
        }
        
        // When the "open browser" button is clicked
        private function onOpenBrowserButtonClick(event:MouseEvent):void
        {
            var request:TwitterRequest = this.twitter.oauth_requestToken();

            request.addEventListener(TwitterRequestEvent.COMPLETE, onOAuthRequestTokenComplete);
            request.addEventListener(TwitterErrorEvent.CLIENT_ERROR, onOAuthRequestTokenError);
            request.addEventListener(TwitterErrorEvent.SERVER_ERROR, onOAuthRequestTokenError);
            this.outputConsole.appendText("Please wait...\n");
        }

        // When oauth/request_token is complete
        private function onOAuthRequestTokenComplete(event:TwitterRequestEvent):void
        {
            (event.target as TwitterRequest).removeEventListener(TwitterRequestEvent.COMPLETE, onOAuthRequestTokenComplete);
            (event.target as TwitterRequest).removeEventListener(TwitterErrorEvent.CLIENT_ERROR, onOAuthRequestTokenError);
            (event.target as TwitterRequest).removeEventListener(TwitterErrorEvent.SERVER_ERROR, onOAuthRequestTokenError);

            // Open the authorization page in browser
            navigateToURL(new URLRequest(this.twitter.getOAuthAuthorizeURL()));

            this.outputConsole.appendText("Borwser opened: " + this.twitter.getOAuthAuthorizeURL() + "\n");
        }

        // When oauth/request_token failed
        private function onOAuthRequestTokenError(event:TwitterErrorEvent):void
        {
            (event.target as TwitterRequest).removeEventListener(TwitterRequestEvent.COMPLETE, onOAuthRequestTokenComplete);
            (event.target as TwitterRequest).removeEventListener(TwitterErrorEvent.CLIENT_ERROR, onOAuthRequestTokenError);
            (event.target as TwitterRequest).removeEventListener(TwitterErrorEvent.SERVER_ERROR, onOAuthRequestTokenError);

            this.outputConsole.appendText("Error: " + event.statusCode.toString() + "\n");
        }

        // When the "access token" button is clicked
        private function onGetAccessTokenButtonClick(event:MouseEvent):void
        {
            // Send PIN
            var request:TwitterRequest = this.twitter.oauth_accessToken(this.pinInputField.text);

            request.addEventListener(TwitterRequestEvent.COMPLETE, onOAuthAccessTokenComplete);
            request.addEventListener(TwitterErrorEvent.CLIENT_ERROR, onOAuthAccessTokenError);
            request.addEventListener(TwitterErrorEvent.SERVER_ERROR, onOAuthAccessTokenError);

            this.outputConsole.appendText("Please wait...\n");
        }

        // When oauth/access_token is complete
        private function onOAuthAccessTokenComplete(event:TwitterRequestEvent):void
        {
            (event.target as TwitterRequest).removeEventListener(TwitterRequestEvent.COMPLETE, onOAuthAccessTokenComplete);
            (event.target as TwitterRequest).removeEventListener(TwitterErrorEvent.CLIENT_ERROR, onOAuthAccessTokenError);
            (event.target as TwitterRequest).removeEventListener(TwitterErrorEvent.SERVER_ERROR, onOAuthAccessTokenError);

            this.pinInputField.text = "";

            // Output the access token to the console
            this.outputConsole.appendText("Access token: " + this.twitter.accessToken + "\n");
            this.outputConsole.appendText("Access token secret: " + this.twitter.accessTokenSecret + "\n");
        }

        // When oauth/access_token failed
        private function onOAuthAccessTokenError(event:TwitterErrorEvent):void
        {
            (event.target as TwitterRequest).removeEventListener(TwitterRequestEvent.COMPLETE, onOAuthAccessTokenComplete);
            (event.target as TwitterRequest).removeEventListener(TwitterErrorEvent.CLIENT_ERROR, onOAuthAccessTokenError);
            (event.target as TwitterRequest).removeEventListener(TwitterErrorEvent.SERVER_ERROR, onOAuthAccessTokenError);

            this.outputConsole.appendText("Error: " + event.statusCode.toString() + "\n");
        }

        // When the tweet button is clicked
        private function onTweetButtonClick(event:MouseEvent):void
        {
            // Send tweet
            var request:TwitterRequest = this.twitter.statuses_update(this.tweetInputField.text);

            request.addEventListener(TwitterRequestEvent.COMPLETE, onStatusesUpdateComplete);
            request.addEventListener(TwitterErrorEvent.CLIENT_ERROR, onStatusesUpdateError);
            request.addEventListener(TwitterErrorEvent.SERVER_ERROR, onStatusesUpdateError);

            this.outputConsole.appendText("Please wait...\n");
        }

        // When tweet succeeded
        private function onStatusesUpdateComplete(event:TwitterRequestEvent):void
        {
            (event.target as TwitterRequest).removeEventListener(TwitterRequestEvent.COMPLETE, onStatusesUpdateComplete);
            (event.target as TwitterRequest).removeEventListener(TwitterErrorEvent.CLIENT_ERROR, onStatusesUpdateError);
            (event.target as TwitterRequest).removeEventListener(TwitterErrorEvent.SERVER_ERROR, onStatusesUpdateError);

            this.tweetInputField.text = "";
            
            this.outputConsole.appendText("Tweeted!\n");
        }

        // When tweet failed
        private function onStatusesUpdateError(event:TwitterErrorEvent):void
        {
            (event.target as TwitterRequest).removeEventListener(TwitterRequestEvent.COMPLETE, onStatusesUpdateComplete);
            (event.target as TwitterRequest).removeEventListener(TwitterErrorEvent.CLIENT_ERROR, onStatusesUpdateError);
            (event.target as TwitterRequest).removeEventListener(TwitterErrorEvent.SERVER_ERROR, onStatusesUpdateError);
            
            this.outputConsole.appendText("Error: " + event.statusCode.toString() + "\n");
        }
    
    }
    
}
