Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVBONhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVBONhU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 08:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVBONhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 08:37:20 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:3844 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261720AbVBONhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 08:37:05 -0500
Message-ID: <4211FB8B.5000307@aitel.hist.no>
Date: Tue, 15 Feb 2005 14:39:23 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: kernel <kernel@crazytrain.com>, Larry McVoy <lm@bitmover.com>,
       Matthew Jacob <lydianconcepts@gmail.com>,
       Jeff Sipek <jeffpc@optonline.net>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK] upgrade will be needed
References: <20050214020802.GA3047@bitmover.com>  <58cb370e05021404081e53f458@mail.gmail.com>  <20050214150820.GA21961@optonline.net> <20050214154015.GA8075@bitmover.com>  <7579f7fb0502141017f5738d1@mail.gmail.com>  <20050214185624.GA16029@bitmover.com> <1108469967.3862.21.camel@crazytrain> <Pine.LNX.4.61.0502150732110.9562@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0502150732110.9562@chaos.analogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:

> On Tue, 15 Feb 2005, kernel wrote:
>
>> On Mon, 2005-02-14 at 13:56, Larry McVoy wrote:
>>
>>> All we are trying to do is
>>>
>>>     1.  Provide the open source community with a useful tool.
>>>     2.  Prevent that from turning into the open source community
>>>         creating a clone of our tool.
>>>
>>
>> lol
>>
>>
>>
>>> I agree that this sucks, having a license that restricts your 
>>> creativity
>>> is very annoying.  On the other hand, you don't have to agree to it.
>>
>>
>>
>> Just catching up on this thread.  I guess I'm ultimately surprised that
>> the developers here don't create a system *they* like with *their*
>> knowledge and skillsets.
>>
>> With all of the complaining about BK you'd think there'd be an equal
>> alternative.
>>
>> For everyone not liking Larry nor BK, why don't you use that as
>> inspiration to develop together a better app with terms more agreeable?
>> Surely that would put a bit of vinegar in his p*ss, wouldn't it?
>>
>> -fd
>
>
> I have two questions for Larry.
>
> (1) If I use BK for company source-code development (purchased
> product, I didn't buy it, the company did and they require
> me to use it for my work) and I go to work for another company
> that also uses BK, your license says I can't use BK at the other
> company, which means that I can't work there.

You can dislike the BK licencing all you want, but isn't there some 
misunderstandings here?
I believe you can _use_ any SCM-system you want whenever you want. Using 
bitkeeper in
one place does not prevent you from using it in another company also.  
Neither does using
any other SCM.

The limit lies in that you can't both use the *free* version of 
bitkeeper while also
*developing* some other SCM.  Note that the non-free bitkeeper, the one 
you pay for,
is licenced differently.   So if you use the *free* bitkeeper and some 
employer
want you to work developing another SCM, then you have these options:

1. Quit the job because you cannot legally do it while using the free 
bitkeeper.
2. Quit using the free bitkeeper, by switching to another SCM for that 
project.
3. Quit using the free bitkeeper by purchasing a commercial licence for 
bitkeeper instead.

So, you can have bitkeeper for free with a limiting license, or you can 
pay for an
unencumbered bitkeeper.  Or you can keep your money and not use bitkeeper,

>
> This is unlawful. How do you intend to enforce this?
>
> (2) If I use BK and I decide that I don't want to do business with
> you or the courts say that I have to return the software, will my
> source-code still be usable with, perhaps CVS? In other words
> do I need BK to retrieve my company's intellectual property?

I don't really see the problem here - if they tell you to cease and desist
using bitkeeper, then extract all your source first, before scrapping 
bitkeeper.
Then install some other SCM and get the source tree into that.  It is some
work of course, but not a rewrite!

> Note that there is a little company (was a big company until
> the lawsuit), that used VOBS (container files) to store source-
> code. Seems that when the license expired, the users couldn't get
> their source code out. There was a lawsuit. Company lost
> (of course). Seems you can't hold somebody's intellectual
> property for ransom, at least in the United States.

That's good.  It should mean that nobody can prevent you from switching
away from bitkeeper in an orderly fashion then.

Helge Hafting

