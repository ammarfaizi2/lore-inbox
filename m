Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269670AbRHIESd>; Thu, 9 Aug 2001 00:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269672AbRHIESX>; Thu, 9 Aug 2001 00:18:23 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:32667 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S269670AbRHIESG>; Thu, 9 Aug 2001 00:18:06 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 9 Aug 2001 14:09:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15218.3327.402934.158296@notabene.cse.unsw.edu.au>
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: How/when to send patches - (was  Re: [PATCH] one of $BIGNUM devfs races)
In-Reply-To: message from Alan Cox on Tuesday August 7
In-Reply-To: <no.id>
	<E15TuHf-00022E-00@the-village.bc.nu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 7, alan@lxorguk.ukuu.org.uk wrote:
> > OK, fair enough. When is your next merge with Linus scheduled? I'd
> > prefer to get a few races fixed before shipping a patch, but I can try
> > to plan for an earlier release if necessary.
> 
> I send stuff Linus regularly and sometimes it goes in and sometimes it
> doesn't. Stuff with active maintainers I don't send on to Linus unless asked
> too - hence joystick. input and much of USB are so far behind in Linus tree

This is something I would like to understand better.

Sometimes I send patches to Linus, and a new prepatch comes out within
hours that contains them.
Sometimes I send patches to Linus and it's like sending them to
/dev/null. Sometimes I resend.  Sometimes it helps.

So I wonder "is he busy? does he have other priorities? does he have a
broken mail system?  is he being rude" in decreasing order of
likelyhood from "very" to "very un-".

So I thought I would try sending to Alan and Linus.  Then they
appeared in an -ac patch, but not in a pre patch.

I thought that might be close enough, but if Alan doesn't plan to
forward them the Linus, then it isn't.


Now I am happy to just resent the pending patches every time a pre
patch comes out that doesn't contain then, but I want to be sure that
isn't going to negatively impact Linus at all.

Comments?

NeilBrown

(I'm talking about patches to fs/nfsd and drivers/md)
