Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129894AbQLNXmv>; Thu, 14 Dec 2000 18:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129870AbQLNXmk>; Thu, 14 Dec 2000 18:42:40 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:22022 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129784AbQLNXmd>; Thu, 14 Dec 2000 18:42:33 -0500
Date: Thu, 14 Dec 2000 15:11:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Bernhard Rosenkraenzer <bero@redhat.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Signal 11
In-Reply-To: <Pine.LNX.4.30.0012142351520.19104-100000@bochum.redhat.de>
Message-ID: <Pine.LNX.4.10.10012141507070.12451-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2000, Bernhard Rosenkraenzer wrote:
> >
> > gcc-2.95.2 is at least a real release, from a branch that is actively
> > maintained
> 
> Not very actively.
> Please take the time to compare the activity in gcc_2_95_branch with the
> patches in the current "2.96" version in rawhide.

Take a look at the differences in linux-2.2.x and linux-2.3.x.

linux-2.3.x is was a h*ll of a lot more "actively maintained".

But nobody really considers that to be an argument for RedHat (or anybody
else) to installa 2.3.x kernel by default. Sure, most distributions have a
"hacker kernel", but it's NOT installed by default, and it is clearly
marked as experimental.

Your arguments make no sense.

The compiler is often _more_ important to system stability than the
kernel. A "real release" implies that it at least had testing, and that
people know what the problem spots tend to be.

Note that the "know what the problem spots tend to be" is important.

> > As to X compile problems - neither egcs nor 2.95.2 appears to have any
> > trouble with the CVS tree.
> 
> Neither does 2.96-68.

Good. Maybe you'd make it clearer to everybody who installed from your
CD's that they had better upgrade. Pronto.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
