Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWBBMQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWBBMQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 07:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWBBMQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 07:16:57 -0500
Received: from mail.acc.umu.se ([130.239.18.156]:3006 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S1750943AbWBBMQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 07:16:56 -0500
Date: Thu, 2 Feb 2006 13:16:53 +0100
From: David Weinehall <tao@acc.umu.se>
To: Michael Loftis <mloftis@wgops.com>
Cc: Doug McNaught <doug@mcnaught.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
       dtor_core@ameritech.net, James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060202121653.GI20484@vasa.acc.umu.se>
Mail-Followup-To: Michael Loftis <mloftis@wgops.com>,
	Doug McNaught <doug@mcnaught.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
	dtor_core@ameritech.net,
	James Courtier-Dutton <James@superbug.co.uk>,
	linux-kernel@vger.kernel.org
References: <43D10FF8.8090805@superbug.co.uk> <6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com> <d120d5000601200850w611e8af8v41a0786b7dc973d9@mail.gmail.com> <30D11C032F1FC0FE9CA1CDFD@d216-220-25-20.dynip.modwest.com> <200601201903.k0KJ3qI7006425@turing-police.cc.vt.edu> <E27F809F04C1C673D283E84F@d216-220-25-20.dynip.modwest.com> <20060120200051.GA12610@flint.arm.linux.org.uk> <5793EB6F192350088E0AC4CE@d216-220-25-20.dynip.modwest.com> <87slrio9wd.fsf@asmodeus.mcnaught.org> <25D702FB62516982999D7084@d216-220-25-20.dynip.modwest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25D702FB62516982999D7084@d216-220-25-20.dynip.modwest.com>
User-Agent: Mutt/1.4.2.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]

So, let's summarise what you've been saying in this thread so far:

o You want advance warning of API changes, but when you get them
  (devfs, for instance), you ignore them and complain anyway -- check

o You want security fixes and only minor other fixes (done magically
  by someone else as you're not willing to pay for it, nor are you
  willing to help yourself), for at least 6 months, but you ignore
  the existance of the 2.6.x.y kernel series, which does exactly
  that -- check

o You think that 2.4.x isn't supporting enough new hardware,
  and yet you claim that adding new PCI ID:s is enough to add
  support for new hardware in most cases -- check

o You're going on and on about API breakage between kernel and
  userspace, yet the only example you keep repeating is devfs -- check

So far, I'd say you're just trolling.  Please calm down, *breathe*,
and start reading what people actually respond to you, think it
through, and consider if maybe, just maybe, there might be more sense
in their opinions than in yours.  And maybe, just maybe, people that
spend a lot of their spare time (or work time, for that matter) to
give you for free (and FREE) the best kernel there is, deserve a
bit more than your whining.

Or in short:

"Don't complain, contribute!"


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
