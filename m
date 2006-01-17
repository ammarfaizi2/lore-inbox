Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWARFgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWARFgF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 00:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWARFgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 00:36:04 -0500
Received: from zeus2.kernel.org ([204.152.191.36]:63953 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S1030254AbWARFgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 00:36:03 -0500
Message-ID: <43CD309A.3030704@m1k.net>
Date: Tue, 17 Jan 2006 12:59:54 -0500
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: webmaster@kernel.org, lkml <linux-kernel@vger.kernel.org>,
       Michael Krufky <mkrufky@gmail.com>
Subject: Re: [KORG] GITWEB doesn't show any DIFF's
References: <43CCF8BB.1050009@m1k.net> <200601171739.17168.s0348365@sms.ed.ac.uk>
In-Reply-To: <200601171739.17168.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:

>On Tuesday 17 January 2006 14:01, Michael Krufky wrote:
>  
>
>>To Whom (and ALL) that it may concern:
>>
>>For the past week or so, I haven't been able to get gitweb, running on
>>kernel.org, to show me any diff's.
>>
>>For each commit, if I click on the "commit" link, or "commitdiff" link,
>>the best I get is something that looks like this:
>>
>>file:fd8bc718f0e33df0a446d3d5c67f68929eca6490
>><http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blo
>>b;h=fd8bc718f0e33df0a446d3d5c67f68929eca6490;hb=e0ad8486266c3415ab9c17f5c03c
>>47edc7b93d7b;f=drivers/media/video/cx88/cx88-alsa.c> ->
>>file:e649f678d47ab0a749b89146867ff9b1f513f73a
>><http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blo
>>b;h=e649f678d47ab0a749b89146867ff9b1f513f73a;hb=e0ad8486266c3415ab9c17f5c03c
>>47edc7b93d7b;f=drivers/media/video/cx88/cx88-alsa.c>
>>
>>This is for "V4L/DVB (3375): git dvb callbacks fix" , but it happens for
>>every patch I try to view...  Even if I try to view the patch in "plan"
>>mode, the following is all that I can see:
>>
>>From: Andrew Morton <akpm@osdl.org>
>>Date: Sun, 15 Jan 2006 08:45:20 +0000 (-0200)
>>Subject: V4L/DVB (3375): git dvb callbacks fix
>>X-Git-Tag: v2.6.16-rc1
>>X-Git-Url:
>>http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=comm
>>itdiff;h=e0ad8486266c3415ab9c17f5c03c47edc7b93d7b
>>
>>V4L/DVB (3375): git dvb callbacks fix
>>
>>- Not sure what went wrong here, but SND_PCI_PM_CALLBACKS got deleted.
>>
>>Signed-off-by: Andrew Morton <akpm@osdl.org>
>>Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
>>---
>>
>>(I havent seen this patch, and I'm really curious what happens in it,
>>and the explanation of the commit message -- these questions are
>>probably answered simply by viewing the patch, which I cant do :-(  )
>>
>>... I have tried this at multiple locations, using several different
>>browsers under different OS's ... It won't show me a diff no matter what
>>I do, and it USED to work (about a week ago)
>>
>>I'm surprised nobody has complained about this already.  (or maybe I
>>just didnt see any such thread about it)
>>    
>>
>
>Seems to work for me right _now_, could you verify that this is still 
>happening?
>
>  
>
I confirm, that nothing has changed...... Once again, no matter what OS, 
no matter what browser, no matter which location I am sitting at, I see 
no diff.

Thanks,

Michael Krufky


