Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314929AbSDVXOf>; Mon, 22 Apr 2002 19:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314930AbSDVXOe>; Mon, 22 Apr 2002 19:14:34 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:43420 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S314929AbSDVXOb>; Mon, 22 Apr 2002 19:14:31 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 22 Apr 2002 16:22:29 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jeff Garzik <garzik@havoc.gtf.org>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        dean gaudet <dean-list-linux-kernel@arctic.org>,
        Larry McVoy <lm@bitmover.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: There is no cabal (was: the BK flamewar)
In-Reply-To: <20020422181742.A17575@havoc.gtf.org>
Message-ID: <Pine.LNX.4.44.0204221548550.1578-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2002, Jeff Garzik wrote:

> On Mon, Apr 22, 2002 at 03:04:19PM -0700, Davide Libenzi wrote:
> > On Mon, 22 Apr 2002, Jeff Garzik wrote:
> >
> > > The real question, as I understand it, is whether or not the kernel doc
> > > should be in the kernel source or not.  If the answer is 'no', then I
> > > fully support making it a URL, or printing it out the back of
> > > phonebooks, or whatever means of distribution :)
> >
> > i really tried to remain out of this. in theory, like Linus said, we
> > should not even know that he's using bk. it should be completely hidden.
> > the only method described inside the kernel tarbal should be the
> > old diff+patch one. main maintainers ( i mean the group of at most 10 that
> > are handling huge number of patches and that are highly interacting with
> > Linus ) will very likely get benefits from using bk instead of diff+patch,
> > but for these one no doc is necessary. either they know or Larry can
> > provide them with all the docs they need. for all the remaining crew, bk
> > adoption is simply a trend followup.
>
> Nope, the kernel doc was created precisely for the kernel maintainers,
> cuz most of them (like me) had no clue about how to use BK nicely
> for the kernel.  Honestly, we were all lazy (except the PPC guys
> and GregKH, I guess :)) and let Linus figure out kernel development
> under BK.
>
> If we attempt to pretend that BK is not widely usage, you do a
> dissservice to other kernel developers, sysadmins, and power users --
> and possibly _increase_ the barrier to entry of the "group of at most
> 10" you describe above.
>
> That "10" does not need do, and should never be, an exclusive club...
> it just sorta evolved over time as the people who work best with
> Linus.  I want to spread knowledge about working well with Linus
> as far and as wide as possible -- that benefits all Linux users,
> and open source overall.

Jeff, did you really mean this ?

"If we attempt to pretend that BK is not widely usage ..."

It did not seem to me that Linus required BK to interact with him. So to
be or not to be inside the above group does not depend at all from BK
usage. BK can make life a lot easier for guys handling huge number of
patches with complex hierarchies, but forcing the one working with 1-5
patches to use it, it reflects the "trend followup" i was talking about.




- Davide







