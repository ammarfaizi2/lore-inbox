Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbVCCSHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbVCCSHL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 13:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVCCSDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 13:03:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:43975 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262533AbVCCSCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 13:02:35 -0500
Date: Thu, 3 Mar 2005 10:02:23 -0800
From: Chris Wright <chrisw@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303180223.GQ5389@shell0.pdx.osdl.net>
References: <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com> <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org> <20050303165533.GQ28536@shell0.pdx.osdl.net> <20050303170336.GL19505@suse.de> <Pine.LNX.4.58.0503030952120.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503030952120.25732@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds (torvalds@osdl.org) wrote:
> On Thu, 3 Mar 2005, Jens Axboe wrote:
> > 
> > Why should there be one? One of the things I like about this concept is
> > that it's just a moving tree. There could be daily snapshots like the
> > -bkX "releases" of Linus's tree, if there are changes from the day
> > before. It means (hopefully) that no one will "wait for x.y.z.2 because
> > that is really stable".
> 
> Exactly. Th ewhole point of this tree is that there shouldn't be anything 
> questionable in it. All the patches are independent, and they are all 
> trivial and small.
> 
> Which is not to say there couldn't be regressions even from trivial and 
> small patches, and yes, there will be an outcry when there is, but we're 
> talking minimizing the risk, not making it impossible.

OK.  I was aniticpating people's request for an official 2.6.x.y release
(since I've already had that request a bunch).  But as long as the
snapshot can be easily identified in the unlikely case of a regression,
then snapshot could be good enough.
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
