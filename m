Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVBHP6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVBHP6H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 10:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVBHP6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 10:58:07 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:32613 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261549AbVBHP6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 10:58:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VuDbHoEX1KYyEx213/8Dsi4/JjQAWQ03D5L2ME1MCBNkh7WOrUt7mm9vU9tP3MDgicsjcF2PepuTQgwK52+M9nwf34rg6wHf9Uuqg6UGqYpG3QwuaBtvgFVaQoKKQQqGzi8tA1Dt6RHYsk6ijG/xoCrOxStoGlqGE0LGCDk9+Ec=
Message-ID: <9e47339105020807585a5c4fc@mail.gmail.com>
Date: Tue, 8 Feb 2005 10:58:01 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [RFC] Linux Kernel Subversion Howto
Cc: Larry McVoy <lm@bitmover.com>, Stelian Pop <stelian@popies.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0502071516100.30794@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050203033459.GA29409@bitmover.com>
	 <20050203220059.GD5028@deep-space-9.dsnet>
	 <20050203222854.GC20914@bitmover.com>
	 <20050204130127.GA3467@crusoe.alcove-fr>
	 <20050204160631.GB26748@bitmover.com>
	 <Pine.LNX.4.61.0502060025020.6118@scrub.home>
	 <20050206173910.GB24160@bitmover.com>
	 <Pine.LNX.4.61.0502061859000.30794@scrub.home>
	 <20050207021030.GA25673@bitmover.com>
	 <Pine.LNX.4.61.0502071516100.30794@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2005 15:57:14 +0100 (CET), Roman Zippel
<zippel@linux-m68k.org> wrote:
> 1. Is the kernel history locked into bk?

Earlier Larry said this:

On Thu, 3 Feb 2005 12:20:49 -0800, Larry McVoy <lm@bitmover.com> wrote:
> > Speaking from the out-BK point of view, what would really be nice
> > is better granularity in the CVS export (a 1-1 changeset to CVS commit
> > mapping). I know this involves playing with CVS branches and could
> > be a bit tricky but should be doable.
> 
> I have two problems with this request:
> 
>     - The idea that the granularity in CVS is unreasonable is pure
>       nonesense.  Here's the data as of this email:
> 
>                 CVS             BitKeeper [*]
>         Deltas  235,956         280,212
> 
>     - It is not at all an easy thing to do in CVS, we looked at it and
>       guessed it is about 3 man months of work.
> 
> So let's see what's reasonable.  In order for you to get the last 16%
> of the granularity, which you need because you want to compete with us,
> you'd like us to do another 3 man months of work.  What would you say if
> you were me in this situation?

Roman, if you want this so bad why don't you just pay Larry for the
three month's work? It's just not reasonable to ask someone to do work
for free that the only purpose of is to help someone clone their
system. He's never said he won't make the changes, he just said he
won't do the work for free.

Don't bother with a big response about how all of the revision history
should be available for free and that you shouldn't have to pay to get
it.  For historical reasons we're in the current position and you have
a solution which is to pay to have the work done.

-- 
Jon Smirl
jonsmirl@gmail.com
