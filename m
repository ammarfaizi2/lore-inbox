Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262964AbVCDTG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbVCDTG0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 14:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262995AbVCDTAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 14:00:02 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15040 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262984AbVCDS4C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 13:56:02 -0500
Date: Fri, 04 Mar 2005 13:55:58 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: RFD: Kernel release numbering
In-reply-to: <Pine.LNX.4.58.0503040956420.25732@ppc970.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       tglx@linutronix.de, lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.62.0503041352480.15953@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
 <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com>
 <20050303151752.00527ae7.akpm@osdl.org> <20050303234523.GS8880@opteron.random>
 <20050303160330.5db86db7.akpm@osdl.org>
 <20050304025746.GD26085@tolot.miese-zwerge.org>
 <20050303213005.59a30ae6.akpm@osdl.org>
 <1109924470.4032.105.camel@tglx.tec.linutronix.de>
 <20050304005450.05a2bd0c.akpm@osdl.org> <20050304091612.GG14764@suse.de>
 <20050304012154.619948d7.akpm@osdl.org>
 <Pine.LNX.4.58.0503040956420.25732@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2005, Linus Torvalds wrote:

> 
> 
> On Fri, 4 Mar 2005, Andrew Morton wrote:
> >
> > Jens Axboe <axboe@suse.de> wrote:
> > >
> > > On Fri, Mar 04 2005, Andrew Morton wrote:
> > >  > The average user has learnt "rc1 == pre1".  I don't expect that it
> > >  > matters much at all.
> > > 
> > >  The average user and lkml reader, perhaps. But I don't understand
> > >  why Linus refuses to use proper -preX/-rcX naming
> > 
> > Me either.  And because people just will insist on arbitrarily dinking with
> > Cc: lines, he's not listening to us any more.
> 
> I've long since decided that there's no point to making "-pre". What's the 
> difference between a "-pre" and a daily -bk snapshot? Really?
> 
> So when I do a release, it _is_ an -rc. The fact that people have trouble 
> understanding this is not _my_ fault.

What is this whole thread all about then?

It might still be worth a try, especially since so many people are 
convinced this is the way to go (your fault or not is not the point).


Nicolas
