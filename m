Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267638AbUH0Vso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267638AbUH0Vso (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 17:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268381AbUH0VlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 17:41:11 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:46352 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S267758AbUH0VeO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 17:34:14 -0400
Date: Fri, 27 Aug 2004 14:33:31 -0700
To: Linus Torvalds <torvalds@osdl.org>
Cc: Markus T?rnqvist <mjt@nysv.org>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com, bhuey@lnxw.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040827213331.GA4468@nietzsche.lynx.com>
References: <412D9FE6.9050307@namesys.com> <200408261812.i7QICW8r002679@localhost.localdomain> <20040827203216.GC1284@nysv.org> <Pine.LNX.4.58.0408271335421.14196@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408271335421.14196@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040818i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 01:38:28PM -0700, Linus Torvalds wrote:
> Heh. Considering that WinFS seems to be delayed yet more, I don't think 
> that's a very strong argument.

Which is another argument, and bragging rights, to integrate something
like Reiser FS4. :)

> Hell will freeze over before Microsoft does a filesystem right. Besides,
> WinFS is likely almost in user mode anyway, ie mostly a library, rather
> like the gnome people are already doing with nome storage.

They're trying to push their low level storage model into the kernel
after they saw how slow their userspace version of that is. It makes
sense to have this kind of stuff directly apart of a lower level FS
later
 
> So there's really no point in trying to push your agenda by trying to 
> scare people with MS activities. Linux kernel developers do what's right 
> because it is _right_, not because somebody else does it.

I tried to stay out of this thread, but I couldn't resist after this
post. :) MS has other problems, namely, they're a large company trying
to basically replicated Apple's (NeXT) OS X stuff, but onl 10x larger
and slower than it is. It's really silly what's going on with MS
development as well as the greater open source X community. The sooner
folks realize that all rendering models are moving in the direction of
Apple's OS X, the sooner they can just flat out rip it off.

It's going to require both kernel and userspace changes for this to
happen.

bill

