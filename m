Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266495AbUA2XS1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 18:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUA2XS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 18:18:26 -0500
Received: from [66.35.79.110] ([66.35.79.110]:669 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S266502AbUA2XRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 18:17:53 -0500
Date: Thu, 29 Jan 2004 15:17:24 -0800
From: Tim Hockin <thockin@hockin.org>
To: Andries Brouwer <aebr@win.tue.nl>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Lindent fixed to match reality
Message-ID: <20040129231724.GA814@hockin.org>
References: <20040129193727.GJ21888@waste.org> <20040129201556.GK16675@khan.acc.umu.se> <20040129233730.A19497@pclin040.win.tue.nl> <20040129225456.GM16675@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129225456.GM16675@khan.acc.umu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh, religion.

On Thu, Jan 29, 2004 at 11:54:56PM +0100, David Weinehall wrote:

> But I guess that was just a typo?  Of course, since the ()'s are useless
> here anyway, and doesn't really bring any added bonus, we end up with
> 
> sizeof *foo + 1
> 
> vs
> 
> sizeof*foo + 1

No, you're building a straw man.  Everyone knows that you should always use
the parens on sizeof().  Just because you CAN leave them out SOMETIMES does
not mean you SHOULD.

> sizeoffoo
> 
> would be invalid code, while
> 
> sizeof foo
> 
> is perfectly valid.

ooh, look at that straw man burn!

