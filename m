Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270031AbRHMKJ3>; Mon, 13 Aug 2001 06:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270063AbRHMKJT>; Mon, 13 Aug 2001 06:09:19 -0400
Received: from mail1-gui.server.ntli.net ([194.168.222.13]:22498 "EHLO
	mail1-gui.server.ntli.net") by vger.kernel.org with ESMTP
	id <S270031AbRHMKJG>; Mon, 13 Aug 2001 06:09:06 -0400
Date: Mon, 13 Aug 2001 11:09:07 +0100
From: Chris Wilson <jakdaw@lists.jakdaw.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Are we going too fast?
Message-Id: <20010813110907.5555dde4.jakdaw@lists.jakdaw.org>
In-Reply-To: <20010813105554.A8387@se1.cogenit.fr>
In-Reply-To: <Pine.LNX.4.20.0108130303120.1037-100000@eriador.mirkwood.net>
	<20010813105554.A8387@se1.cogenit.fr>
Organization: Hah!
X-Mailer: Sylpheed version 0.5.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > until 2.2.10!).  Furthermore, I have had a HELL of a time trying
> > to get responses to the first two problems (this is the first report
for
> > the third).  It used to be that I could ask a question on this list,
and
> > receive responses.  Not anymore.  I can't seem to get the time of day
from
> > anyone on this list now.
> 
> Try and send specific bug-reports to the maintainers. 
> l-k archives may give you some light on issues with VIA chipsets.
> 
> I'm not convinced that gaining stability on a VIA + G400 + X + smp 
> combo is an easy task anyway.

Certainly seems to be moving backwards in that respect - from 2.4.6
onwards the bog standard PS/2 keyboard does not work (at all from bootup -
"keyboard: Timeout - AT keyboard not present?(ed)") on my SMP VIA w. G400
(although I've not got as far as loading X on it without the keyboard!) :(

I can't even see what's changed in 2.4.6 that might cause this - soft_irq?
or is that completely unrelated to the keyboard???


Chris
