Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265218AbUBIOAT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 09:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUBIOAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 09:00:19 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:43025 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S265218AbUBIOAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 09:00:13 -0500
Message-ID: <4027A07D.3080208@zvala.cz>
Date: Mon, 09 Feb 2004 15:00:13 +0000
From: Tomas Zvala <tomas@zvala.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed Tomlinson <edt@aei.ca>
Subject: Re: 2.6.2-mm1 xfs OOPS (when mounting root fs)
References: <40279532.2000502@zvala.cz> <200402090853.00930.edt@aei.ca>
In-Reply-To: <200402090853.00930.edt@aei.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ehm:(
I'm sorry, it just seemed to me like oops so i did not look for the 
"oops" word and treated it as oops. So I was searching for oopses in the 
lkml.
I'll triple check it says oops next time I'm gonna report any oopses (as 
much as I hope i won't see any:) ).

Tomas Zvala

Ed Tomlinson wrote:

>On February 09, 2004 09:12 am, Tomas Zvala wrote:
>  
>
>>Hello,
>>Well i hope i correctly identified lkml as the proper mailing list to 
>>report this.
>>I've got these oopses(oopses.txt attachment) when my XFS root filesystem 
>>gets mounted. Im also attaching my /proc/config.gz and xfs_info output.
>>If you need any more info let me know please.
>>    
>>
>
>And where in this does it say oops?   This is a debug trace.  It indicates a
>problem can could cause pain later - it is NOT an oops.
>
>lkml is the place to report it.  however, it is a good idea to search the archives 
>to see if its already known - in this case it definitly is.
>
>Ed
>
>  
>

