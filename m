Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285186AbRL2Sq7>; Sat, 29 Dec 2001 13:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285209AbRL2Squ>; Sat, 29 Dec 2001 13:46:50 -0500
Received: from dsl-213-023-043-128.arcor-ip.net ([213.23.43.128]:64261 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S285186AbRL2Sqe>;
	Sat, 29 Dec 2001 13:46:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Oliver Xymoron <oxymoron@waste.org>
Subject: Re: [PATCH] rlimit_nproc
Date: Sat, 29 Dec 2001 19:49:46 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Legacy Fishtank <garzik@havoc.gtf.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.43.0112291212340.18183-100000@waste.org>
In-Reply-To: <Pine.LNX.4.43.0112291212340.18183-100000@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16KOYH-0000Fr-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 29, 2001 07:13 pm, Oliver Xymoron wrote:
> On Sat, 29 Dec 2001, Daniel Phillips wrote:
> 
> > On December 27, 2001 10:35 pm, Legacy Fishtank wrote:
> > > On Thu, Dec 27, 2001 at 12:35:38PM -0800, Linus Torvalds wrote:
> > > > Also worthwhile for automation is an md5sum or similar (for verifying that
> > > > the mail made it though the mail system unscathed). A pgp signature would
> > > > be even better, of course - especially useful as I suspect it would be
> > > > good to also cc the things to some patch-list, and having a clear identity
> > > > on the sender is always a good idea in these things.
> > >
> > > I've been thinking that a "patches@kernel.org" dumping ground would be
> > > useful.
> > >
> > > This is NOT intended as a patch tracker.  This is NOT intended as a
> > > substitution for submitting the patch to you, but instead intended
> > > as a patch archive that doesn't go away.  We have seen linux-kernel
> > > archives come and go, or drop messages.  But a patch archive would be
> > > useful...  I'm not sure a mailing list proper is right for the job,
> > > since I want to support the reception and archiving of multi-megabyte
> > > patches at times.
> >
> > Exactly what I was thinking of: 'linux-patches@kernel.org'.  The idea is,
> > instead of putting [PATCH] on your subject line and cc'ing it to Linus, you
> > mail it to linux-patches with a cc to lkml if you like (depending on size of
> > patch, how interesting, etc).  In any event, linux-patches will forward a
> > copy to Linus.
> 
> You of course need something like -2.4 and -2.5.

Yes:

    linux-patches-2.0@kernel.org
    linux-patches-2.2@kernel.org
    linux-patches-2.4@kernel.org
    linux-patches-2.5@kernel.org

Now... conventions for the subject line?

By the way, this to me is really a 'bot'.  The bulk of the proposals in this
thread seem more like tools.

--
Daniel
