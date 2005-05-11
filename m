Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVEKAfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVEKAfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 20:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVEKAfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 20:35:11 -0400
Received: from mail.dif.dk ([193.138.115.101]:44940 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261860AbVEKAfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 20:35:03 -0400
Date: Wed, 11 May 2005 02:38:58 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace
 cleanup)
In-Reply-To: <20050510172913.2d47a4d4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0505110236520.2386@dragon.hyggekrogen.localhost>
References: <20050510161657.3afb21ff.akpm@osdl.org>
 <20050510.161907.116353193.davem@davemloft.net> <20050510170246.5be58840.akpm@osdl.org>
 <20050510.170946.10291902.davem@davemloft.net>
 <Pine.LNX.4.62.0505110217350.2386@dragon.hyggekrogen.localhost>
 <20050510172913.2d47a4d4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2005, Andrew Morton wrote:

> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >
> > I'll need time to do this - no matter how you cut it there are a lot of 
> >  files, and a lot of lines - so don't expect the patch bombing to start for 
> >  the next few weeks.
> >  And before I embark on this venture I'd like some feedback that when I do 
> >  turn up with patches they'll have a resonable chance of getting merged - 
> >  this is going to be a lot of boring work, and with no commitment to merge 
> >  anything it's not something I want to waste days on...  Sounds fair?
> 
> ho hum.  Just send them over as you generate them.
> 
Ok, I'll try and split the tree into some sane chunks and you'll get the 
patches in a steady stream.. Expect the first few in a few days.

> >  Ohh, and I'd be submitting all the patches to you Andrew, not individual 
> >  maintainers/authors..
> 
> That should be OK - you can test that the .o files have the same `size'
> output before-and-after.
> 
> The changes shouldn't break any subsystem maintainers' trees, although they
> will surely trip up individual developers who are working on stuff, so
> please make some attempt to keep the relevant people in the loop.
> 
Ok, will do.

-- 
Jesper


