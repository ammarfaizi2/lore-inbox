Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWGaOOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWGaOOm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 10:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWGaOOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 10:14:42 -0400
Received: from mail.tmr.com ([64.65.253.246]:12514 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S932284AbWGaOOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 10:14:41 -0400
Message-ID: <44CE13A7.5010206@tmr.com>
Date: Mon, 31 Jul 2006 10:28:55 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Hua Zhong <hzhong@gmail.com>, "'Rafael J. Wysocki'" <rjw@sisk.pl>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: suspend2 merge history [was Re: the " 'official' point of view"
 expressed by kernelnewbies.org regarding reiser4 inclusion]
References: <200607300054.18231.rjw@sisk.pl> <00c801c6b427$20d545d0$0200a8c0@nuitysystems.com> <20060730230757.GA1800@elf.ucw.cz>
In-Reply-To: <20060730230757.GA1800@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>On Sun 2006-07-30 15:25:49, Hua Zhong wrote:
>  
>
>>>I don't _blame_ drivers.  I only wanted to say this: "If 
>>>Nigel knows that some drivers need to be fixed and he has 
>>>working fixes for these drivers, he should have submitted 
>>>these fixes for merging instead of just keeping them in 
>>>suspend2".  Period.
>>>
>>>If I know of a fix for a driver, I always do my best to make 
>>>sure the fix will get considered for merging at least.  The 
>>>problem is I'm not a driver expert and I can't provide the 
>>>fixes myself.
>>>      
>>>
>>Suspend2 patch is open source. You can always take a look.
>>    
>>
>
>swsusp is open source. You can always take a look. And you can always
>submit a patch.
>  
>
But you can't get the patch accepted, that's issue causing all this 
discussion.

>>Moreover, if someone claims suspend2 isn't ready for merge, or the
>>    
>>
>
>Moreover, if someone claims swsusp is broken, they should attach
>bugzilla id.
>
>  
>
>>I'm not exactly an expert, but I don't think suspend-to-ram is more
>>difficult than suspend-to-disk (probably quite the contrary), and
>>there are a lot in common.
>>    
>>
>
>As you said, you do not know what you are talking about.
>
>  
>
That's why people are frustrated. You blow off anyone who tells you the 
code doesn't work. Do you really think Linus doesn't know what he's 
talking about when he reported that it didn't work for him? Hua Zhong 
being "Not an expert" is not the same as not knowing what he's talking 
about.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

