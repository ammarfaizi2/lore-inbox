Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316591AbSFGCnG>; Thu, 6 Jun 2002 22:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSFGCnF>; Thu, 6 Jun 2002 22:43:05 -0400
Received: from dsl-213-023-043-086.arcor-ip.net ([213.23.43.86]:40915 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316591AbSFGCnE>;
	Thu, 6 Jun 2002 22:43:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Mark Mielke <mark@mark.mielke.cc>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Date: Fri, 7 Jun 2002 04:42:18 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206042132450.2614-100000@waste.org> <20020606212100.GA1113@elf.ucw.cz> <20020606213551.A3551@mark.mielke.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17G9hi-0002Qh-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 June 2002 03:35, Mark Mielke wrote:
> On Thu, Jun 06, 2002 at 11:21:00PM +0200, Pavel Machek wrote:
> > > > What you really want for an MP3 player is _not_ hard RT, what you want is
> > > > very reliable low-latency. Which we can do without throwing away most of
> > > > UNIX.
> > > I think that depends on whether you are an audiophile or not.  Or a
> > > broadcaster.  If you're a broadcaster, how many mp3 skips will you
> > > tolerate
> > 10 skips a year is probably okay for broadcaster, "normal" stations
> > using cds are worse than that.
> 
> Also, unless one plans on playing 10+ .mp3's simulataneously on the
> same piece of hardware, I would make a bet that the electric company,
> or the computer itself would 'skip' before the dedicated computer
> 'skipped'. In either case, real time, or no real time, the system will
> skip.

You're both being silly.  The point is not mp3 skips per year, the point is:
is anything less than perfection tolerable, when you know perfection is within
reach?  If it helps, forget I ever said 'mp3' and think 'signal processing'
instead.

I'll go further and say we need realtime processing in our desktops, not
only for signal processing but for more mundane things like moving the mouse
cursor smoothly (yes, this is another item that sucks in Linux).  Sorry, I'm
a perfectionist, and I like precision.  If you're not and you don't, just
say so, and we'll understand each other perfectly.

OK, I'm done with the 'do we really need realtime' FAQ item.

-- 
Daniel
