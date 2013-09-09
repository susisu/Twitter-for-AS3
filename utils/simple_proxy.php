<?php
/*
	Simple Proxy
	Copyright(C) 2013 Susisu
*/

$url = $_GET['url'];
if(!$url)
{
	echo 'url is not specified';
}
else
{
	$params = '';
	foreach($_GET as $key=>$val)
	{
		if($key != 'url')
		{
			$params .= "$key=" . urlencode($val) . "&";
		}
	}
	$ch = curl_init("$url?$params");
	if(strtolower($_SERVER['REQUEST_METHOD']) == 'post')
	{
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $_POST);
	}
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
	curl_setopt($ch, CURLOPT_HEADER, true);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($ch, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);
	list($header, $contents) = preg_split('/([\r\n][\r\n])\\1/', curl_exec( $ch ), 2);
	$headerStr = preg_split('/[\r\n]+/', $header);
	foreach($headerStr as $eachHeader)
	{
		if (preg_match('/^(?:Content-Type|Content-Language|Set-Cookie):/i', $eachHeader))
		{
			header($eachHeader);
		}
	}
	echo $contents;
}
