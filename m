Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbTHaXHl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 19:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbTHaXHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 19:07:41 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:24015 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263058AbTHaXHj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 19:07:39 -0400
Date: Sun, 31 Aug 2003 16:07:28 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831230728.GA4918@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	Pascal Schmidt <der.eremit@email.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk> <20030831154450.GV24409@dualathlon.random> <20030831162243.GC18767@work.bitmover.com> <20030831163350.GY24409@dualathlon.random> <20030831164802.GA12752@work.bitmover.com> <20030831170633.GA24409@dualathlon.random> <20030831211855.GB12752@work.bitmover.com> <20030831224938.GC24409@dualathlon.random> <1062370358.12058.8.camel@dhcp23.swansea.linux.org.uk> <20030831230219.GD24409@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831230219.GD24409@dualathlon.random>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 01:02:19AM +0200, Andrea Arcangeli wrote:
> On Sun, Aug 31, 2003 at 11:52:39PM +0100, Alan Cox wrote:
> > How about because any undergraduate can do the mathematical proof its
> > not possible. Unless he controls the ISP end of the link random bursts
> > of traffic, pingfloods, anything not respecting requests to slow down
> > will lose voice traffic.
> 
> they are legitimate tcp connections, not udp or icmp. I'm not saying you
> can control pingfloods or udp floods or syn floods.

I'll try this one more time and then I'm giving up because as far as I 
can tell you haven't tried this with a busy server, I think you said you
did shaping on your home machine or something.  Hardly the same thing.

How about a series of tiny HTTP requests?  All 1.0, no connection reuse.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
