Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267725AbTBECjC>; Tue, 4 Feb 2003 21:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267727AbTBECjC>; Tue, 4 Feb 2003 21:39:02 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:33186
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267725AbTBECjB>; Tue, 4 Feb 2003 21:39:01 -0500
Date: Tue, 4 Feb 2003 21:47:23 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH][0/6] CPU Hotplug update + fixes 
In-Reply-To: <20030204065845.1D5612C157@lists.samba.org>
Message-ID: <Pine.LNX.4.50.0302042144180.5259-100000@montezuma.mastecende.com>
References: <20030204065845.1D5612C157@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2003, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0302030301120.9361-100000@montezuma.mastecende.com> y
> ou write:
> > Hi,
> > 	These patches are in no way an attempt to push this for inclusion, 
> > but instead a bit of grunt work to keep it current. However i would 
> > very much so like see it included in mainline.
> 
> Zwane, please send me your physical address so I can put you on my Christmas
> list 8)

=)

> I've stolen these, removed a couple of unrelated cleanups to shrink
> it, and put them on my page with you as author (and me as coauthor).

Hardly, i just resynced. Your code saved me a lot of time redoing the very 
same thing. So perhaps the converse is more appropriate ;)

> Here are the parts I pulled out (BTW, I'm missing 4/6: can you
> re-xmit?)

I will resend in a private mail, including a fix for mm/slab.c from 
Manfred.

Cheers,
	Zwane

