Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVAMX3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVAMX3j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVAMXSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:18:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:64481 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261806AbVAMXPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 18:15:18 -0500
Date: Thu, 13 Jan 2005 15:15:14 -0800
From: Chris Wright <chrisw@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Marek Habersack <grendel@caudium.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113151514.I24171@build.pdx.osdl.net>
References: <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain> <20050113194246.GC24970@beowulf.thanes.org> <20050113200308.GC3555@redhat.com> <Pine.LNX.4.58.0501131206340.2310@ppc970.osdl.org> <1105644461.4644.102.camel@localhost.localdomain> <Pine.LNX.4.58.0501131255590.2310@ppc970.osdl.org> <1105651504.4624.150.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1105651504.4624.150.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Thu, Jan 13, 2005 at 09:25:07PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> On Iau, 2005-01-13 at 21:03, Linus Torvalds wrote:
> > On Thu, 13 Jan 2005, Alan Cox wrote:
> >  - no embargo, no rules, but "private" in the sense that it's supposed to 
> >    be for kernel developers only or at least people who won't take 
> >    advantage of it.
> > 
> >    _I_ think this is the one that makes sense. No hard rules, but private 
> >    enough that people won't feel _guilty_ about reporting problems. Right 
> >    now I sometimes get private email from people who don't want to point
> >    out some local DoS or similar, and that can certainly get lost in the
> >    flow.
> 
> And also not passed on to vendors and other folks which is a pita and
> this would fix
> > 
> >  - _short_ embargo, for kernel-only. I obviously believe that vendor-sec 
> >    is whoring itself for security firms and vendors. I believe there would 
> >    be a place for something with stricter rules on disclosure.
> 
> Seems these two could be the same list with a bit of respect for users
> wishes and common sense.

I think they should be the same.  I hope the draft security contact bits
reflect that.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
