Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286186AbRLJHzn>; Mon, 10 Dec 2001 02:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286187AbRLJHzd>; Mon, 10 Dec 2001 02:55:33 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:20474 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S286186AbRLJHzU>; Mon, 10 Dec 2001 02:55:20 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Stevie O <stevie@qrpff.net>, linux-kernel@vger.kernel.org
Date: Sun, 9 Dec 2001 23:30:05 -0800 (PST)
Subject: Re: "Colo[u]rs"
In-Reply-To: <20011209235126.J25754@work.bitmover.com>
Message-ID: <Pine.LNX.4.40.0112092329080.4915-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Dec 2001, Larry McVoy wrote:

> On Sun, Dec 09, 2001 at 11:21:23PM -0800, David Lang wrote:
> > Larry, I thought that direct mapped caches had full mapping from any cache
> > address to any physical address while the N-way mapped caches were more
> > limited. modern caches are N-way instead of direct mapped becouse it's
> > much more expensive (transistor count wise) for the direct mapped
> > approach.
>
> That's not correct unless they changed terminology without asking my
> permission :-)  A direct mapped cache is the same as a 1-way set
> associative cache.  It means each cache line has one and only one
> place it can be in the cache.  It also means there is only one set
> of tag comparitors, which makes it cheaper and easier to build.
>
> > If I'm mistaken about my termonology (very possible :-) what is the term
> > for what I am refering to as direct mapped?
>
> Fully associative cache, I believe.

Yep, that's it. thanks for the correction.

David Lang
