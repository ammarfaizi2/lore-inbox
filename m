Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267079AbTA0ASC>; Sun, 26 Jan 2003 19:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267080AbTA0ASC>; Sun, 26 Jan 2003 19:18:02 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:1988 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP
	id <S267079AbTA0ASB>; Sun, 26 Jan 2003 19:18:01 -0500
Message-ID: <3E347C84.8854075A@verizon.net>
Date: Sun, 26 Jan 2003 16:25:40 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: restructuring of filesystems config menu
References: <Pine.LNX.4.44.0301260503040.27173-100000@dell>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [4.64.238.61] at Sun, 26 Jan 2003 18:27:13 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert P. J. Day" wrote:
> 
> On Sat, 25 Jan 2003, Randy.Dunlap wrote:
> 
> > Hi,
> >
> > > Date: Sun, 12 Jan 2003 07:57:33 -0500 (EST)
> > > From: Robert P. J. Day <rpjday@mindspring.com>
> > > Subject: restructuring of filesystems config menu
> > >
> > >   i've attached a gzipped patch against 2.5.56 for reorganizing
> > > the filesystem menu under "make xconfig", and i'm certainly
> > > open to feedback/comments/criticism/large sums of money.
> >
> > I finally looked at this on 2.5.59.  The fs menu certainly
> > needs some help/work, so I'd like to see you keep plugging away
> > at this.  I didn't see much feedback -- was there feedback?
> > Maybe on a different subject/thread?  A newer version that I
> > missed?
> 
> nope, didn't get much feedback.  i sent the patch directly to
> linus but it hasn't yet been added.  perhaps in 2.5.60?

It doesn't apply cleanly to 2.5.59 or later, so it won't be
applied.

> > I expected to just see the filesystems listed in alpha order,
> > but I don't have a problem with the groupings that you
> > have made for them.
> 
> i thought about alphabetical order, but i settled on the more
> common options at the top, and the more obscure ones further
> down.
> 
> if i don't see a patch incorporated in a subsequent release, am
> i supposed to submit it again?  what's the proper protocol?

Get feedback (as much as possible), act on feedback -> make
changes, re-re-re-submit...

~Randy
