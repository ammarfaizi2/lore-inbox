Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284187AbRLROyy>; Tue, 18 Dec 2001 09:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284163AbRLROyh>; Tue, 18 Dec 2001 09:54:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6414 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284010AbRLROyZ>; Tue, 18 Dec 2001 09:54:25 -0500
Subject: Re: The direction linux is taking
To: dana.lacoste@peregrine.com (Dana Lacoste)
Date: Tue, 18 Dec 2001 15:04:13 +0000 (GMT)
Cc: linuz_kernel_q@hotmail.com ('Eyal Sohya'), linux-kernel@vger.kernel.org
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2A05@ottonexc1.ottawa.loran.com> from "Dana Lacoste" at Dec 18, 2001 06:32:55 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16GLmv-0007d4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 1. Are we satisfied with the source code control system ?
> 
> Yes.  Alan (2.2) and Marcelo (2.4) and Linus (2.5) are doing
> a good job with source control.

Not really. We do a passable job. Stuff gets dropped, lost, 
deferred and forgotten, applied when it conflicts with other work
- much of this stuff that software wouldnt actually improve on over a 
person

> Although this seems annoying, it's just one facet of the
> primary difference between Linux and a commercially based
> kernel : if you want to know how something works and how
> it's being developed, then you MUST participate, in this
> and other mailing lists.

That wont help you - most discussion occurs in private because l/k 
is too noisy and many key people dont read it.

> > 3. There is no central bug tracking database. At least people
> > should know the status of the bugs they have found with some
> > releases.
> 
> There is no central product, so there can be no central bug track.
> (see below)

Rubbish. Ask the engineering world about fault tracking. You won't get
"different products no central flaw tracking" you'll get extensive cross
correlation, statistical tools and the like in any syste, where reliability
matters

Many kernel bug reports end up invisible to some of the developers.

Alan
