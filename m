Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbULOLta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbULOLta (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 06:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbULOLt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 06:49:29 -0500
Received: from mail.outpost24.com ([212.214.12.146]:19671 "EHLO
	klippan.outpost24.com") by vger.kernel.org with ESMTP
	id S262335AbULOLtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 06:49:24 -0500
Message-ID: <41C024B0.4010009@outpost24.com>
Date: Wed, 15 Dec 2004 12:49:04 +0100
From: David Jacoby <dj@outpost24.com>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel IGMP vulnerabilities, PATCH IS BROKEN!
References: <41BFF931.6030205@outpost24.com> <20041215.180839.93043538.yoshfuji@linux-ipv6.org>
In-Reply-To: <20041215.180839.93043538.yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Anyone else tried to apply this patch? The patch does work but not 
properly.
I guess the machie is secure against the DoS attack but after i 
installed the patch
i cant use SSH.When i tryed to SSH i didnt get any password prompt.


user@autopsia:~$ ssh user@192.168.0.1
Permission denied, please try again.
Permission denied, please try again.
Permission denied (publickey,password,keyboard-interactive).

The patch will crash SSH :|

//David


YOSHIFUJI Hideaki wrote:

>In article <41BFF931.6030205@outpost24.com> (at Wed, 15 Dec 2004 09:43:29 +0100), David Jacoby <dj@outpost24.com> says:
>
>  
>
>>Any advice about how people can patch this security issue?
>>    
>>
>
>http://linux.bkbits.net:8080/linux-2.6/cset@41bf39b1RGfvOMInGewwDyzfcuL2OQ
>
>--yoshfuji
>
>  
>


-- 
Outpost24 AB

David Jacoby
Research & Development

Office: +46-455-612310
Mobile: +46-455-612311
(www.outpost24.com) (dj@outpost24.com) 

