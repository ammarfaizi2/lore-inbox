Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263049AbTHaXBz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 19:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbTHaXBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 19:01:55 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38367
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263049AbTHaXBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 19:01:52 -0400
Date: Mon, 1 Sep 2003 01:02:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@work.bitmover.com>, Larry McVoy <lm@bitmover.com>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831230219.GD24409@dualathlon.random>
References: <20030831144505.GS24409@dualathlon.random> <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk> <20030831154450.GV24409@dualathlon.random> <20030831162243.GC18767@work.bitmover.com> <20030831163350.GY24409@dualathlon.random> <20030831164802.GA12752@work.bitmover.com> <20030831170633.GA24409@dualathlon.random> <20030831211855.GB12752@work.bitmover.com> <20030831224938.GC24409@dualathlon.random> <1062370358.12058.8.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062370358.12058.8.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 11:52:39PM +0100, Alan Cox wrote:
> On Sul, 2003-08-31 at 23:49, Andrea Arcangeli wrote:
> > > I'm not sure why you are arguing this, if you have a fat pipe feeding into
> > 
> > you never tried with linux, how can you claim you know it doesn't work
> > in practice? The fact is that you never tried it, while we used it all
> > the time.
> 
> How about because any undergraduate can do the mathematical proof its
> not possible. Unless he controls the ISP end of the link random bursts
> of traffic, pingfloods, anything not respecting requests to slow down
> will lose voice traffic.

they are legitimate tcp connections, not udp or icmp. I'm not saying you
can control pingfloods or udp floods or syn floods.

Andrea
