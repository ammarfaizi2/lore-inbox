Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbTBEXxZ>; Wed, 5 Feb 2003 18:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265198AbTBEXxZ>; Wed, 5 Feb 2003 18:53:25 -0500
Received: from mako.theneteffect.com ([63.97.58.10]:27153 "EHLO
	mako.theneteffect.com") by vger.kernel.org with ESMTP
	id <S265197AbTBEXxY>; Wed, 5 Feb 2003 18:53:24 -0500
From: Mitch Adair <mitch@theneteffect.com>
Message-Id: <200302060002.SAA28514@mako.theneteffect.com>
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
To: lm@bitmover.com (Larry McVoy)
Date: Wed, 5 Feb 2003 18:02:59 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030205235126.GA21064@work.bitmover.com> from "Larry McVoy" at Feb 05, 2003 03:51:26 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Feb 06, 2003 at 12:45:55AM +0000, Alan Cox wrote:
> > On Wed, 2003-02-05 at 23:31, Larry McVoy wrote:
> > > > (BTW, Larry, the bk binaries segfault on my (glibc 2.3.1) i686 system. Any
> > > > chance we could see binaries linked against 2.3.x? There's NSS badness between
> > > > 2.2 and 2.3 that causes even static binaries to segfault ... )
> > > 
> > > Yes, NSS in glibc is the world's worst garbage.  Glibc segfaults if there
> > > is no /etc/nsswitch.conf.  Nice.
> > 
> > bugzilla is your friend
> 
> Excuse my ignorance but how is that going to help me?  I know the problem
> and the work around so is there some magic voodoo chant in a bugzilla db
> someplace which will make glibc not segfault without changing the system?

Yes!  Say it with me:

"I will let someone know so they can fix it.  Shazam!"

:))

	M
