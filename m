Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266805AbTAZJ52>; Sun, 26 Jan 2003 04:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266806AbTAZJ52>; Sun, 26 Jan 2003 04:57:28 -0500
Received: from tomts19.bellnexxia.net ([209.226.175.73]:1153 "EHLO
	tomts19-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S266805AbTAZJ52>; Sun, 26 Jan 2003 04:57:28 -0500
Date: Sun, 26 Jan 2003 05:05:47 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: restructuring of filesystems config menu
In-Reply-To: <3E331AA2.38F99839@verizon.net>
Message-ID: <Pine.LNX.4.44.0301260503040.27173-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jan 2003, Randy.Dunlap wrote:

> Hi,
> 
> > Date: Sun, 12 Jan 2003 07:57:33 -0500 (EST)
> > From: Robert P. J. Day <rpjday@mindspring.com>
> > Subject: restructuring of filesystems config menu
> > 
> >   i've attached a gzipped patch against 2.5.56 for reorganizing
> > the filesystem menu under "make xconfig", and i'm certainly
> > open to feedback/comments/criticism/large sums of money.
> 
> I finally looked at this on 2.5.59.  The fs menu certainly
> needs some help/work, so I'd like to see you keep plugging away
> at this.  I didn't see much feedback -- was there feedback?
> Maybe on a different subject/thread?  A newer version that I
> missed?

nope, didn't get much feedback.  i sent the patch directly to 
linus but it hasn't yet been added.  perhaps in 2.5.60?

> I find it odd that "help" in a Kconfig file can be spelled
> "help" or "---help---", but "--help--" leads to errors.

i did notice some strange parsing rules there.

> I expected to just see the filesystems listed in alpha order,
> but I don't have a problem with the groupings that you
> have made for them.

i thought about alphabetical order, but i settled on the more
common options at the top, and the more obscure ones further
down.

if i don't see a patch incorporated in a subsequent release, am
i supposed to submit it again?  what's the proper protocol?

rday

