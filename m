Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132979AbRDKT6U>; Wed, 11 Apr 2001 15:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132978AbRDKT6D>; Wed, 11 Apr 2001 15:58:03 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:19724 "HELO
	mail12.speakeasy.net") by vger.kernel.org with SMTP
	id <S132973AbRDKT5l>; Wed, 11 Apr 2001 15:57:41 -0400
Message-ID: <3AD4B755.506@megapathdsl.net>
Date: Wed, 11 Apr 2001 12:58:13 -0700
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-ac2 i686; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: Matti Aarnio <matti.aarnio@zmailer.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 module development mailing list needed?  [Fwd: Linux Secu	rity Module Interface]
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE823@orsmsx35.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew wrote:

>>> 	Proper place to do this discussion is 
>> 
>> linux-kernel@vger.kernel.org
>> 
>> It sounds good in theory.  In practice, though, almost all of the
>> design discussions have been occuring in private e-mail.
>> For example, I have seen none of the messages discussing
>> the changes planned for the power management stuff in 2.5,
>> even though these changes will apparantly touch every single
>> modular driver.  I know for a fact that the changes planned
>> to enable better implementation of PCMCIA support have
>> gone on between only a few developers.  Also, from the
>> announcement from the Security Module folks, I gather that
>> there discussions haven't been held on LKML and aren't
>> planned to migrate here.
> 
> IMO, the non-LKML lists exist so that developers can go off and have long,
> boring, highly technical discussions without everyone having to wade through
> it. It's not private email, it's just another list. So, subscribe, or look
> at the archives. Most people don't care about this stuff, so the ones that
> do should opt-in to whatever list.

Yeah, agreed.  I was only concerned there might be folks working
at cross-purposes.  It looks like maybe I am wrong in thinking
this is concern.  Perhaps whatever changes are being contemplated
will be introduced gradually and really won't impact the same
areas of code and, thus, coordination isn't required.


>> So, if you really think that all these module-related design
>> discussions should happen on LKML, we're going to have
>> to convince a bunch of people to move their discussions
>> here.  This will not necessarily be easy.  I know that the
>> reason that many of these discussions occur between only
>> a few people is that these folks want a decent signal to
>> noise ratio.  That's why I proposed a "2.5-module-devel"
>> list.  It would allow people who really care about this stuff
>> to coordinate their work.
> 
> 
> I am not positive that your initial premise is entirely correct. For
> example, it's way too early to say definitively, but right now I don't see
> ACPI or power management requiring any changes to the module architecture.
> (Driver arch maybe, but not module arch)

Well, you'd certainly be in a much better position to know about this
than I am.  :-)


> So, maybe you should just copy the two lists (hotplug and security) in
> question?

Okay.  From this rather underwhelming response, I'm guessing that
a new list simply isn't going to be very helpful or interesting to the
pertinent developers.


Thanks for letting me know,

	Miles

