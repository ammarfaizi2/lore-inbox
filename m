Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbTIAAJY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 20:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTIAAJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 20:09:24 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:46288 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263078AbTIAAJW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 20:09:22 -0400
Date: Sun, 31 Aug 2003 17:09:08 -0700
From: Larry McVoy <lm@bitmover.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
       Larry McVoy <lm@bitmover.com>, Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030901000908.GA18458@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
	Pascal Schmidt <der.eremit@email.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk> <20030831154450.GV24409@dualathlon.random> <20030831162243.GC18767@work.bitmover.com> <20030831163350.GY24409@dualathlon.random> <20030831164802.GA12752@work.bitmover.com> <20030831170633.GA24409@dualathlon.random> <20030831211855.GB12752@work.bitmover.com> <20030831224938.GC24409@dualathlon.random> <1062370358.12058.8.camel@dhcp23.swansea.linux.org.uk> <Pine.LNX.4.44.0309010136410.8124-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309010136410.8124-100000@serv>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 01:39:56AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Sun, 31 Aug 2003, Alan Cox wrote:
> 
> > How about because any undergraduate can do the mathematical proof its
> > not possible. Unless he controls the ISP end of the link random bursts
> > of traffic, pingfloods, anything not respecting requests to slow down
> > will lose voice traffic.
> 
> At first Larry wasn't talking about incoming bursts: "We do VOIP phones 
> and when you guys clone a repo our phones don't work".

Hey, let me make something clear in case it isn't.  This isn't your problem,
you have every right to clone away as fast as you want.  So I am definitely
*not* asking you to ease up on bkbits.net.  In fact, I'd be unhappy if you
did, we get a fair amount of stress testing of new releases on bkbits.net.
So have at it.

But getting back to the problem space, it's incoming traffic, outgoing 
traffic, all the web hits (Google crawls the web interface to bkbits
for example, even though we've tried to turn that off through robots.txt
people have linkages into specific csets and then google will follow those
down and up), etc.

I'd love for shaping to be something that would help here but I agree 
with Alan and others who say that this isn't something we can control
at our end.  

The good news is that I'm 99% sure we have a deal for 2 T1 lines at
$500/each and we're currently paying $800/month for one T1 so I view
this as a slight increase in dollars for double the bandwidth.  The ISP
is willing to do the shaping at their end, where it will help, if that
works that means that everyone wins, you guys get more bandwidth.
If it doesn't work then you guys get a dedicated T1 line for bkbits
which is more than what you have now.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
