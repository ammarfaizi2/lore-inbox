Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVEKAAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVEKAAo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 20:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVEKAAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 20:00:44 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:26801 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261847AbVEJX7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 19:59:42 -0400
Message-ID: <42813CA7.2030002@comcast.net>
Date: Tue, 10 May 2005 18:58:47 -0400
From: Terry Vernon <tvernon24@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel (64bit) 4GB memory support
References: <Pine.LNX.4.61.0412120934160.14734@montezuma.fsmlabs.com>	 <1103027130.3650.73.camel@cpu0> <20041216074905.GA2417@c9x.org>	 <1103213359.31392.71.camel@cpu0>	 <Pine.LNX.4.61.0412201246180.12334@montezuma.fsmlabs.com>	 <1103646195.3652.196.camel@cpu0>	 <Pine.LNX.4.61.0412210930280.28648@montezuma.fsmlabs.com>	 <1103647158.3659.199.camel@cpu0>	 <Pine.LNX.4.61.0412210955130.28648@montezuma.fsmlabs.com>	 <1115654185.3296.658.camel@cpu10>	 <20050509200721.GE2297@csclub.uwaterloo.ca> <1115754522.4409.16.camel@cpu10>
In-Reply-To: <1115754522.4409.16.camel@cpu10>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"I do see the full 4G. With Fedora Core 2 32bit, I can use all

4G as well. All my problems started when I "upgraded" to x86_64 ..."

Are you using an old 32bit processor or a new 64bit processor? That would make a difference




Rudolf Usselmann wrote:

>On Mon, 2005-05-09 at 16:07 -0400, Lennart Sorensen wrote:
>  
>
>>On Mon, May 09, 2005 at 10:56:25PM +0700, Rudolf Usselmann wrote:
>>    
>>
>>>Just curious, did anybody ever look in to this at all ? I keep
>>>on downloading new kernels and trying 4GB of memory - still no
>>>luck.
>>>
>>>I did file a bug report but didn't get any notifications at all.
>>>I don't subscribe to the linux-kernel list so not sure if anything
>>>ever came up or not.
>>>
>>>Is there a way to get this fixed ?
>>>      
>>>
>>How much ram do you see with 4GB installed running a 64bit kernel?
>>
>>What does /proc/meminfo show?
>>
>>How about the memory map dmesg shows at the start of boot?
>>
>>Len Sorensen
>>    
>>
>
>I do see the full 4G. With Fedora Core 2 32bit, I can use all
>4G as well. All my problems started when I "upgraded" to x86_64 ...
>
>Best Regards,
>rudi
>=============================================================
>Rudolf Usselmann,  ASICS World Services,  http://www.asics.ws
>Your Partner for IP Cores, Design, Verification and Synthesis
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

