Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSH0WU1>; Tue, 27 Aug 2002 18:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSH0WU0>; Tue, 27 Aug 2002 18:20:26 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:3851 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S315483AbSH0WU0>;
	Tue, 27 Aug 2002 18:20:26 -0400
Date: Wed, 28 Aug 2002 00:24:40 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Christoph Hellwig <hch@infradead.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] XFree v4.2.x DRM/DRI Support for 2.4.20-pre4
Message-ID: <20020827222440.GC28513@alpha.home.local>
References: <200208272247.26637.m.c.p@gmx.net> <20020827222740.A6591@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020827222740.A6591@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 10:27:40PM +0100, Christoph Hellwig wrote:
> On Tue, Aug 27, 2002 at 10:54:50PM +0200, Marc-Christian Petersen wrote:
> > Hi there,
> > 
> > this adds DRM/DRI Support for recent versions of XFree, f.e. v4.2.0 with a 
> > slight modification. If you select SiS DRM Module, you also have to select 
> > FrameBuffer SiS support otherwise it will result in unresolved symbols or 
> > linking failure.
> 
> Don't do this.   Alan already has a sane version in his tree which I've made
> ready for and sent to Marcelo.  It wouldn't hurt if you read lkml..
> 
> The patch you posted is the crap directly from the XFfree repo and backs out
> kernel changes.  It might be enough for a random collection of junk patches
> but certainly does not meet the quality criteria for official kernels.

Christoph,

why do you always feel the need to discourage people who offer their
contribution ? Your two first sentences are quite enough to let Marc-Christian
understand that his patch isn't as good as YOURS. The rest of the mail is pure
gratuitous insults, just like every other mail you send these times (except
those in which you compliment yourself). Since a few weeks, each time I see
a mail from you, before opening it, I ask to myself "well, who is he killing
today ?".

Perhaps you're fed up with crap in the kernel, but IMHO that's not this way
that you'll get rid of it. This list is a developper's list, so it tends to
be constructive by nature. So please be a little more tolerant with other
people, particularly when they are contributing.

Thanks for your attention,
Willy

