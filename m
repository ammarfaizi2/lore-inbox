Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbULBAL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbULBAL0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 19:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbULBAGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 19:06:51 -0500
Received: from mproxy.gmail.com ([216.239.56.240]:23659 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261524AbULBAEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 19:04:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:return-path:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=QkH2/1+FffJYYrqsgys1Igk0sP2oD9W1hBCyIiBKQ1HZ0anEPrt3Z/3VmvUYlJvmvqI6GjN8Es9IgIMjxfoGrhBwIiz9+GVb5zzdykWOYJNMpLGKoO7TdfN/ukqtSgSl/rS0DlFlcYCMncKnxcUZFWu2+1XWK86bYXsCrxVKyIQ=
Message-ID: <41AE5BF8.3040100@gmail.com>
Date: Thu, 02 Dec 2004 05:34:08 +0530
From: Imanpreet Singh Arora <imanpreet@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: What if?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,
   
    Firstly I have read the FAQ. So though FAQ answers my question, it 
does so only partially.


    "What if Linux were to be implemented in C++?"


    I realize most of the unhappiness lies with C++ compilers being 
slow. Also the fact that a lot of Hackers around here are a lot more 
familiar with C, rather than C++. However other than that what are the  
_implementation_  issues that you hackers might need to consider if it 
were to be implemented in C++. My question is regarding how will kernel 
deal with C++ doing too much behind the back, Calling constructors, 
templates exceptions and other. What are the possible issues of such an 
approach while writing device drivers?  What sort of modifications do 
you reckon might be needed if such a move were to be made?




-- 
Imanpreet Singh Arora

Even if you are on the right track you are going to get runover if you just sit there.
	-- Will Rogers

