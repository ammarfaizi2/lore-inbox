Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbUFJTvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUFJTvX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 15:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbUFJTvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 15:51:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47307 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262766AbUFJTvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 15:51:21 -0400
Date: Thu, 10 Jun 2004 10:00:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040610080043.GB4507@openzaurus.ucw.cz>
References: <1YUY7-6fF-11@gated-at.bofh.it> <200405242250.38442.tglx@linutronix.de> <Pine.LNX.4.58.0405241400280.32189@ppc970.osdl.org> <200405242320.20691.tglx@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405242320.20691.tglx@linutronix.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > So I'd rather encourage people to sign off on even the silly stuff, than
> > to have to constantly make a judgement call. At the same time, I think
> > that if somebody _didn't_ sign off on the simple stuff, we shouldn't just
> > run around in circles like hens in a hen-house, we should just say "hey,
> > we've got brains, the process isn't meant to be _stupid_".
> 
> :)
> 
> One more practical point.
> 
> Module maintainers receive patches from various hackers and commit them after 
> review with the appropriate "sign-offs" to a subsystem repository.
> 
> Subsystem maintainer makes his monthly / whatever upstream update. 
> 
> Until now he just reviews the total changes from his last update til now. To 
> keep your proposed procedure consistent he would be forced now to go through 
> the "trusted" step by step commitments of his module maintainers, extract the 
> "sign-offs" and add his own "sign-off" to each single step before pushing the 
> improvements upstream. 
> 
> IMHO it would suffice for this situation, if the "sign-offs" are tracked in 
> the subsystem repository and the subsystem maintainer signs off for the 
> overall patch / contribution which is sent upstream.
> 

This is actually a problem. It forces subsystem maintainer
to have version control system and not to rm -rf it
when he needs disk space.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

