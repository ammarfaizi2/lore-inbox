Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262863AbSJAXWm>; Tue, 1 Oct 2002 19:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262853AbSJAXWm>; Tue, 1 Oct 2002 19:22:42 -0400
Received: from cibs9.sns.it ([192.167.206.29]:60682 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S262863AbSJAXWS>;
	Tue, 1 Oct 2002 19:22:18 -0400
Date: Wed, 2 Oct 2002 01:25:58 +0200 (CEST)
From: venom@sns.it
To: Matthias Andree <matthias.andree@gmx.de>
cc: linux-kernel@vger.kernel.org, Dave Jones <davej@codemonkey.org.uk>,
       Alexander Viro <viro@math.psu.edu>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
In-Reply-To: <20021001191249.GJ15537@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.43.0210020124240.16927-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


EVMS is powerfull, but actually has a so ugly command line...
fortunatelly EVMS architecture command line could be exchanged...



On Tue, 1 Oct 2002, Matthias Andree wrote:

> Date: Tue, 1 Oct 2002 21:12:49 +0200
> From: Matthias Andree <matthias.andree@gmx.de>
> To: linux-kernel@vger.kernel.org
> Cc: Dave Jones <davej@codemonkey.org.uk>, venom@sns.it,
>      Alexander Viro <viro@math.psu.edu>,
>      Joe Thornber <joe@fib011235813.fsnet.co.uk>,
>      Linus Torvalds <torvalds@transmeta.com>
> Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
>
> On Tue, 01 Oct 2002, Dave Jones wrote:
>
> > On Tue, Oct 01, 2002 at 04:52:44PM +0200, venom@sns.it wrote:
> >  > A Logical Volume Manager is needed on Unix servers, and so it is needed
> >  > also on Linux.
> >  > If this LVM is obsoleted, then when will LVM2 be merged?
> >  > really we cannot have a 2.6 or 3.0 tree without a Volume Manager, it would
> >  > be a big fault.
> >
> > No-one suggested 2.6.0 shipping without /something/, but having a dead
> > LVM1 in _2.5_ doesn't help anyone. We've gone 6 months with it being in
> > a broken/uncompilable state, going another month without it isn't a big
> > deal. Getting something in before halloween is however a goal the
> > Sistina folks should be aiming for.
>
> How about EVMS kernel-space merge instead?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

