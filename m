Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbTEWHUR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 03:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263869AbTEWHUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 03:20:17 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:5390 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S263802AbTEWHUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 03:20:16 -0400
Date: Fri, 23 May 2003 09:13:53 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: DevilKin <devilkin-lkml@blindguardian.org>
cc: Jean Tourrilhes <jt@bougret.hpl.hp.com>, Stian Jordet <liste@jordet.nu>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: irtty_sir cannot be unloaded
In-Reply-To: <200305230858.14069.devilkin-lkml@blindguardian.org>
Message-ID: <Pine.LNX.4.44.0305230908080.14825-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003, DevilKin wrote:

> > This and a few other things from the list which I've sent to you is done
> > in my local codebase, but needs some testing over the weekend. So you'll
> > see patches on monday. I guess I'll make them against what you've sent to
> > Jeff despite it may need some more time until this appears in bk - Ok?
> 
> If there is any code I can help test, I'm more than willing :-)

Me too - but no, wrt. the rtnl-deadlock nothing that I know of. The 
changes I mentioned above are merely cleanups of the sir-dev and irtty-sir
stuff completely unrelated to the deadlock.

I've just tried to ping the other thread but as was said, it's a 
network/hotplug problem and definitely not easy to resolve.

Martin

