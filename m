Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263048AbTHaWxn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 18:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263049AbTHaWxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 18:53:43 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:64964 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263048AbTHaWxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 18:53:35 -0400
Subject: Re: bandwidth for bkbits.net (good news)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Larry McVoy <lm@work.bitmover.com>, Larry McVoy <lm@bitmover.com>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030831224938.GC24409@dualathlon.random>
References: <20030831025659.GA18767@work.bitmover.com>
	 <1062335711.31351.44.camel@dhcp23.swansea.linux.org.uk>
	 <20030831144505.GS24409@dualathlon.random>
	 <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk>
	 <20030831154450.GV24409@dualathlon.random>
	 <20030831162243.GC18767@work.bitmover.com>
	 <20030831163350.GY24409@dualathlon.random>
	 <20030831164802.GA12752@work.bitmover.com>
	 <20030831170633.GA24409@dualathlon.random>
	 <20030831211855.GB12752@work.bitmover.com>
	 <20030831224938.GC24409@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062370358.12058.8.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 31 Aug 2003 23:52:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-31 at 23:49, Andrea Arcangeli wrote:
> > I'm not sure why you are arguing this, if you have a fat pipe feeding into
> 
> you never tried with linux, how can you claim you know it doesn't work
> in practice? The fact is that you never tried it, while we used it all
> the time.

How about because any undergraduate can do the mathematical proof its
not possible. Unless he controls the ISP end of the link random bursts
of traffic, pingfloods, anything not respecting requests to slow down
will lose voice traffic.

Since he doesn't appear to control the ISP end (either directly or via
RSVP) he's lost. 


