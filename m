Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbTIAAUu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 20:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263097AbTIAAUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 20:20:50 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:61648 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263076AbTIAAUm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 20:20:42 -0400
Date: Sun, 31 Aug 2003 17:20:32 -0700
From: Larry McVoy <lm@bitmover.com>
To: Roman Zippel <zippel@linux-m68k.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030901002032.GC18458@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
	Pascal Schmidt <der.eremit@email.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030831154450.GV24409@dualathlon.random> <20030831162243.GC18767@work.bitmover.com> <20030831163350.GY24409@dualathlon.random> <20030831164802.GA12752@work.bitmover.com> <20030831170633.GA24409@dualathlon.random> <20030831211855.GB12752@work.bitmover.com> <20030831224938.GC24409@dualathlon.random> <1062370358.12058.8.camel@dhcp23.swansea.linux.org.uk> <Pine.LNX.4.44.0309010136410.8124-100000@serv> <20030901000908.GA18458@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901000908.GA18458@work.bitmover.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 05:09:08PM -0700, Larry McVoy wrote:
> On Mon, Sep 01, 2003 at 01:39:56AM +0200, Roman Zippel wrote:
> > At first Larry wasn't talking about incoming bursts: "We do VOIP phones 
> > and when you guys clone a repo our phones don't work".
> 
> Hey, let me make something clear in case it isn't.  This isn't your problem,
> you have every right to clone away as fast as you want.  

I forgot to add that once we have this sorted out we'll do two other things
that you'll like:

a) give you BK URL's that don't change (the current URL's are unstable, they
   are based on revisions and revision numbers are unstable)
b) make every changeset (or range of changesets) be something you can grab
   as a regular diff -Nur style patch.  So all the BK users can post to the
   kernel list and include a URL that you all can wget and there is the 
   patch.  No need to use BK at all unless you want to, the data is right
   there as a patch.

All I'm trying to do is to underscore the point that none of you should "be
nice" and not beat up on bkbits.net.  It's a service, we get at least some
benefit from you using the service so bang on it all you want.  We'll solve
the bandwidth problems.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
