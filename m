Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbULOL53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbULOL53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 06:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbULOL53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 06:57:29 -0500
Received: from mail.outpost24.com ([212.214.12.146]:472 "EHLO
	klippan.outpost24.com") by vger.kernel.org with ESMTP
	id S262341AbULOL5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 06:57:19 -0500
Message-ID: <41C0268B.2030708@outpost24.com>
Date: Wed, 15 Dec 2004 12:56:59 +0100
From: David Jacoby <dj@outpost24.com>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel IGMP vulnerabilities, PATCH IS BROKEN!
References: <41BFF931.6030205@outpost24.com> <20041215.180839.93043538.yoshfuji@linux-ipv6.org> <41C024B0.4010009@outpost24.com> <200412151254.37612@WOLK>
In-Reply-To: <200412151254.37612@WOLK>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen wrote:

>On Wednesday 15 December 2004 12:49, David Jacoby wrote:
>
>  
>
>>Anyone else tried to apply this patch? The patch does work but not
>>properly.
>>I guess the machie is secure against the DoS attack but after i
>>installed the patch
>>i cant use SSH.When i tryed to SSH i didnt get any password prompt.
>>user@autopsia:~$ ssh user@192.168.0.1
>>Permission denied, please try again.
>>Permission denied, please try again.
>>Permission denied (publickey,password,keyboard-interactive).
>>The patch will crash SSH :|
>>    
>>
>
>without looking at the patch, I think this isn't the causer of the patch at 
>all.
>
>ciao, Marc
>
>  
>
Well it is, i booted on the old kernel and SSH worked perfect and then 
on the new kernel with the patch i cant SSH, i dont even
get an password prompt. I tried to ssh to more than one host aswell, i 
also removed the key in .known_hosts but it still doesnt work.

Have you installed the patch?

//David


-- 
Outpost24 AB

David Jacoby
Research & Development

Office: +46-455-612310
Mobile: +46-455-612311
(www.outpost24.com) (dj@outpost24.com) 

