Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129809AbQKINkj>; Thu, 9 Nov 2000 08:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130738AbQKINkd>; Thu, 9 Nov 2000 08:40:33 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:25101 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S130737AbQKINkZ>; Thu, 9 Nov 2000 08:40:25 -0500
Date: Thu, 9 Nov 2000 14:40:22 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <3A0AA063.DD5AB6D0@holly-springs.nc.us>
Message-ID: <Pine.LNX.4.21.0011091419240.17276-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2000, Michael Rothwell wrote:

> Alexander Viro wrote:
> > 
> > On Thu, 9 Nov 2000, Michael Rothwell wrote:
> > 
> > > Same as before -- freedom and low cost. The primary advantae of Linux
> > > over other OSes is the GPL.
> > 
> > Now, that's more than slightly insulting...
> 
> Well, it wasn't meant to be. I imagine RMS would make the same type of
> statement -- Linux is libre, therefore superior. There's a number of
> OSes that have advantages of Linux in some area; Solaris can use more
> processors; QNX is real-time, smaller and still posix; Windows has
> better application support (i.e., more of them); MacOS has better color
> and font management. But, Linux is free. Let's say for a moment that
> Linux was exactly the same as Solaris, technically. Linux would be
> superior because it is licensed under the GPL, and is free; whereas
> Solaris would not be.

<lurker off>
Sorry, I couldn't resist.

1) "Solaris running on more processors"? Think of Beowulf clusters.
   Strangely enough, people running them choose Linux as the kernel.
2) "QNX is real-time", true. Linux is not. Please don't compare apples with
   oranges.
3) "Windows has more apps"? True. Is it a kernel property of any kind? No.
4) "MacOS has better color and font management" this is funny as it speaks
   for itself. I'd also add "MacOS is usually housed in a better-looking
   case". Luckily enough, under Linux color and font management is NOT a
   kernel job. No more than the external design of the case, I mean.

And I really hope Linux will *never* be exactly the same as Solaris,
technically.
</lurker on>

> > The problem with the hooks et.al. is very simple - they promote every
> > bloody implementation detail to exposed API. Sorry, but... See Figure 1.
> > It won't fly.
> 
> Figure 1?

>From "The design and implementation of the Perfect OS 1.0", yet to be
published. The good thing about this book is that there will never be
a second edition. Of course the only release of Perfect OS will be 1.0!
B-) B-) B-) B-)

> 
> -M
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
