Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262966AbVCDR7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262966AbVCDR7j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 12:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbVCDR5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 12:57:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:64203 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262959AbVCDR4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 12:56:15 -0500
Date: Fri, 4 Mar 2005 09:57:38 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Jens Axboe <axboe@suse.de>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <20050304012154.619948d7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503040956420.25732@ppc970.osdl.org>
References: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
 <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com>
 <20050303151752.00527ae7.akpm@osdl.org> <20050303234523.GS8880@opteron.random>
 <20050303160330.5db86db7.akpm@osdl.org> <20050304025746.GD26085@tolot.miese-zwerge.org>
 <20050303213005.59a30ae6.akpm@osdl.org> <1109924470.4032.105.camel@tglx.tec.linutronix.de>
 <20050304005450.05a2bd0c.akpm@osdl.org> <20050304091612.GG14764@suse.de>
 <20050304012154.619948d7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Mar 2005, Andrew Morton wrote:
>
> Jens Axboe <axboe@suse.de> wrote:
> >
> > On Fri, Mar 04 2005, Andrew Morton wrote:
> >  > The average user has learnt "rc1 == pre1".  I don't expect that it
> >  > matters much at all.
> > 
> >  The average user and lkml reader, perhaps. But I don't understand
> >  why Linus refuses to use proper -preX/-rcX naming
> 
> Me either.  And because people just will insist on arbitrarily dinking with
> Cc: lines, he's not listening to us any more.

I've long since decided that there's no point to making "-pre". What's the 
difference between a "-pre" and a daily -bk snapshot? Really?

So when I do a release, it _is_ an -rc. The fact that people have trouble 
understanding this is not _my_ fault.

		Linus
