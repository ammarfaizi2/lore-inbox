Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289621AbSBXEzt>; Sat, 23 Feb 2002 23:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289655AbSBXEzj>; Sat, 23 Feb 2002 23:55:39 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:20229
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S289643AbSBXEzV>; Sat, 23 Feb 2002 23:55:21 -0500
Date: Sat, 23 Feb 2002 20:42:37 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <Pine.LNX.4.33.0202230953290.14299-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10202232035190.5715-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Feb 2002, Linus Torvalds wrote:

> 
> On Fri, 22 Feb 2002, Andre Hedrick wrote:
> > 
> > Obvious you have a bug up the backside
> 
> Yes.
> 
> What really bugs me about this is that while normally you're hard to
> communicate with, this time you have actively _lied_ about the patches on
> IRC and in email about how they will cause IDE corruption etc due to
> timing changes.

Before I truley reply to this statement above, would you like to recant it?

> No such timing changes existed, and whenever you were asked about what was
> actually actively _wrong_ with the patches, you didn't reply.

Here I question the taking of a patch 12 which altered the behavior of the
subsystem baseclock to setting up PIO timings for the executing command
block operations.  I then looked over the patch again and saw you had not
taken it yet.

In that private email, I clearly stated I made a mistake in reading what
was accepted into 2.5.5.  The fact is you had not accepted it yet.
However I expect you will take it.  Given that very few people in the
world have most of the hardware that was effected by that change, and even
less have the NDA documents on the rules, please accept the change.

> There's a difference between being difficult to work with and being 
> actively dishonest, and you crossed that line.

If this line has be crossed it is because you have moved and altered that
which is defined as truth.  You by now are having other people question
your position on issues, and I will leave it at that ...

Regards,


Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

