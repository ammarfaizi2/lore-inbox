Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbTKUGUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 01:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264319AbTKUGUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 01:20:30 -0500
Received: from [203.59.3.42] ([203.59.3.42]:10899 "HELO mail.iinet.net.au")
	by vger.kernel.org with SMTP id S264308AbTKUGUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 01:20:24 -0500
Message-ID: <3FBDAE99.9050902@cyberone.com.au>
Date: Fri, 21 Nov 2003 17:20:09 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Markus_H=E4stbacka?= <midian@ihme.org>
CC: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Nick's scheduler v19a
References: <3FB62608.4010708@cyberone.com.au>	 <1069361130.13479.12.camel@midux>  <3FBD4F6E.3030906@cyberone.com.au> <1069395102.16807.11.camel@midux>
In-Reply-To: <1069395102.16807.11.camel@midux>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Markus Hästbacka wrote:

>Hi nick.
>it seems that this patch changed everything, I patched against
>2.6.0-test9-bk19. I didn't upgrade any software before I booted to your
>patch. and I tested the 2.6.0-test9-bk22 without the patch it worked
>just as all other kernels without the patch. I've had the same .config
>from test3 (maybe some small changes if new drivers appeared).
>
>I can't say that 2.6 performance is bad, it's better than 2.4, but now
>this is even better. 
>
>So now I'm booted back to your patch and I like this difference in X
>performance, I can't ask for more. :)
>

Well that's very good to hear :) err, just remember if you have
any specific problems with unpatched 2.6 to make a report. We
want the standard scheduler to run well too.

Thanks,
Nick

>
>Regards,
>
>Markus
>On Fri, 2003-11-21 at 01:34, Nick Piggin wrote:
>
>>Markus Hästbacka wrote:
>>
>>
>>>Hi nick! here's some feedback.
>>>This one day last week, I thougt I could test your scheduler patch.
>>>I noticed something really good with it. My X had really fast startup.
>>>everything worked really fast. Even games worked much better than any in
>>>kernel before (I've tested all from 2.5.74).
>>>
>>>So I hope you'll port this patch for test10> if this one wont patch
>>>clearly.
>>>
>>>
>>Hi Markus,
>>Thanks for testing. That sounds quite remarkable, is it possible that
>>some other change has made the difference? What kernel version did
>>you patch against, and did you try that same kernel and .config without
>>my patch? Anyway, I'm glad you're having good results.
>>
>>Yes, this one will probably apply to test10 should it ever apper. If not
>>I will port it.
>>
>>Nick
>>    
>>

