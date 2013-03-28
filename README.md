Twitter-for-AS3
===============

TwitterAPIをActionScript3で叩くための何かです。

#注意
* 非公式です。Twitter社にこれについて問い合わせるなどしないでください。
* 別途as3crypto(http://code.google.com/p/as3crypto/)を使用可能にしておいて下さい。

#使い方
1.
https://dev.twitter.com/ にTwitterのアカウントでログイン後、consumer keyとconsumer key secretを取得します。  
（詳しくはぐぐれば出てくるでしょう）

2.
Twitterクラスをインスタンス化します

    var twitter:Twitter=new Twitter("<consumer key>","<consumer key secret>");

3.
request token及びrequest token secretを取得します

    var rtRequest:TwitterRequest=twitter.oauth_requestToken();

このとき、rtRequestにTwitterRequestEvent.COMPLETEのイベントリスナーを付加します  
イベント送出後、twitter.getOAuthAuthorizeURL()で認証用URLが取得できます  
認証用ページでPINコードを取得します

4.
access token及びaccess token secretを取得します

    var atRequest:TwitterRequest=twitter.oauth_accessToken(pin);

verifierに取得したPINコードを渡します  
atRequestがTwitterRequestEvent.COMPLETEイベントを送出後、他のAPIを操作できるようになります

5.
試しに何か投稿してみましょう
  
    twitter.statuses_update("アボカドおいしいです");

6.
access token及びaccess token secretが予め取得できている場合、最初にインスタンス化したときに引数に渡すことができます
  
    var twitter:Twitter=new Twitter("<consumer key>","<consumer key secret>","<access token>","<access token secret>");

このようにすることで直後からAPIを操作出来ます

7.
実装状況は/api/TwitterURL.asの中身を見て察しましょう  
細かい部分はhttps://dev.twitter.com/docs/api/1.1とTwitter.asや/api内のファイルを見比べながら適当にやってください
