Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVCCJCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVCCJCR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 04:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVCCJCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 04:02:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:194 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261559AbVCCJBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 04:01:40 -0500
Date: Thu, 3 Mar 2005 01:01:06 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303090106.GC29955@kroah.com>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002047.GA10434@kroah.com> <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org> <20050303081958.GA29524@kroah.com> <4226CCFE.2090506@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4226CCFE.2090506@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 03:38:22AM -0500, Jeff Garzik wrote:
> The pertinent question for a point release (2.6.X.Y) would simply be 
> "does a 2.6.11 user really need this fix?"

"need this fix bad enough now, or can it wait until 2.6.12?"

> >Like I previously said, I think we're doing a great job.  The current
> >-mm staging area could use some more testers to help weed out the real
> >issues, and we could do "real" releases a bit faster than every 2 months
> >or so.  But other than that, we have adapted over the years to handle
> >this extremely high rate of change in a pretty sane manner.
> 
> I think Linus's "even/odd" proposal is an admission that 2.6.X releases 
> need some important fixes after it hits kernel.org.

I agree.

> Otherwise 2.6.X is simply a constantly indeterminent state.

Heh, true, but all software is in that state :)

> We need to serve users, not just make life easier for kernel developers ;-)

Damm those pesky users.  Without them our life would be so much
easier...

greg k-h
