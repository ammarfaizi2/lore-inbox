Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbUK2XNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbUK2XNK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 18:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbUK2XJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 18:09:16 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:2514 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261853AbUK2WyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:54:05 -0500
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] CKRM: 0/10 Class Based Kernel Resource Management 
In-reply-to: Your message of Mon, 29 Nov 2004 22:32:51 GMT.
             <20041129223251.GA12192@infradead.org> 
Date: Mon, 29 Nov 2004 14:51:24 -0800
Message-Id: <E1CYuMe-0001rK-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Nov 2004 22:32:51 GMT, Christoph Hellwig wrote:
> On Mon, Nov 29, 2004 at 10:44:49AM -0800, Gerrit Huizenga wrote:
> > The following ten patches add the core of CKRM (Class Based Resource
> > Management) to Linux.  Current patches are against 2.6.10-rc2.  This
> > set of patches is essentailly a cleaned up version of what is
> > known on the ckrm-tech@lists.sourcerforge.net as the E16 code base.
> > As compared to E16, the patch breakout has been reorganized for easier
> > application to mainline with a number of stylistic cleanups more
> > in line with mainline kernel code.
> 
> And where's the people who wrote the code?  Are people at IBM really
> all anxious cowards these days that can't submit their own code but have
> to abuse a highlevel manager for it.
> 
> I must also say that I'm a bit disappointed by you, Gerrit.  Either you
> haven't actually read the code or I vastly overrated your taste.

LOL, Christoph, Christoph...  No, folks at IBM working on CKRM aren't
cowards, you'll see most of them on ckrm-tech or working with distros
or end users of the code or writing new code.  You've seen them at KS
and OLS.  Many are soaked up into a couple of other deliverables at
the moment but they'll be back.

We've needed some help in stabilizing and aggregating the code and so
we are using my copious free cycles.  And, no, silly Christoph, I'm no
manager and never have been.

Yes, I've read the code, yes I cleaned up a bunch of it.  But rather
than me sitting on it forever cleaning, I figured I'd shake it out and
get more eyes providing feedback which is where LKML is very handy.
Lots of eyes making sure that it is useful and minimally invasive never
hurts.  And stewing it around just ckrm-tech is great for functionality
but less great for converging and cleanup.  Hence, time to get this
into the wider eye of the community, including yours.

If you see needed cleanups, send me patches.  If they make sense, I'll
integrate.  If not, I'll go back to that training class on how to
deal with Christoph on LKML.  ;-)

gerrit
