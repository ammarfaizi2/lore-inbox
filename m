Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWGVBcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWGVBcb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 21:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWGVBcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 21:32:31 -0400
Received: from cpe-74-70-38-78.nycap.res.rr.com ([74.70.38.78]:18437 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1750950AbWGVBcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 21:32:31 -0400
From: "Matt LaPlante" <kernel1@cyberdogtech.com>
To: "'Randy Dunlap'" <rdunlap@xenotime.net>,
       "'David Lang'" <dlang@digitalinsight.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: How long to wait on patches?
Date: Fri, 21 Jul 2006 21:32:09 -0400
Message-ID: <000401c6ad2e$a6ba0eb0$fe01a8c0@cyberdogt42>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <1153531563.25640@shark.he.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcatLdCCrbczKyYkTbStivg7KE48HgAAJFog
X-Spam-Processed: mail.cyberdogtech.com, Fri, 21 Jul 2006 21:32:16 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Fri, 21 Jul 2006 21:32:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Randy Dunlap [mailto:rdunlap@xenotime.net]
> Sent: Friday, July 21, 2006 9:26 PM
> To: Matt LaPlante; 'Randy Dunlap'; 'David Lang'; linux-
> kernel@vger.kernel.org
> Subject: RE: How long to wait on patches?
> 
> 
> 
> > > -----Original Message-----
> > > From: Randy Dunlap [mailto:rdunlap@xenotime.net]
> > > Sent: Friday, July 21, 2006 9:07 PM
> > > To: David Lang; Matt LaPlante; linux-kernel@vger.kernel.org
> > > Subject: Re: How long to wait on patches?
> > >
> > >
> > >
> > > > On Fri, 21 Jul 2006, Matt LaPlante wrote:
> > > >
> > > >[me]
> > > >
> > > > be sure to watch the -mm tree as well, a lot of patches are picked
> up
> > > by Andrew
> > > > to be fed to Linus that way
> > > >
> > > > this is a particularly bad week since almost all the core developers
> > > were up at
> > > > OLS.
> > > >
> > > > one thing you may want to look at doing (hosting permitting) is to
> > > setup a git
> > > > tree to just hold your trivial patches so that they can be pulled
> > > easily.
> > > >
> > > > I thought there was a person who was maintaining a -trivial tree for
> > > this
> > > > purpose, I don't remember who it was though.
> > >
> > >
> > > Yes, Adrian Bunk accepts and forwards trivial patches. See
> > > http://www.kernel.org/pub/linux/kernel/people/bunk/trivial/
> > >
> > > ---
> > > ~Randy
> >
> > Yes, my patches were CC'd to the trivial alias.  I guess from what
> I've read
> > on that page that I should wait until after .18 to look for them in
> the git?
> 
> You mean in Linus's git tree?  Adrian will have to answer that
> question, although the answer is likely to be Yes.  Linus recently
> said that he accepts patches until -rc2 and after that he is
> looking for stability and bug fixes for a final release, so
> it could well be after 2.6.18 when they are merged.
> 
> ---
> ~Randy

Adrian has a trivial git tree which has been silent for a couple weeks too.
This is part of the reason I was curious if the patches were still sitting
in his inbox or if they'd been passed over.  Of course, that's a question
only he could answer.

-
Matt


