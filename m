Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283286AbRLUXLR>; Fri, 21 Dec 2001 18:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282690AbRLUXLE>; Fri, 21 Dec 2001 18:11:04 -0500
Received: from waste.org ([209.173.204.2]:63627 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S282453AbRLUXKz>;
	Fri, 21 Dec 2001 18:10:55 -0500
Date: Fri, 21 Dec 2001 17:10:20 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Dan Kegel <dkegel@ixiacom.com>, <linux-kernel@vger.kernel.org>
Subject: re: Linux 2.4.17
In-Reply-To: <Pine.LNX.4.21.0112211744080.7492-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.43.0112211536430.16844-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2001, Marcelo Tosatti wrote:

> > > Here it is...
> > >
> > >
> > > final:
> > >
> > > - Fix more loopback deadlocks                   (Andrea Arcangeli)
> > > - Make Alpha with Nautilus chipset and
> > >   Irongate chipset configuration compile
> > >   correctly                                     (Michal Jaegermann)
> >
> > Um, what happened to the idea of 'no changes between the last
> > release candidate and final'?
>
> I haven't said that, did I?

No, but it's a good idea. There's always the risk of breaking something
and you don't want to introduce a disk-eating bug between -rc and -final.
It's better to ship one more -rc and wait a day before -final. If you
don't, people will just get in the habit of waiting a day after -final to
be safe.

> I said I would make -rc kernels which would not add any new _feature_.

That's less important.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

