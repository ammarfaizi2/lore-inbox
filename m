Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWATVlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWATVlQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWATVlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:41:16 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:36361 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S1751169AbWATVlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:41:15 -0500
To: Michael Loftis <mloftis@wgops.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
       dtor_core@ameritech.net, James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
	<43D10FF8.8090805@superbug.co.uk>
	<6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>
	<d120d5000601200850w611e8af8v41a0786b7dc973d9@mail.gmail.com>
	<30D11C032F1FC0FE9CA1CDFD@d216-220-25-20.dynip.modwest.com>
	<200601201903.k0KJ3qI7006425@turing-police.cc.vt.edu>
	<E27F809F04C1C673D283E84F@d216-220-25-20.dynip.modwest.com>
	<20060120200051.GA12610@flint.arm.linux.org.uk>
	<5793EB6F192350088E0AC4CE@d216-220-25-20.dynip.modwest.com>
From: Doug McNaught <doug@mcnaught.org>
Date: Fri, 20 Jan 2006 16:40:50 -0500
In-Reply-To: <5793EB6F192350088E0AC4CE@d216-220-25-20.dynip.modwest.com> (Michael
 Loftis's message of "Fri, 20 Jan 2006 14:21:06 -0700")
Message-ID: <87slrio9wd.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Loftis <mloftis@wgops.com> writes:

> I think the four digit bugfix only stuff is an excellent step, and
> necessary.  But the thing that I need more is stable APIs (both
> userland and kernel, and at the kernel<->userland interface) *with*
> bugfixes and (hopefully with) trivial hardware support update
> backports, like the replacement e1000 driver.  And I guess I shouldn't
> say 'I' need, but colleagues need.  And it's not just one company or
> one project or one client/customer.  And not all the issues are the
> same, but they come back to needing somewhere that's kept 'dusted off'
> but not rearranged (too?) regularly.

The point is that this is hard work, and not very interesting.
Commercial distro vendors pay people to do it.  If you want a similar
community effort, but you're not prepared to invest time, money, or
leadership, well, too bad.

And your desire for such a project to be "blessed" makes no sense.
Create your fork, maintain it, and see who else wants to use it.  If
it gets enough users and stays useful, I'm sure that it can be hosted
on kernel.org -- that's really the only kind of "blessing" that there
is.

Remember that the people who maintained 2.2 and 2.4 as "stable"
kernels volunteered to do it and put a *lot* of time into it.  It
didn't just magically happen.

-Doug
