Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314941AbSDVX1v>; Mon, 22 Apr 2002 19:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314942AbSDVX1u>; Mon, 22 Apr 2002 19:27:50 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:60375 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S314941AbSDVX1t>;
	Mon, 22 Apr 2002 19:27:49 -0400
Date: Mon, 22 Apr 2002 19:27:48 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        dean gaudet <dean-list-linux-kernel@arctic.org>,
        Larry McVoy <lm@bitmover.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: There is no cabal (was: the BK flamewar)
Message-ID: <20020422192748.A22119@havoc.gtf.org>
In-Reply-To: <20020422181742.A17575@havoc.gtf.org> <Pine.LNX.4.44.0204221548550.1578-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2002 at 04:22:29PM -0700, Davide Libenzi wrote:
> On Mon, 22 Apr 2002, Jeff Garzik wrote:
> 
> > On Mon, Apr 22, 2002 at 03:04:19PM -0700, Davide Libenzi wrote:
> > > On Mon, 22 Apr 2002, Jeff Garzik wrote:
> > >
> > > > The real question, as I understand it, is whether or not the kernel doc
> > > > should be in the kernel source or not.  If the answer is 'no', then I
> > > > fully support making it a URL, or printing it out the back of
> > > > phonebooks, or whatever means of distribution :)
> > >
> > > i really tried to remain out of this. in theory, like Linus said, we
> > > should not even know that he's using bk. it should be completely hidden.
> > > the only method described inside the kernel tarbal should be the
> > > old diff+patch one. main maintainers ( i mean the group of at most 10 that
> > > are handling huge number of patches and that are highly interacting with
> > > Linus ) will very likely get benefits from using bk instead of diff+patch,
> > > but for these one no doc is necessary. either they know or Larry can
> > > provide them with all the docs they need. for all the remaining crew, bk
> > > adoption is simply a trend followup.
> >
> > Nope, the kernel doc was created precisely for the kernel maintainers,
> > cuz most of them (like me) had no clue about how to use BK nicely
> > for the kernel.  Honestly, we were all lazy (except the PPC guys
> > and GregKH, I guess :)) and let Linus figure out kernel development
> > under BK.
> >
> > If we attempt to pretend that BK is not widely usage, you do a
> > dissservice to other kernel developers, sysadmins, and power users --
> > and possibly _increase_ the barrier to entry of the "group of at most
> > 10" you describe above.
> >
> > That "10" does not need do, and should never be, an exclusive club...
> > it just sorta evolved over time as the people who work best with
> > Linus.  I want to spread knowledge about working well with Linus
> > as far and as wide as possible -- that benefits all Linux users,
> > and open source overall.
> 
> Jeff, did you really mean this ?
> 
> "If we attempt to pretend that BK is not widely usage ..."
> 
> It did not seem to me that Linus required BK to interact with him. So to
> be or not to be inside the above group does not depend at all from BK
> usage. BK can make life a lot easier for guys handling huge number of
> patches with complex hierarchies, but forcing the one working with 1-5
> patches to use it, it reflects the "trend followup" i was talking about.

If you read that from what I wrote, you are mistaken...

I'm saying that removing the BK doc from the kernel sources removes
description of one, _optional_ avenue to Linus.  That is denying
people information.

Which is completely contrary to one of my goals, spreading knowledge
about working with Linus to decrease the barrier of entry.

BK is not a requirement, even for regular submittors.  Optional.

	Jeff



