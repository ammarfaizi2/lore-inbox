Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267960AbTBVXrw>; Sat, 22 Feb 2003 18:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267965AbTBVXrw>; Sat, 22 Feb 2003 18:47:52 -0500
Received: from havoc.daloft.com ([64.213.145.173]:57539 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267960AbTBVXrv>;
	Sat, 22 Feb 2003 18:47:51 -0500
Date: Sat, 22 Feb 2003 18:57:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Larry McVoy <lm@work.bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Larry McVoy <lm@bitmover.com>, Mark Hahn <hahn@physics.mcmaster.ca>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030222235756.GA8699@gtf.org>
References: <Pine.LNX.4.44.0302221417120.2686-100000@coffee.psychology.mcmaster.ca> <1510000.1045942974@[10.10.2.4]> <20030222195642.GI1407@work.bitmover.com> <2080000.1045947731@[10.10.2.4]> <20030222231552.GA31268@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030222231552.GA31268@work.bitmover.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 03:15:52PM -0800, Larry McVoy wrote:
> or rackmount cases.  I fail to see how there are better margins on the
> same hardware in a rackmount box for $800 when the desktop costs $750.
> Those rack mount power supplies and cases are not as cheap as the desktop
> ones, so I see no difference in the margins.

Oh, it's definitely different hardware.  Maybe the 16550-related portion
of the ASIC is the same :) but just do an lspci to see huge differences in
motherboard chipsets, on-board parts, more complicated BIOS, remote
management bells and whistles, etc.  Even the low-end rackmounts.

But the better margins come simply from the mentality, IMO.  Desktops
just aren't "as important" to a business compared to servers, so IT
shops are willing to spend more money to not only get better hardware,
but also the support services that accompany it.  Selling servers
to enterprise data centers means bigger, more concentrated cash pool.

	Jeff



