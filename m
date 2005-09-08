Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbVIHTzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbVIHTzU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 15:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbVIHTzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 15:55:20 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:34577 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S964969AbVIHTzT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 15:55:19 -0400
Message-ID: <4320989E.3080603@tmr.com>
Date: Thu, 08 Sep 2005 16:01:34 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS
References: <35547.10.10.10.10.1125892279.squirrel@linux1> <20050905040311.29623.qmail@web50204.mail.yahoo.com> <50570.10.10.10.10.1125893576.squirrel@linux1> <20050905043613.GD30279@alpha.home.local>
In-Reply-To: <20050905043613.GD30279@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Hi,
> 
> On Mon, Sep 05, 2005 at 12:12:56AM -0400, Sean wrote:
> 
>>On Mon, September 5, 2005 12:03 am, Alex Davis said:
>>
>>>What if you don't have a choice? When someone comes to me with their
>>>laptop
>>>containing a built-in wireless card not natively supported by Linux, am I
>>>supposed to tell them "go buy a Linux-supported card" when there's a way
>>>I can make their existing card work? I don't think so.
>>
>>You always have a choice in life.  Nobody is stopping you from doing what
>>_you_ choose to do.  That doesn't mean that developers who are concerned
>>with the creation and promotion of open source should care one whit about
>>your particular take on the situation.   Go do whatever you want just
>>don't expect the open source developers to pay for it; you maintain the
>>crufty patches yourself.
> 
> 
> Well, to be fair, most laptop users today are in companies which provide
> them with the model the staff has chosen for all the employees. And employees
> try to install Linux on them anyway. That's how you end up with things like
> ndiswrapper, because the people who make those notebooks for companies don't
> care at all about their customers ; what they want is negociate with the
> staff to sell them 2000 laptops, and that's all.
> 
> However, those employees generally start with "easy to install" distros,
> such as fedora or similar. Those don't ship with standard kernels anyway,
> and they provide what is necessary to stay compatible with the tools which
> support crappy hardware. So (and it's sad), all those people don't care at
> all about kernel development, nor do they care about 2.6.13, 2.6.14, etc...
> 
> It's just *us* who tell them "ah, you can't do that because you use a
> prehistorical kernel, let me install you the last one", and then and only
> then, that fails and we whine about the crappy hardware and the "easy to
> install" distro which seem to be made to work together.
> 
> So I tend to consider that ndiswrapper users won't care about what will
> be in 2.6.14, but only about the fact that *their distro* will still
> support ndiswrapper. Of course, it would have been easier if the kernel
> would have stabilized and was only in maintenance mode, not breaking
> anything on every new release, but Linus has decided differently, so be
> it. Those users did not have a choice in the beginning, otherwise they
> would have chosen a laptop supported by Linux. And honnestly, I know
> plenty of them. In fact, it's the other way around. I know very few
> people who can actually choose their laptop.

And in many cases there is a cost difference between the Linux 
compatible unit and what's on sale with every feature you want but the 
supported wireless. And since a fair number of nice machines come with a 
single slot, adding a card is not always an option, there may be 
something else there.

If the machine which runs Linux costs anywhere near the cost of a 
Windows license, whoever pays the bills has a real incentive to turn to 
the dark side.
> 
> So you're both half-right from your point of view. But you're both half-wrong
> too : no, people can't always choose, and no, people who don't choose their
> laptop are not impacted by development kernels. So let's turn the page and
> wait for a stable kernel.

It appears that Linus has decided that there are not going to be any 
such from kernel.org. That's a bad thing for users, to choose between 
obsolete and stable, but it's his kernel.

I wouldn't go shouting "fork" so loud, a major fork would kill Linux as 
dead as BSD, a family of neat operating systems, none of which is widely 
used the way Linux is, and which are compatible with each other mainly 
at the acronym level, all are called BSD.

Question: does colinux get around all this crap by using the Windows 
drivers and running in essentially microkernel mode? Windows as the new 
NDISwrapper ;-)

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
