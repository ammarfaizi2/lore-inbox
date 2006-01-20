Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWATWJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWATWJg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 17:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWATWJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 17:09:36 -0500
Received: from free.wgops.com ([69.51.116.66]:26116 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S932228AbWATWJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 17:09:35 -0500
Date: Fri, 20 Jan 2006 15:09:07 -0700
From: Michael Loftis <mloftis@wgops.com>
To: Doug McNaught <doug@mcnaught.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
       dtor_core@ameritech.net, James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <25D702FB62516982999D7084@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <87slrio9wd.fsf@asmodeus.mcnaught.org>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
 	<43D10FF8.8090805@superbug.co.uk>
 	<6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>
 	<d120d5000601200850w611e8af8v41a0786b7dc973d9@mail.gmail.com>
 	<30D11C032F1FC0FE9CA1CDFD@d216-220-25-20.dynip.modwest.com>
 	<200601201903.k0KJ3qI7006425@turing-police.cc.vt.edu>
 	<E27F809F04C1C673D283E84F@d216-220-25-20.dynip.modwest.com>
 	<20060120200051.GA12610@flint.arm.linux.org.uk>
 	<5793EB6F192350088E0AC4CE@d216-220-25-20.dynip.modwest.com>
 <87slrio9wd.fsf@asmodeus.mcnaught.org>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 20, 2006 4:40:50 PM -0500 Doug McNaught <doug@mcnaught.org> 
wrote:

> Michael Loftis <mloftis@wgops.com> writes:
>
>> I think the four digit bugfix only stuff is an excellent step, and
>> necessary.  But the thing that I need more is stable APIs (both
>> userland and kernel, and at the kernel<->userland interface) *with*
>> bugfixes and (hopefully with) trivial hardware support update
>> backports, like the replacement e1000 driver.  And I guess I shouldn't
>> say 'I' need, but colleagues need.  And it's not just one company or
>> one project or one client/customer.  And not all the issues are the
>> same, but they come back to needing somewhere that's kept 'dusted off'
>> but not rearranged (too?) regularly.
>
> The point is that this is hard work, and not very interesting.
> Commercial distro vendors pay people to do it.  If you want a similar
> community effort, but you're not prepared to invest time, money, or
> leadership, well, too bad.

It sounds like that's what it's coming down to.  I'm willing to I just as 
anyone, need to be careful not to bite off too much.  And right now this 
sounds like it might be.

> And your desire for such a project to be "blessed" makes no sense.
> Create your fork, maintain it, and see who else wants to use it.  If
> it gets enough users and stays useful, I'm sure that it can be hosted
> on kernel.org -- that's really the only kind of "blessing" that there
> is.
>
> Remember that the people who maintained 2.2 and 2.4 as "stable"
> kernels volunteered to do it and put a *lot* of time into it.  It
> didn't just magically happen.

I know, and I'm incredibly grateful for that.  Heck up until just a year 
ago there was a 2.2.x box in the corner at home.  Heroic effort on those 
persons parts.

