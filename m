Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263346AbSJFG3h>; Sun, 6 Oct 2002 02:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263347AbSJFG3h>; Sun, 6 Oct 2002 02:29:37 -0400
Received: from franka.aracnet.com ([216.99.193.44]:57528 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263346AbSJFG3g>; Sun, 6 Oct 2002 02:29:36 -0400
Date: Sat, 05 Oct 2002 23:33:00 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Rob Landley <landley@trommello.org>,
       Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Message-ID: <1249408133.1033860778@[10.10.2.3]>
In-Reply-To: <200210060130.g961UjY2206214@pimout2-ext.prodigy.net>
References: <200210060130.g961UjY2206214@pimout2-ext.prodigy.net>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux isn't going to get  a new order of magnitude surge from the 
> server space, because there isn't an order of magnitude left.  

Depends on how you define the word "server". If you mean a PC being
a webserver, I'd agree. If you mean "large database server", I wouldn't. 
The term is so broad as to be useless in this context.

> The new uncharted territory for Linux, and the next major 
> order-of-magnitude jump in the installed base, is the desktop.  
> A kernel that could make a credible stab at the desktop  would 
> certainly be 3.0 material. And the work that matters for the 
> desktop  is LATENCY work.  Not SMP, not throughput, not more memory.
> Latency.  O(1), deadline I/O scheduler, rmap, preempt, shorter 
> clock ticks, 

I'd agree there are definitely some improvements to be made in this
space. My laptop skipping on xmms whilst I compile the kernel pisses
me off. But that's not why Linux is not sucessful on the the desktop 
...

> Yeah, a lot of the necessary work is user space stuff.  

... that is. Userspace sucks. X-windows is a pig, and a monumental 
pain in the ass to configure - I've been doing it for 10 years, and
I still hate it every single damned time I have to do it. After  
years of utter crap I finally have a browser that more or less 
works (Galeon, yay), though it still has some stupid annoying bugs. 
Fonts are still a pain. Laptops are a minefield of turd-covered 
banana skins.

Yeah, I may play with the kernel all day, can debug stuff if I have 
to, and can figure out how to set things up by staring at documentation
or source code for ages if it's really necessary. But I don't want to.
I want things that are easy to use for the basic stuff, and just 
frigging work out of the box. I don't want to be asked bunches of 
questions that really don't matter that much perioidically throughout
a Debian install. Spending all day playing with desktop nonsense isn't
fun, I just want to get on with real work.

It's getting better. But the reason Linux is not a desktop hit has
very little to do with interactive scheduler response, or other kernel
niceties. The kernel blows the competition out of the water, even if 
it does have a few problems here and there. It's to do with applications,
proprietary file formats, and commercial support.

> important, but in reality an awful lot of the windows "look and feel" 
> issues boil down to the simple fact that enough of their windowing 
> system is welded into the kernel that their mouse pointer keeps 
> updating smoothly no matter how  heavily loaded the system is, 
> and when you click on a window its Z-order gets  promoted snappily 
> under just about all circumstances.  That's it. 

Pft. What OS are you talking about here? Surely not Microsoft?
Send me your copy, it's obviously very different from mine.
 
> (P.S.  The fact Apple's conditioning the market to take unix 
> seriously on the desktop with OS X is just a case of convenient 
> timing.

You really think the market gives a damn that there's UNIX underneath
the hood of Apple machines? I beg to differ. They like the fact that
it actually works, and can really multitask, maybe ... which is an
indirect effect. But they don't care (on the whole) about the fact 
that it's UNIX.

M.
