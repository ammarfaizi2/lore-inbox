Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275022AbTHGAcv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 20:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275025AbTHGAcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 20:32:50 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:18704 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S275022AbTHGAbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 20:31:11 -0400
Message-ID: <3F31A0D1.8060501@techsource.com>
Date: Wed, 06 Aug 2003 20:44:01 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Nick Piggin <piggin@cyberone.com.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O13int for interactivity
References: <200308050207.18096.kernel@kolivas.org> <3F2F87DA.7040103@cyberone.com.au> <3F31741F.30200@techsource.com> <200308070733.38135.kernel@kolivas.org> <3F319D0E.30307@techsource.com> <1060216038.3f319ce652393@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:
> Quoting Timothy Miller <miller@techsource.com>:
> 
> 
>>
>>Con Kolivas wrote:
>>
>>>>For this, I reiterate my suggestion to intentionally over-shoot the
>>>>mark.  If you do it right, a process will run an inappropriate length of
>>>>time only every other time slice until the oscillation dies down.
>>>
>>>
>>>Your thoughts are fine, and to some degree I do what you're proscribing,
>>
>>but I 
>>
>>>take into account the behaviour of real processes in the real world and
>>
>>their 
>>
>>>effect on scheduling fairness.
>>
>>And I know you know a lot more about how real processes behave than I 
>>do.  I'm not saying (or thinking) anything negative about you.  I'm just 
>>trying to throw random thoughts into the mix just in case some small 
>>part of what I say is useful inspiration for someone else such as yourself.
>>
>>It is probably the case that the idea I suggest is BS and makes no real 
>>difference or makes it worse anyhow.  :)
> 
> 
> Nowhere do I recall saying your ideas were BS nor did I say you should stop 
> throwing ideas at me. All thoughts are appreciated and considered. I'm pretty 
> sure I said I do what you're suggesting anyway, bound by the limits of when 
> those changes induce unfairness.

Oh, no, you have always been most gratious and kind!  _I_ was saying 
that my idea (or at least certain aspects of it) is probably BS.  But 
some aspects of it may be useful (upon reflection and with 
modification), and it would seem that you have already thought of and 
implemented those things, so I am very pleased.  :)


