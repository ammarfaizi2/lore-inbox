Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261436AbSJUOlL>; Mon, 21 Oct 2002 10:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261389AbSJUOlL>; Mon, 21 Oct 2002 10:41:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61361 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261436AbSJUOlK>;
	Mon, 21 Oct 2002 10:41:10 -0400
Date: Mon, 21 Oct 2002 16:46:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crunch time continues: the merge candidate list v1.1
Message-ID: <20021021144656.GF11594@suse.de>
References: <200210202303.46848.landley@trommello.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210202303.46848.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20 2002, Rob Landley wrote:
> Okay, I've got Rusty's list collated with my list, plus several replies to
> each thread.
> 
> There is no WAY all of this is making it into the 2.5 tree before the freeze,
> but this is what's currently being submitted for consideration.

One thing that at least has to make it in for generic cd recording to be
useful, is my sgio patches. Latest dump of just that is here:

*.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.44/

Same ones as posted under the 'zero copy dma cd writing and ripping' the
other day, however patch also fixes several races and just plain sloppy
code (sorry Linus). So that's pretty much a given.

Some of the items on this list seems to be more driven by naive
corporate hope rather than reality...

Oh, and why

> 9) Hans Reiser said:
> 
> > We will send Reiser4 out soon, probably around the 27th.
> >
> > Hans

Hans thinks there's a chance in hell that anyone would want to merge
code that's never actually been posted anywhere yet (do correct me if
I'm wrong, but not even Hans gave me a straight answer on that one) is
beyond me.

-- 
Jens Axboe

