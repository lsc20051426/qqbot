<?php

$q = $_GET['q'];
echo res_from_simsimi($q, "ch");

function res_from_simsimi($q, $lan){
    $ch = curl_init ("http://www.simsimi.com/talk.htm?lc=ch");
    curl_setopt ($ch, CURLOPT_RETURNTRANSFER, true);
    $http_headers = array(
        "Accept:text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
        "Accept-Encoding:gzip, deflate, sdch",
        "Accept-Language:en-US,en;q=0.8,zh-CN;q=0.6,zh;q=0.4,zh-TW;q=0.2",
        "Connection:keep-alive",
        "Host:www.simsimi.com",
        "User-Agent:Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.93 Safari/537.36",
    );
    curl_setopt ($ch, CURLOPT_COOKIESESSION, TRUE);
    curl_setopt ($ch, CURLOPT_HTTPHEADER, $http_headers);
    curl_setopt ($ch, CURLOPT_HEADER, 1);
    $result = curl_exec($ch);

    // get cookie
    $start = strpos($result, "Set-Cookie: sid=");
    $end = strpos($result, "Path=/; HttpOnly");
    $sid = substr($result, $start+16, $end-$start-16);
    curl_close($ch);

    $content = json_decode(file_get_contents("http://www.simsimi.com/func/register"));
    $simi_uid = $content->uid;

    /* STEP 3. http headers */
    $http_headers = array(
        "Accept:application/json, text/javascript, */*; q=0.01",
        "Accept-Encoding:gzip, deflate, sdch",
        "Accept-Language:en-US,en;q=0.8,zh-CN;q=0.6,zh;q=0.4,zh-TW;q=0.2",
        "Connection:keep-alive",
        "Content-Type:application/json; charset=utf-8",
        "Cookie:sid={$sid} lang=zh_CN; Filtering=1.0; simsimi_uid={$simi_uid}; menuType=web; selected_nc=ch; ",
        "Host:www.simsimi.com",
        "Referer:http://www.simsimi.com/talk.htm?lc=ch",
        "User-Agent:Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.93 Safari/537.36",
        "X-Requested-With:XMLHttpRequest"
    );
    /* STEP 4. visit cookiepage.php */

    $keyword = urlencode(urlencode($q));
    $reqUrl = "http://www.simsimi.com/func/reqN?lc=ch&ft=1.0&req={$keyword}&fl=http%3A%2F%2Fwww.simsimi.com%2Ftalk.htm%3Flc%3Dch";

    $ch = curl_init ($reqUrl);
    #curl_setopt ($ch, CURLOPT_COOKIEFILE, $ckfile);
    curl_setopt ($ch, CURLOPT_HTTPHEADER, $http_headers);
    curl_setopt ($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt ($ch, CURLOPT_HEADER, 0);
    $output = curl_exec ($ch);
    curl_close($ch);
    $res = json_decode($output);
    return $res->sentence_resp;
}

?>
