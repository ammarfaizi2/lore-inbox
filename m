Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSFGBm0>; Thu, 6 Jun 2002 21:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316600AbSFGBmZ>; Thu, 6 Jun 2002 21:42:25 -0400
Received: from mark.mielke.cc ([216.209.85.42]:55303 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S316599AbSFGBmY>;
	Thu, 6 Jun 2002 21:42:24 -0400
Date: Thu, 6 Jun 2002 21:35:51 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Pavel Machek <pavel@ucw.cz>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Message-ID: <20020606213551.A3551@mark.mielke.cc>
In-Reply-To: <Pine.LNX.4.44.0206042132450.2614-100000@waste.org> <E17FQzQ-0001T2-00@starship> <20020606212100.GA1113@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2002 at 11:21:00PM +0200, Pavel Machek wrote:
> > > What you really want for an MP3 player is _not_ hard RT, what you want is
> > > very reliable low-latency. Which we can do without throwing away most of
> > > UNIX.
> > I think that depends on whether you are an audiophile or not.  Or a
> > broadcaster.  If you're a broadcaster, how many mp3 skips will you
> > tolerate
> 10 skips a year is probably okay for broadcaster, "normal" stations
> using cds are worse than that.

Also, unless one plans on playing 10+ .mp3's simulataneously on the
same piece of hardware, I would make a bet that the electric company,
or the computer itself would 'skip' before the dedicated computer
'skipped'. In either case, real time, or no real time, the system will
skip.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

