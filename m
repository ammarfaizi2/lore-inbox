Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWBCFIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWBCFIz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 00:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWBCFIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 00:08:55 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:23312 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932351AbWBCFIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 00:08:54 -0500
Date: Fri, 3 Feb 2006 06:08:35 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: Michael Loftis <mloftis@wgops.com>, David Weinehall <tao@acc.umu.se>,
       Doug McNaught <doug@mcnaught.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
       dtor_core@ameritech.net, James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060203050835.GA20709@w.ods.org>
References: <200601201903.k0KJ3qI7006425@turing-police.cc.vt.edu> <E27F809F04C1C673D283E84F@d216-220-25-20.dynip.modwest.com> <20060120200051.GA12610@flint.arm.linux.org.uk> <5793EB6F192350088E0AC4CE@d216-220-25-20.dynip.modwest.com> <87slrio9wd.fsf@asmodeus.mcnaught.org> <25D702FB62516982999D7084@d216-220-25-20.dynip.modwest.com> <20060202121653.GI20484@vasa.acc.umu.se> <67A0AFFBC77C32B9DEE25EFA@dhcp-2-206.wgops.com> <20060202220158.GA11380@w.ods.org> <43E2885E.3070506@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E2885E.3070506@nortel.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 04:31:58PM -0600, Christopher Friesen wrote:
> Willy Tarreau wrote:
> 
> >Given the past
> >experience of 2.4 and the time I can spend on kernel work, I would
> >not even consider basing anything on 2.6 before something like 2.6.20-25,
> >when it will hopefully settle down a bit.
> 
> Unfortunately there are many times when this simply isn't an option. 
> I'm currently working on boards that simply are not supported on 2.4. 
> Thus either we need to track 2.6, or else we need to pay someone to do 
> it for us and hope they do a good job.
> 
> Of course what actually happens is that you pick a kernel version 
> (hopefully you pick well) and then backport fixes.

This choice is valid when you have time or money for this. What I said
is people who have no skills, no time and no money should obviously
not consider 2.6 right now for a new project, it's moving too fast, and
spending 1 hour a week on it is not enough.

> Upgrading 
> continuously simply isn't an option, as we have multiple vendors 
> providing BSPs, drivers, patches, etc. and they're all supported only 
> for that specific kernel version.  We can really only upversion the 
> kernel once a year or so, if that often.

Agreed.

> Chris

Willy

