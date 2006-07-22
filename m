Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWGVB0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWGVB0H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 21:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWGVB0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 21:26:07 -0400
Received: from xenotime.net ([66.160.160.81]:5783 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750771AbWGVB0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 21:26:06 -0400
Message-Id: <1153531563.25640@shark.he.net>
Date: Fri, 21 Jul 2006 18:26:03 -0700
From: "Randy Dunlap" <rdunlap@xenotime.net>
To: "Matt LaPlante" <kernel1@cyberdogtech.com>,
       "'Randy Dunlap'" <rdunlap@xenotime.net>,
       "'David Lang'" <dlang@digitalinsight.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: How long to wait on patches?
X-Mailer: WebMail 1.25
X-IPAddress: 216.191.251.226
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > -----Original Message-----
> > From: Randy Dunlap [mailto:rdunlap@xenotime.net]
> > Sent: Friday, July 21, 2006 9:07 PM
> > To: David Lang; Matt LaPlante; linux-kernel@vger.kernel.org
> > Subject: Re: How long to wait on patches?
> > 
> > 
> > 
> > > On Fri, 21 Jul 2006, Matt LaPlante wrote:
> > >
> > >[me]
> > >
> > > be sure to watch the -mm tree as well, a lot of patches are picked up
> > by Andrew
> > > to be fed to Linus that way
> > >
> > > this is a particularly bad week since almost all the core developers
> > were up at
> > > OLS.
> > >
> > > one thing you may want to look at doing (hosting permitting) is to
> > setup a git
> > > tree to just hold your trivial patches so that they can be pulled
> > easily.
> > >
> > > I thought there was a person who was maintaining a -trivial tree for
> > this
> > > purpose, I don't remember who it was though.
> > 
> > 
> > Yes, Adrian Bunk accepts and forwards trivial patches. See
> > http://www.kernel.org/pub/linux/kernel/people/bunk/trivial/
> > 
> > ---
> > ~Randy
> 
> Yes, my patches were CC'd to the trivial alias.  I guess from what
I've read
> on that page that I should wait until after .18 to look for them in
the git?

You mean in Linus's git tree?  Adrian will have to answer that
question, although the answer is likely to be Yes.  Linus recently
said that he accepts patches until -rc2 and after that he is
looking for stability and bug fixes for a final release, so
it could well be after 2.6.18 when they are merged.

---
~Randy

