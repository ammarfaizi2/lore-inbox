Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbTJJNGe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 09:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbTJJNGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 09:06:33 -0400
Received: from 209-123-183-81.site5.com ([209.123.183.81]:29162 "EHLO
	suna.site5.com") by vger.kernel.org with ESMTP id S262608AbTJJNG2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 09:06:28 -0400
Message-ID: <3F86D1C9.10003@4-sms.com>
Date: Fri, 10 Oct 2003 18:35:37 +0300
From: SMS WebMaster <sms@4-sms.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030819
X-Accept-Language: en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       linux-config@vger.kernel.org, linux-userfs@vger.kernel.org
Subject: Re: mount: / mounted already or bad option
References: <3F86C17A.8060209@4-sms.com> <20031010125052.GB7202@alpha.home.local>
In-Reply-To: <20031010125052.GB7202@alpha.home.local>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - suna.site5.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - 4-sms.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Fri, Oct 10, 2003 at 05:26:02PM +0300, SMS WebMaster wrote:
> 
>> Hi
>>I have Gentoo linux in my PC
>>I just installed the kernel 2.4.22 and compile it and install it (using 
>>genkernel command)
>>Right now if I reboot my PC with my new kernel I got :
>>mount: / mounted already or bad option
>>and the system stop and ask me to type the root password
>>and when I login with the root and type
>>mount -o remount,rw /
>>
>>I got the same message
>>mount: / mounted already or bad option
>>
>>but if I write
>>mount -o remount,rw /dev/hda4  /
>>then the root filesystem if remounted as read/write
> 
> 
> wouldn't your /etc/mtab be a link to /proc/self/mounts with /proc not mounted ?


Sorry what do you mean ?

if I type mount I can see that proc is mounted (I can even see / is 
mounted as read/write but its not realy mounted as read/write)


> 
> Willy
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-userfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 




-- 
http://www.4-SMS.Com
http://eShop.4-SMS.Com
http://Mozilla.4-SMS.Com
-*- If Linux doesn't have the solution, you have the wrong problem -*-

