Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbTISUBx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 16:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbTISUBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 16:01:52 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:1419
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261728AbTISUBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 16:01:18 -0400
Date: Fri, 19 Sep 2003 22:01:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Roland Bless <bless@tm.uka.de>, miquels@cistron.nl,
       linux-kernel@vger.kernel.org, walter@tm.uka.de, winter@tm.uka.de,
       doll@tm.uka.de
Subject: Re: Fix for wrong OOM killer trigger?
Message-ID: <20030919200117.GE1312@velociraptor.random>
References: <20030919191613.36750de3.bless@tm.uka.de> <20030919192544.GC1312@velociraptor.random> <20030919203538.D1919@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030919203538.D1919@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 08:35:38PM +0100, Russell King wrote:
> On Fri, Sep 19, 2003 at 09:25:44PM +0200, Andrea Arcangeli wrote:
> >...
> > the same too.
> > 
> > Andrea
> > 
> > /*
> >  * If you refuse to depend on closed software for a critical
> >  * part of your business, these links may be useful:
> >  *
> >  * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/
> >  * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.4/
> >  * http://www.cobite.com/cvsps/
> >  *
> >  * svn://svn.kernel.org/linux-2.6/trunk
> >  * svn://svn.kernel.org/linux-2.4/trunk
> >  */
> 
> Would you mind following nettiquette guidelines for your signature.
> It appears to be overly large and contain inflamitory material, both
> of which are equally good reasons on their _own_ not to use it.
> 
> -- 
> Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
> Linux kernel maintainer of:
>   2.6 ARM Linux   - http://www.arm.linux.org.uk/
>   2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
>   2.6 Serial core

does it look better if I change it like this:

-------------------------
Andrea - If you refuse to depend on closed software for a critical
	 part of your business, these links may be useful:
	  rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	  http://www.cobite.com/cvsps/
	  svn://svn.kernel.org/linux-2.[46]/trunk
-------------------------

Hope it's ok in terms of bandwidth now.

And if you don't like the text I write in my signature, I'm sorry and I
would simply suggest you to not read it. If you need a marker to cleanup
it reliably just ask me and I'll be glad to add it. IMHO the value those
services provides is too high not to advertize them as much as I
possibly can.

Andrea
