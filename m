Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314674AbSDTRgM>; Sat, 20 Apr 2002 13:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314675AbSDTRgK>; Sat, 20 Apr 2002 13:36:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19217 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314674AbSDTRgF>; Sat, 20 Apr 2002 13:36:05 -0400
Date: Sat, 20 Apr 2002 10:35:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Jeff Garzik <garzik@havoc.gtf.org>, Roman Zippel <zippel@linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
In-Reply-To: <E16yc0t-0000VL-00@starship>
Message-ID: <Pine.LNX.4.44.0204201023490.19512-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Apr 2002, Daniel Phillips wrote:
>
> But did you think it might be controversial?

Ehh, the documentaion? Nope, I didn't really think _that_ part would be
controversial.

The change to BK? I sure as hell knew that was going to be "interesting",
yes absolutely. After all, it had been discussed at places like the kernel
summit etc.

But hey - I've never really cared about what other people think about what
I do. If I had, I'd have given up on Linux when Tanenbaum ridiculed it. Or
I wouldn't have done the big dentry change (which was a total disaster in
some peoples minds) in 2.1.x. Or the VM changeover in the middle of 2.4.x.
Or a million other things.

I do what _I_ think is right for the kernel, and while I tend to poll
people and listen to them, when the sh*t hits the fan it is _my_ decision.

You can't please everybody. And usually if you _try_ to please everybody,
the end result is one big mess.

		Linus

