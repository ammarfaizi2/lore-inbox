Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265504AbUAKACY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 19:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265528AbUAKACY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 19:02:24 -0500
Received: from wsip-68-15-8-100.sd.sd.cox.net ([68.15.8.100]:51841 "EHLO
	gnuppy") by vger.kernel.org with ESMTP id S265504AbUAKACW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 19:02:22 -0500
Date: Sat, 10 Jan 2004 16:02:11 -0800
To: Bernhard Kuhn <bkuhn@metrowerks.com>
Cc: linux-kernel@vger.kernel.org, "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [announcement, patch] real-time interrupts for the Linux kernel
Message-ID: <20040111000211.GA3056@gnuppy.monkey.org>
References: <3FFE078D.20400@metrowerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFE078D.20400@metrowerks.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 02:44:45AM +0100, Bernhard Kuhn wrote:
> Hi everybody!
> 
> I hope that i can steal enough of your precious time to get
> your attention for a new patch that adds hard real time support
> to the linux kernel (worst case interrupt response time below
> 5 microseconds):
> 
> The proposed "real time interrupt patch" enables the linux
> kernel for hard-real-time applications such as data aquisition
> and control loops by adding priorities to interrupts and spinlocks.
> 
> The following document will describe the patch in detail and how
> to install it:
> 
> http://home.t-online.de/home/Bernhard_Kuhn/rtirq/20040108/README
...

Also,
	http://www.linuxdevices.com/news/NS3235024671.html

It's kind of a cool patch. I'm surprised that nobody's commented on this
so far. Basically, if I understand this, this uses IO-APIC hardware
assistance for getting some notion of prioritized interrupts and a other
goodies. Just ran into the article now, but the original email post flew
under my radar. /me reads more

bill

