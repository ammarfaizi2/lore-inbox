Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSGEFyH>; Fri, 5 Jul 2002 01:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315437AbSGEFyG>; Fri, 5 Jul 2002 01:54:06 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:49906 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315431AbSGEFyF>;
	Fri, 5 Jul 2002 01:54:05 -0400
Date: Fri, 5 Jul 2002 01:56:38 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] raid kdev_t cleanups (part 1)
In-Reply-To: <15653.9247.110730.4440@notabene.cse.unsw.edu.au>
Message-ID: <Pine.GSO.4.21.0207050151060.14718-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Jul 2002, Neil Brown wrote:

> On Friday July 5, viro@math.psu.edu wrote:
> > > could you hold off a few days until I get it
> > > submitted so that I don't have to re-merge??
> > 
> > Damn.  I've just sent the last one raid-related one...
> > 
> > OK...  Mind if I do that merge?  Just send them to me, I'll do the merge
> > tonight and send them back for your approval ASAP.
> 
> That's fine with me... I have 19 patches.  Some duplicate some of
> yours.  Others will have substantial non-trivial rejects, largely due
> to your diskop changes.
> 
> I'll send them in subsequent Emails (others can view at
> http://www.cse.unsw.edu.au/~neilb/patches/linux-devel/2.5.24a/

Got them, will do.  Looks like they allow to do several things I wanted,
so I'll probably follow them with a couple of additional patches (after
I merge yours, that is).  Very nice - looks like md/* is getting into
saner shape after all.  Now, if some brave soul would sanitize the horrors
in lvm*.c... (hint, hint)

