Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbTJFSkF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbTJFSj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:39:29 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:20878 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262813AbTJFSjR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:39:17 -0400
Date: Mon, 6 Oct 2003 11:38:57 -0700
From: Larry McVoy <lm@bitmover.com>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
Message-ID: <20031006183857.GA3508@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Pascal Schmidt <der.eremit@email.de>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <Dnwo.1ew.15@gated-at.bofh.it> <DnPL.3XB.11@gated-at.bofh.it> <DsvX.3yN.1@gated-at.bofh.it> <E1A6a6A-0000qT-00@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1A6a6A-0000qT-00@neptune.local>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 08:28:46PM +0200, Pascal Schmidt wrote:
> On Mon, 06 Oct 2003 03:40:05 +0200, you wrote in linux.kernel:
> 
> > A much more obvious example than the SCM one is a device driver or a module.
> > That's so cut and dried it isn't even open to debate in the eyes of the 
> > law.  It's a hard and fast boundary, the GPL can't cross it no matter what
> > people think or want (on either side).
> 
> Huh? How is a driver an independent work under the definition you gave?
> I can't take the Linux kernel out and insert the driver into another
> kernel and have it still work. Only the opposite is true - the kernel
> would run without the driver, and therefore the kernel is not a derived
> work of the driver and can't be subject to license terms of the driver.

The thing that is trying to cross the boundary is the kernel license
so what matters is if the thing which you believe should be GPLed is
separable or not.

> The kernel doesn't have a defined interface for drivers. It changes a
> lot at least during a development series. A driver is not independent from
> the kernel running under it because it has to be changed quite often to
> adapt to the changing internal kernel interfaces.

That has no bearing on the legalities.  A version of the kernel can't
force the GPL on a driver that works with that version of the kernel
because you can pull that driver out and drop in another.  A great example
is the eepro driver, there is Becker's version and the Intel version.
Any judge who wasn't fooled by Microsoft priced lawyers would clearly
see the boundary and make a ruling that the GPL can't cross over it.

By the way, many people here want to argue against this point of view
because they are pro GPL.  OK, fine, maybe you can change the laws
and make that stick.  I very much doubt it but let's suppose you do.
By doing that you will be supporting SCO's legal case.  If the GPL can
cross over those boundaries than so can SCO's license.  You can't have
one set of rules for you and another set of rules for them, you have to
apply them to everyone.

When you understand that you will understand more clearly why I bother to
comment on this at all.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
