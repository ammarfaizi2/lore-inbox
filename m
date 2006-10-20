Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992750AbWJTS7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992750AbWJTS7x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992771AbWJTS7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:59:52 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:47377 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S2992766AbWJTS7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:59:50 -0400
Date: Fri, 20 Oct 2006 19:59:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [0/3] 2.6.19-rc2: known regressions
Message-ID: <20061020185944.GC8894@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org> <20061014111458.GI30596@stusta.de> <20061015122453.GA12549@flint.arm.linux.org.uk> <20061015124210.GX30596@stusta.de> <20061019081753.GA29883@flint.arm.linux.org.uk> <20061020180722.GA8894@flint.arm.linux.org.uk> <20061020111900.30d3cb03.akpm@osdl.org> <20061020183159.GB8894@flint.arm.linux.org.uk> <Pine.LNX.4.64.0610201149340.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610201149340.3962@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 11:50:53AM -0700, Linus Torvalds wrote:
> On Fri, 20 Oct 2006, Russell King wrote:
> > Ah, okay.  Must not have poped out of the other side of Linus by 6am GMT
> > then. 
> 
> Yeah, I applied Andrew's patch-bomb just an hour or two ago.

That explains why I hadn't seen it, and probably explains why there
hadn't been any git snapshots since Thursday morning (my time) - so
nothings actually broken.  Ignore me! 8)

> > (We also seem to have non-working git snapshots again, so when I
> > looked at the ARM kautobuild it showed the same old errors.)
> 
> Gaah. Remind me where the autobuild is again..

The main status page is at:
  http://armlinux.simtec.co.uk/kautobuild/

You could argue that it should be able to run off the git tree itself -
I'll probably even agree with you, but kautobuild isn't my system.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
