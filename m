Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132660AbRDKRHN>; Wed, 11 Apr 2001 13:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132672AbRDKRHC>; Wed, 11 Apr 2001 13:07:02 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:27150 "HELO
	mail11.speakeasy.net") by vger.kernel.org with SMTP
	id <S132660AbRDKRGw>; Wed, 11 Apr 2001 13:06:52 -0400
Message-ID: <3AD48F4F.1000800@megapathdsl.net>
Date: Wed, 11 Apr 2001 10:07:27 -0700
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-ac2 i686; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 module development mailing list needed?  [Fwd: Linux Security Module Interface]
In-Reply-To: <3AD3C1CC.D6167000@megapathdsl.net> <20010411122000.H805@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:

> On Tue, Apr 10, 2001 at 07:30:36PM -0700, Miles Lane wrote:
> 
>> Hi,
>> 
>> 	acpi@phobos.fs.tum.de
>> 	linux-hotplug-devel@lists.sourceforge.net
>> 	linux-power@phobos.fs.tum.de
>> 	linux-security-module@wirex.com
>> 	LKML
>> 
>> Comments?
> 
> 
> 	Proper place to do this discussion is linux-kernel@vger.kernel.org

It sounds good in theory.  In practice, though, almost all of the
design discussions have been occuring in private e-mail.
For example, I have seen none of the messages discussing
the changes planned for the power management stuff in 2.5,
even though these changes will apparantly touch every single
modular driver.  I know for a fact that the changes planned
to enable better implementation of PCMCIA support have
gone on between only a few developers.  Also, from the
announcement from the Security Module folks, I gather that
there discussions haven't been held on LKML and aren't
planned to migrate here.

So, if you really think that all these module-related design
discussions should happen on LKML, we're going to have
to convince a bunch of people to move their discussions
here.  This will not necessarily be easy.  I know that the
reason that many of these discussions occur between only
a few people is that these folks want a decent signal to
noise ratio.  That's why I proposed a "2.5-module-devel"
list.  It would allow people who really care about this stuff
to coordinate their work.


> 	The amount of traffic won't probably be very high in comparison
> 	to the average flow (150-250 emails per day at peak) of L-K.

Well, I'd say it's more like 250-750/day.  :-)


> 	The more you split things around, the less the people who really
> 	need to follow it up can follow it.

Well, there are probably two sets of audiences.  The initial design
teams, who need to collaborate and the modular driver developers.
The driver developers could come into the loop later, if they please.
Although there would be value in their contribution earlier on.


> 	As this is free world, nothing prevents you from going ahead and
> 	creating some linux-25@xyz list somewhere.     Just don't expect
> 	everybody to rush into it.

Well, I'll do that, if a few people say they'll move their design
discussions there and out of private e-mail and other lists.

>> 	Miles
> 
> 
> /Matti Aarnio


