Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264842AbSLRQ6s>; Wed, 18 Dec 2002 11:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264962AbSLRQ6s>; Wed, 18 Dec 2002 11:58:48 -0500
Received: from zeke.inet.com ([199.171.211.198]:64664 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S264842AbSLRQ6q>;
	Wed, 18 Dec 2002 11:58:46 -0500
Message-ID: <3E00AB22.4020902@inet.com>
Date: Wed, 18 Dec 2002 11:06:42 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Dave Jones <davej@codemonkey.org.uk>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: Freezing.. (was Re: Intel P6 vs P7 system call performance)
References: <Pine.LNX.4.44.0212180844550.29852-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 18 Dec 2002, Dave Jones wrote:
> 
>>On Wed, Dec 18, 2002 at 10:40:24AM -0300, Horst von Brand wrote:
>> > [Extremely interesting new syscall mechanism tread elided]
>> >
>> > What happened to "feature freeze"?
>>
>>*bites lip* it's fairly low impact *duck*.
> 
> 
> However, it's a fair question.
> 
> I've been wondering how to formalize patch acceptance at code freeze, but
> it might be a good idea to start talking about some way to maybe put
> brakes on patches earlier, ie some kind of "required approval process".
> 
> I think the system call thing is very localized and thus not a big issue,
> but in general we do need to have something in place.
> 
> I just don't know what that "something" should be. Any ideas? I thought
> about the code freeze require buy-in from three of four people (me, Alan,
> Dave and Andrew come to mind) for a patch to go in, but that's probably
> too draconian for now. Or is it (maybe start with "needs approval by two"
> and switch it to three when going into code freeze)?

Well, Linus, you're not the most conservative when it comes to freezes. 
   (Hey! Watch it with those thunderbolts!)  Alan, on the other hand, I 
would trust to be pretty conservative.
I'm afraid I haven't followed Dave & Andrew well enough in that light.

But my question is... if 2 are required, and say, Dave is as slushy on 
freezes as you are, then have we gained much?

Perhaps 2 of 4 approve with no dissenting votes?

If Dave and Andrew are relatively conservative on freezes, then this 
concern is sufficiently addressed already.

Food for thought from a relative nobody. ;)

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

