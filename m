Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315341AbSDWUk7>; Tue, 23 Apr 2002 16:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315323AbSDWUjh>; Tue, 23 Apr 2002 16:39:37 -0400
Received: from [195.39.17.254] ([195.39.17.254]:16271 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S315341AbSDWUj0>;
	Tue, 23 Apr 2002 16:39:26 -0400
Date: Sun, 21 Apr 2002 23:08:43 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rob Landley <landley@trommello.org>, Alexander Viro <viro@math.psu.edu>,
        Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org
Subject: Re: BK, deltas, snapshots and fate of -pre...
Message-ID: <20020421230842.E155@toy.ucw.cz>
In-Reply-To: <20020421081224.6B6C547B@merlin.webofficenow.com> <Pine.LNX.4.44.0204211136590.17272-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The well-defined resync points are the 2.5.N releases.  If -pre goes away,
> > then the dot-releases might need to come a little closer together, that's all.
> 
> I agree.
> 
> I've told myself that I shouldn't have done "-preX" releases at all in
> 2.5.x - the "real" numbers have become diluted by them, and I suspect the
> -pre's are really just because I got used to making them during the
> over-long 2.4.x time.

I believe -pre's are still important. Daily snapshots are too likely to be
broken, and "real" releases are different from -pre ones (with *usefull*
difference): you can ignore -pre release, but you can't ignore real release
(because real releases are relative to each other).

Having slightly more frequent real releases would be nice, but I believe
it is not feasible to make them as common as pre- patches.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

