Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264578AbRFPARU>; Fri, 15 Jun 2001 20:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264577AbRFPARK>; Fri, 15 Jun 2001 20:17:10 -0400
Received: from cx648115-a.blvue1.ne.home.com ([24.17.100.128]:26366 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S264578AbRFPARC>; Fri, 15 Jun 2001 20:17:02 -0400
Date: Fri, 15 Jun 2001 19:03:05 -0500 (CDT)
From: Thomas Molina <tmolina@home.com>
X-X-Sender: <tmolina@localhost.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rachel Greenham <rachel@linuxgrrls.org>, <linux-kernel@vger.kernel.org>
Subject: Re: VIA KT133A crash *post* 2.4.3-ac6
In-Reply-To: <E159qX2-0001WC-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106151858540.12619-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2001, Alan Cox wrote:

> > With DMA (UDMA Mode 5) enabled, my machine crashes on kernel versions
> > from 2.4.3-ac7 onwards up to 2.4.5 right up to 2.4.5-ac13. 2.4.3 vanilla
> > and 2.4.3-ac6 are completely stable. -ac7 of course is when a load of
> > VIA fixes were done. :-}
>
> Unfortunately there isnt a great deal I can do but say 'talk to VIA'.
>
> > With DMA (any setting, but UDMA mode 5 preferred of course) enabled, on
> > kernels 2.4.3-ac7 and onwards, random lockup on disk access within first
> > few minutes of use - sometimes very quickly after boot, sometimes as
> > much as ten minutes later given use. Running bonnie -s 1024 once or
>
> Yep. Lots of people see these. I even have people reporting it and not reporting
> it on the same board.
>
> Only known cure its to not use DMA.

So is there no correlation from particular hardware to problems reported?
I'm running the A7V133 with a Western Digital WD300BB UDMA 5 drive on
kernel 2.4.5 with no trouble.

